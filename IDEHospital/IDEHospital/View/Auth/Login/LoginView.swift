//
//  LoginView.swift
//  IDEHospital
//
//  Created by Kamal on 12/27/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

class LoginView: UIView {
    //MARK:- Outlets
    @IBOutlet weak var emailTextField: CommonTextField!
    @IBOutlet weak var passwordTextField: CommonTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var dontHaveAccLabel: UILabel!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK:- Public Methods
    func setupLoginView() {
        setupButton(button: loginButton, titleOfTheButton: L10n.login, sizeOfTheFont: 20, color: ColorName.darkRoyalBlue.color)
        setupButton(button: signUpButton, titleOfTheButton: L10n.signUp, sizeOfTheFont: 20, color: ColorName.steelGrey.color)
        setupTextField()
        setupBackground()
        setupLabel()
        setupForgetPasswordBtn()
    }
    
    //MARK:- Private Methods
    private func setupTextField() {
        emailTextField.setup(leftImage: Asset.component81.image, placeholder: L10n.yourEmail)
        passwordTextField.setup(leftImage: Asset.component91.image, placeholder: L10n.enterPassword)
        passwordTextField.isSecureTextEntry = true
    }
    
    private func setupButton(button: UIButton, titleOfTheButton: String, sizeOfTheFont: CGFloat, color: UIColor ) {
        button.backgroundColor = color
        button.layer.cornerRadius = button.frame.height / 4
        button.layer.borderWidth = 0
        button.setTitle("\(titleOfTheButton)", for: .normal)
        button.titleLabel?.font = FontFamily.PTSans.bold.font(size: sizeOfTheFont)
        button.setTitleColor(ColorName.white.color, for:UIControl.State.normal)
    }
    
    private func setupLabel() {
        dontHaveAccLabel.text = L10n.donTHaveAccount
        dontHaveAccLabel.textAlignment = .center
        dontHaveAccLabel.textColor = ColorName.white.color
        dontHaveAccLabel.font = FontFamily.PTSans.regular.font(size: 12)
        dontHaveAccLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setupForgetPasswordBtn() {
        forgetPasswordButton.setTitle(L10n.forgetPassword, for: .normal)
        forgetPasswordButton.titleLabel?.font = FontFamily.PTSans.bold.font(size: 12)
        forgetPasswordButton.setTitleColor(ColorName.white.color, for: UIControl.State.normal)
    }
    
}
