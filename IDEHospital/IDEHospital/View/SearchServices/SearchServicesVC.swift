//
//  ViewController.swift
//  IDEHospital
//
//  Created by ahmedElbasha on 06/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit
import IQKeyboardManager

protocol SearchServicesProtocol: class {
    func showAlert(message: String)
    func showItems()
    func addSelectedItem(_ viewWithTag: Int, _ item: String)
    func clearTextField(with tag: Int)
    func doneButtonEnabled(_ enabled: Bool, for tag: Int)
    func goToSearchResultVC(doctorFilter: DoctorsFilter)
}

class SearchServicesVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet var searchServicesView: SearchServicesView!
    
    //MARK:- Properties
    var viewModel: SearchServicesViewModelProtocol!
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchServicesView.setupView()
        setupPicker()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
        SetTabBar()
      }
    //MARK:- IBActions
     @IBAction func findDoctorButton(_ sender: Any) {
         viewModel.findDoctorTapped(doctorName: searchServicesView.doctorNameTxtField.text)
     }
    
    // MARK:- Public Methods
    class func create(categoryID: Int) -> SearchServicesVC {
        let searchServicesVC: SearchServicesVC = UIViewController.create(storyboardName: Storyboards.SearchServices, identifier: ViewControllers.SearchServicesVC)
        searchServicesVC.viewModel = SearchServicesViewModel(view: searchServicesVC)
        searchServicesVC.viewModel.prepareCategories(with: categoryID)
        return searchServicesVC
    }
    
    // MARK:- Objc Methods
    @objc private func doneTapped(_ sender: UIBarButtonItem) {
        viewModel.itemSelected(tag: sender.tag,row: searchServicesView.pickerView.selectedRow(inComponent: 0))
    }
}

//MARK:- Private Methods
extension SearchServicesVC {
    private func setupPicker() {
        self.searchServicesView.chooseCityTxtField.delegate = self
        self.searchServicesView.chooseCompanyTxtField.delegate = self
        self.searchServicesView.chooseRegionTextField.delegate = self
        self.searchServicesView.chooseSpecialityTxtField.delegate = self
        self.searchServicesView.pickerView.delegate = self
        self.searchServicesView.pickerView.dataSource = self
        
    }
    private func setupNavigation() {
        self.setupNavController(title: L10n.servicesSearch, settingColor: false)
        self.setupNavigationItems(backAction: .dismissCurrent, haveSettingBTN: true)
    }
    
    private func SetTabBar(){
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 0
    }
}

//MARK:- UIPicker Data Source
extension SearchServicesVC: UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.itemsCount()
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.getItem(row: row)
    }
}

//MARK:- Search Services VC Protocol
extension SearchServicesVC: SearchServicesProtocol {
    func goToSearchResultVC(doctorFilter: DoctorsFilter) {
           let searchResult = SearchResultVC.create(doctorFilter: doctorFilter)
           navigationController?.pushViewController(searchResult, animated: true)
       }
    
    func doneButtonEnabled(_ enabled: Bool, for tag: Int) {
        let textField = self.searchServicesView.viewWithTag(tag) as! UITextField
        textField.keyboardToolbar.doneBarButton.isEnabled = enabled
    }
    
    func addSelectedItem(_ viewWithTag: Int, _ item: String) {
        let textField = self.searchServicesView.viewWithTag(viewWithTag) as! UITextField
        textField.text = item
    }
    
    func showItems() {
        self.searchServicesView.pickerView.reloadAllComponents()
    }
    
    func showAlert(message: String) {
        openAlert( message: message)
    }
    
    func clearTextField(with tag: Int) {
        let textField = self.searchServicesView.viewWithTag(tag) as! UITextField
        textField.text = ""
    }
}

// MARK:- TextField Delegate
extension SearchServicesVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        viewModel.preparePickerItems(with: textField.tag)
        textField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneTapped(_:)))
        return true
    }
}
