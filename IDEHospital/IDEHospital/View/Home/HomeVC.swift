//
//  ViewController.swift
//  IDEHospital
//
//  Created by ahmedElbasha on 06/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit
import Foundation

//MARK:- home protcol
protocol HomeVCProtcol: class {
    
    func showloader()
    func hideLoader()
    func showingAlerts(errorMassage: String)
    func reloadData()
    func goToSearchScreen(id: Int)
    func goToNurseScreen()

}

class HomeVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var homeView: HomeView!
    
    // MARK:- Properties
    var viewModel: HomeViewModelProtocol!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HomeViewModel(view: self)
        homeView.setUp(view: self.homeView)
        viewModel.getAllHomeData()
        self.setupNavController(title: L10n.chooseServices, settingColor: false)
        setUpCollectionView()
        self.navigationItem.setHidesBackButton(true, animated: true)
        print("\(UserDefaultsManager.shared().token ?? "")")
    }
    override func viewWillAppear(_ animated: Bool) {
         self.setupNavController(title: L10n.chooseServices, settingColor: false)
    }
    
    // MARK:- Public Methods
    class func create() -> HomeVC {
        let homeVC: HomeVC = UIViewController.create(storyboardName: Storyboards.main, identifier:
            ViewControllers.homeVC)
        return homeVC
    }
}

//MARK:- setSubViews
extension HomeVC{
    
    //MARK:- set up collection view
    private func setUpCollectionView(){
        homeView.homeCollectionView.register(UINib(nibName: Cells.homeCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Cells.homeCollectionViewCell)
        
        homeView.homeCollectionView.delegate = self
        homeView.homeCollectionView.dataSource = self
    }
    
}

// MARK:- Code for collectionview
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getHomeViewCount()
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = homeView.homeCollectionView.dequeueReusableCell(withReuseIdentifier: Cells.homeCollectionViewCell, for: indexPath) as? HomeCollectionViewCell else {return UICollectionViewCell ()}
      
      
        cell.configure(data: viewModel.setUpCategoryView(index: indexPath.item))
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
        viewModel.goToOtherScreens(id: indexPath.item)
    }
    
}

//MARK:- CONFORM PROTCOL
extension HomeVC: HomeVCProtcol{
    
    func goToSearchScreen(id:Int) {
        let tabBarVC = TabBarVC.create(with: id)
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
    
    func goToNurseScreen() {
        let homeNurseVC = HomeNurseVC.create(gotoContactUs: false)
        navigationController?.pushViewController(homeNurseVC, animated: true)
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
        self.homeView.homeCollectionView.reloadData()
    }
    
}

