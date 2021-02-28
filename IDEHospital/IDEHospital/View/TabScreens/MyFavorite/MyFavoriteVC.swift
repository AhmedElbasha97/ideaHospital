//
//  MyFavoriteVC.swift
//  IDEHospital
//
//  Created by bido elbasha on 15/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit
//MARK:- favorite protcol
protocol MyFavoriteVCProtcol: class {
    func showloader()
    func hideLoader()
    func showingAlerts(errorMassage: String)
    func reloadData()
    func showNoData(label1: String)
    func setUPNavBarComeFromHome(haveSettingBTN: Bool)
    func setUpTabBar()
    func setUPNavBarComeFromSettings(haveSettingBTN: Bool) 

}

class MyFavoriteVC: UIViewController {
    
    //MARK:- properties
    //outLets
    @IBOutlet weak var myFavoriteView: MyFavoriteView!
    //variables
    private var viewModel: FavoriteViewModelProtcol!
    private var cellHieght: CGFloat = 265
      
    //MARK:- life cycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        myFavoriteView.setUp(view: self.myFavoriteView)
        setUpTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.setUPNavBar()
        self.viewModel.getDataToFavoriteTable()
      }
    // MARK:- Public Methods
    class func create(comeFromSettings: Bool) -> MyFavoriteVC {
        let myFavoriteVC: MyFavoriteVC = UIViewController.create(storyboardName: Storyboards.tabScreens, identifier:
            ViewControllers.myFavoriteVC)
        myFavoriteVC.viewModel = FavoriteViewModel(view: myFavoriteVC)
        myFavoriteVC.viewModel.navugateFromWhere(comeFromSettings: comeFromSettings)
        return myFavoriteVC
    }
}
//MARK:- private func
extension MyFavoriteVC{
    
    private func setUpTableView(){
        myFavoriteView.favoriteTableView.register(UINib(nibName: Cells.favoriteTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.favoriteTableViewCell)
        myFavoriteView.favoriteTableView.dataSource = self
        myFavoriteView.favoriteTableView.delegate = self
    }
    
    private func SetTabBar(){
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 1
    }
    
    private func setupNavigation(haveSettingBTN: Bool, back: Back) {
        self.setupNavController(title: L10n.myFavorites, settingColor: false)
        self.setupNavigationItems(backAction: back, haveSettingBTN: haveSettingBTN)
    }
    
}
//MARk:- table view protcols
extension MyFavoriteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return viewModel.numberOfCells()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.myFavoriteView.favoriteTableView.dequeueReusableCell(withIdentifier: Cells.favoriteTableViewCell , for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        
        cell.SendDataToViewModel(cell: viewModel.getDataOdTheCell(index: indexPath.row), index: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.myFavoriteView.favoriteTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHieght
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel.detectLastItem(index: indexPath.row)
        print(self.viewModel.numberOfCells())
    }
    
}
//MARK:- conform delegate
extension MyFavoriteVC: favoriteTableVIewCellDelegate {
    
    func removeFromFavoriteTable(doctorID: Int, index: Int) {
        self.viewModel.removeFromFavorite(id: doctorID, index: index)
    }
    
    func booking(doctorID: Int) {
   
            navigationController?.pushViewController(DoctorProfileVC.create(id: doctorID), animated: true)
    }
    
    
}
extension MyFavoriteVC: MyFavoriteVCProtcol {
    func showNoData(label1: String) {
           self.myFavoriteView.noDataLabe.isHidden = true
    }
    func showloader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func showingAlerts(errorMassage: String) {
        showPopUp(type: .failure(errorMassage))
    }
    
    func reloadData() {
        myFavoriteView.favoriteTableView.reloadData()
    }
     
    func setUPNavBarComeFromHome(haveSettingBTN: Bool) {
        setupNavigation(haveSettingBTN: haveSettingBTN, back: .dismissCurrent)
    }
    
    func setUpTabBar() {
        SetTabBar()
    }
    
    func setUPNavBarComeFromSettings(haveSettingBTN: Bool) {
        setupNavigation(haveSettingBTN: haveSettingBTN, back: .popUpCurrent)
    }
}
