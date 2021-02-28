//
//  EditProfileVC.swift
//  IDEHospital
//
//  Created by bido elbasha on 15/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit
protocol EditProfileVCProtcol: class{
    func showErrorAlert(massage: String)
    func showDataOnTextField(userData: getUserModel)
    func showSuccesAlert()
    
}


class EditProfileVC: UIViewController {
    //MARK:- properties
    //outlets
    @IBOutlet weak var editProvileView: EditProfileView!
    //Variables
      private var viewModel : EditProfileViewModelprotocol!
    //MARK:- life cycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        editProvileView.setupView(view: editProvileView)
        setupNavController(title: L10n.editProfile, settingColor: false)
        setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: false)
        viewModel.getUserData()
        // Do any additional setup after loading the view.
    }
    

    //MARK:- Public Methods
    class func create() -> EditProfileVC {
        let editProfileVC: EditProfileVC = UIViewController.create(storyboardName: Storyboards.editProfile, identifier: ViewControllers.editProfileVC)
        editProfileVC.viewModel = EditProfileViewModel(view: editProfileVC)
           return editProfileVC
    }
    //Mark:- buttons
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        viewModel.editProfile(userName: editProvileView.yourNameTextField.text ?? "", userEmail: editProvileView.yourEmailTextField.text ?? "", mobile: editProvileView.yourphoneTextField.text ?? "", oldPassword: editProvileView.yourOldPasswordTextField.text ?? "", newPassword: editProvileView.yourNewPasswordTextField.text ?? "", confirmPassword: editProvileView.yourConfirmPasswordTextField.text ?? "")
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.popUpCurrent()
    }
}
//MARK:-protocols extension
//View protocol
extension EditProfileVC: EditProfileVCProtcol{
    func showErrorAlert(massage: String) {
        showPopUp(type: .failure(massage), Okbutton: .dismissCurrent)
    }
    func showSuccesAlert(){
        showPopUp(type: .success(L10n.yourDataHasBeenEditSuccessfully), Okbutton: .delegation, delegate: self)
    }
    func showDataOnTextField(userData: getUserModel) {
        self.editProvileView.setUpDataForTextField(userData: userData)
    }
    

}
//Delgate execution
extension EditProfileVC: SuccessDelegate{
    
    func okPressed() {
        self.popUpCurrent()
    }
}
