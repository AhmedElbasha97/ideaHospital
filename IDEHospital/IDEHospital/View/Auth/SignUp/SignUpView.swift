//
//  SignUpView.swift
//  IDEHospital
//
//  Created by Kamal on 12/27/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    
    @IBOutlet weak var nameTextField: CommonTextField!
    @IBOutlet weak var emailTextField: CommonTextField!
    @IBOutlet weak var mobileTextField: CommonTextField!
    @IBOutlet weak var passwordTextField: CommonTextField!
    @IBOutlet weak var confirmPasswordTextField: CommonTextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var termsButton: UIButton!
    
    
    func setupView() {
        setupBackground()
        setupnuderlined()
        setupTextField()
        setupLabel()
        setupButton(button: signUpButton, titleOfTheButton: L10n.signUp, sizeOfTheFont: 20, color: ColorName.darkRoyalBlue.color)
    }
    
    private func setupTextField() {
        nameTextField.setup(leftImage: Asset.component111.image, placeholder: L10n.yourName)
        emailTextField.setup(leftImage: Asset.component81.image, placeholder: L10n.yourEmail)
        mobileTextField.setup(leftImage: Asset.component131.image, placeholder: L10n.mobileNumber)
        passwordTextField.setup(leftImage: Asset.component91.image, placeholder: L10n.choosePassword)
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.setup(leftImage: Asset.component91.image, placeholder: L10n.confirmPassword)
        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    private func setupLabel() {
        mainLabel.text = L10n.terms
        mainLabel.textAlignment = .center
        mainLabel.textColor = ColorName.white.color
        mainLabel.font = FontFamily.PTSans.regular.font(size: 12)
        mainLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setupButton(button: UIButton, titleOfTheButton: String, sizeOfTheFont: CGFloat, color: UIColor ) {
        button.backgroundColor = color
        button.layer.cornerRadius = button.frame.height / 4
        button.layer.borderWidth = 0
        button.setTitle("\(titleOfTheButton)", for: .normal)
        button.titleLabel?.font = FontFamily.PTSans.bold.font(size: sizeOfTheFont)
        button.setTitleColor(ColorName.white.color, for:UIControl.State.normal)
    }
    
    private func setupnuderlined() {
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: FontFamily.PTSans.bold.font(size: 12),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: L10n.termsConditions,
                                                        attributes: yourAttributes)
        termsButton.setAttributedTitle(attributeString, for: .normal)
    }
    
}
