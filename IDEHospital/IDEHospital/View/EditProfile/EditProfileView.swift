//
//  EditProfileView.swift
//  IDEHospital
//
//  Created by bido elbasha on 15/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

class EditProfileView: UIView {
    //MARK:-properties
    //putlets
    @IBOutlet weak var yourNameTextField: CommonTextField!
    @IBOutlet weak var yourEmailTextField: CommonTextField!
    @IBOutlet weak var yourphoneTextField: CommonTextField!
    @IBOutlet weak var yourOldPasswordTextField: CommonTextField!
    @IBOutlet weak var yourNewPasswordTextField: CommonTextField!
    @IBOutlet weak var yourConfirmPasswordTextField: CommonTextField!
    @IBOutlet weak var saveButton: CommonUIButton!
    @IBOutlet weak var cancelButton: CommonUIButton!
    
    // MARK:- Public Methods
    //setup the views
    func setupView(view: UIView) {
        setupBackground()
        setupTextField()
        self.saveButton.setUPUIButton(backGroundColor: ColorName.darkRoyalBlue.color, titleOfTheButton: "Save", sizeOfTheFont: 15)
        self.cancelButton.setUPUIButton(backGroundColor: ColorName.richPurple.color, titleOfTheButton: "Cancel", sizeOfTheFont: 15)
    }
    //setup text for text fields
    func  setUpDataForTextField(userData: getUserModel){
        yourNameTextField.text = userData.name
        yourEmailTextField.text = userData.email
        yourphoneTextField.text = userData.mobile
        yourOldPasswordTextField.text = "123456"
        
    }
}
//MARK:- private Func
extension EditProfileView{
   // setup ui
    private func setupTextField() {
        yourNameTextField.setup(leftImage: Asset.component111.image, placeholder: L10n.yourName)
        yourEmailTextField.setup(leftImage: Asset.component81.image, placeholder: L10n.yourEmail)
        yourphoneTextField.setup(leftImage: Asset.component131.image, placeholder: L10n.mobileNumber)
        yourOldPasswordTextField.setup(leftImage: Asset.component91.image, placeholder: L10n.choosePassword)
        yourOldPasswordTextField.isSecureTextEntry = true
        yourNewPasswordTextField.setup(leftImage: Asset.component91.image, placeholder: "New Password")
        yourNewPasswordTextField.isSecureTextEntry = true
        yourConfirmPasswordTextField.setup(leftImage: Asset.component91.image, placeholder: L10n.confirmPassword)
        yourConfirmPasswordTextField.isSecureTextEntry = true
        yourphoneTextField.keyboardType = .numberPad
    }
    
}

