//
//  SearchResultVC.swift
//  IDEHospital
//
//  Created by Kamal on 12/20/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

protocol SearchResultProtocol: class {
    func showloader()
    func hideLoader()
    func reloadData()
    func showAlert(message: String)
    func showSortType(sortType: String)
    func showNoData(label1: String)
     
}

class SearchResultVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet var searchResultView: SearchResultView!
    
    //MARK:- Properties
    var viewModel: SearchResultViewModel!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultView.setUp(view: searchResultView)
        setUpTableView()
        setupPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.searchForDoctors()
        self.setupNavController(title: L10n.searchResult, settingColor: false)
        self.setupNavigationItems(backAction: .dismissCurrent, haveSettingBTN: true)
    }
    
    // MARK:- Public Methods
    class func create(doctorFilter: DoctorsFilter) -> SearchResultVC {
        let searchResult: SearchResultVC = UIViewController.create(storyboardName: Storyboards.searchResultVC, identifier:
            ViewControllers.searchResultVC)
        searchResult.viewModel = SearchResultViewModel(view: searchResult, doctorsFilter: doctorFilter)
        return searchResult
    }
    
    @objc func doneTapped(_ sender: UIBarButtonItem) {
        viewModel.sortTypeSelected(row: searchResultView.pickerView.selectedRow(inComponent: 0) )
    }
    
}

//MARK:- private func
extension SearchResultVC {
    private func setUpTableView(){
        searchResultView.searchResultsTableView.register(UINib(nibName: Cells.SearchResultCell, bundle: nil), forCellReuseIdentifier: Cells.SearchResultCell)
        searchResultView.searchResultsTableView.dataSource = self
        searchResultView.searchResultsTableView.delegate = self
    }
    
    private func SetTabBar(){
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 0
    }
    
    private func setupPicker() {
        searchResultView.sortByTextField.delegate = self
        self.searchResultView.pickerView.delegate = self
        self.searchResultView.pickerView.dataSource = self
    }
}

//MARK:- UIPicker Data Source
extension SearchResultVC: UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.getSortTypes().count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.getSortTypes()[row]
        
    }
}

extension SearchResultVC: SearchResultProtocol {
    func showNoData(label1: String) {
        self.searchResultView.noSearchResult.isHidden = true
    }
    
    func showSortType(sortType:String)  {
        searchResultView.sortByTextField.text = ("   Sort By  \(sortType)")
    }
    
    func showloader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func showAlert( message: String) {
        openAlert(message: message)
    }
    
    func reloadData() {
        searchResultView.searchResultsTableView.reloadData()
    }
}

extension SearchResultVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.searchResultView.searchResultsTableView.dequeueReusableCell(withIdentifier: Cells.SearchResultCell , for: indexPath) as? SearchResultCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.configure(doctor: viewModel.getItem(for: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 256.5
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willDisplay(indexPath.row)
    }
}

// MARK:- TextField Delegate
extension SearchResultVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneTapped(_:)))
        
        return true
        
    }
}

extension SearchResultVC: CellDelegate {
    func goToDoctorProfile(id: Int) {
        self.navigationController?.pushViewController(DoctorProfileVC.create(id: id), animated: true)
    }
    
    func favAlert(tableViewCell: UITableViewCell) {
        guard let indexPath = searchResultView.searchResultsTableView.indexPath(for: tableViewCell) else { return }
        if UserDefaultsManager.shared().token == nil {
            showPopUp(type: .failure(L10n.youNeedToBeLoggedInToBook))
        } else {
            viewModel.removeFromFavorites(with: indexPath.row)
        }
    }
}

