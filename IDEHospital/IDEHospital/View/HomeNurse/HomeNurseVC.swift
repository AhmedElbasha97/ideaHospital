//
//  HomeNurseVCViewController.swift
//  IDEHospital
//
//  Created by Kamal on 12/16/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

protocol HomeNurseProtocol: class {
//    func dismissVC()
    func navSetUp(title: String, haveSettingBTN: Bool)
    func usedLabel(contactLabel: String, mainLabel: String)
    func popUpAlert(popUp: PopUpType)
    func popUpFailure(popUp: PopUpType)
}

class HomeNurseVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet var homeNurseView: HomeNurseView!
    var viewModel: HomeNurseViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.setUpTheDataOfTheView()
    }
    
    // MARK:- Public Methods
    class func create(gotoContactUs: Bool) -> HomeNurseVC {
        let homeNurseVC: HomeNurseVC = UIViewController.create(storyboardName: Storyboards.homeNurse, identifier:
            ViewControllers.homeNurseVC)
        homeNurseVC.viewModel = homeNurseViewModel(view: homeNurseVC)
        homeNurseVC.viewModel.decideWhatToShoew(gotoContactUs: gotoContactUs)
        return homeNurseVC
    }
    
    
    @IBAction func sendRequest(_ sender: UIButton) {
        viewModel.requestDone(name: homeNurseView.nameTextField.text ?? "" , email: homeNurseView.emailTextField.text ?? "", number: homeNurseView.mobileNumberTextField.text ?? "", message: homeNurseView.detailTextView.text)
    }
}

//MARK:- Private Methods
extension HomeNurseVC {
    private func setupNavigation() {
        
    }
}

extension HomeNurseVC: HomeNurseProtocol {
    func navSetUp(title: String, haveSettingBTN: Bool) {
        setupNavController(title: title, settingColor: false)
        setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: haveSettingBTN)
    }
    
    func usedLabel(contactLabel: String, mainLabel: String) {
        self.homeNurseView.setupNurseView(mainLabel: mainLabel, contactUsLabel: contactLabel )
    }
    
//    func dismissVC() {
//        navigationController?.pushViewController(HomeVC.create(), animated: true)
//    }
    
    func popUpAlert(popUp: PopUpType) {
        showPopUp(type: popUp, Okbutton: .goToHome)
    }
    
    func popUpFailure(popUp: PopUpType) {
        showPopUp(type: popUp, Okbutton: .dismissCurrent)
    }
    
}





