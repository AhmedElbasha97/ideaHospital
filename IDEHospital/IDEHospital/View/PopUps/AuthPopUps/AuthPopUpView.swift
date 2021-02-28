//
//  SignUpPopUpView.swift
//  IDEHospital
//
//  Created by Kamal on 1/14/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

class AuthPopUpView: UIView {
    //MARK:- Outlets
    //Main Views
    @IBOutlet weak var signUpPopView: UIView!
    @IBOutlet weak var loginPopView: UIView!
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    //signUp Outlets
    @IBOutlet weak var nameTextField: CommonTextField!
    @IBOutlet weak var emailTextField: CommonTextField!
    @IBOutlet weak var mobileNumberTextField: CommonTextField!
    @IBOutlet weak var passwordTextField: CommonTextField!
    @IBOutlet weak var voucherLabel: UILabel!
    @IBOutlet weak var voucherTextField: UITextField!
    @IBOutlet weak var voucherButton: UIButton!
    @IBOutlet weak var bookForAnotherLabel: UILabel!
    @IBOutlet weak var bookForAnotherTextField: UITextField!
    @IBOutlet weak var bookForAnotherButton: UIButton!
    @IBOutlet weak var signUpAndBookButton: UIButton!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var termsAndConditionButton: UIButton!
    //login Outlets
    @IBOutlet weak var loginEmailTextField: CommonTextField!
    @IBOutlet weak var loginPasswordTextField: CommonTextField!
    @IBOutlet weak var loginVoucherLabel: UILabel!
    @IBOutlet weak var loginVoucherButton: UIButton!
    @IBOutlet weak var loginBookLabel: UILabel!
    @IBOutlet weak var loginVoucherTextField: UITextField!
    @IBOutlet weak var loginBookForAnotherButton: UIButton!
    @IBOutlet weak var loginBookForAnotherTextField: UITextField!
    @IBOutlet weak var loginAndBookButton: UIButton!
    @IBOutlet weak var loginTermsLabel: UILabel!
    @IBOutlet weak var loginTermsAndConditionButton: UIButton!
    
    //MARK:- Public Methods
    func setupView() {
        self.layoutSubviews()
        self.backgroundColor = ColorName.brownishGrey.color.withAlphaComponent(0.8)
        setupBackgroundImageView()
        setupTextFields()
        setupLabel(label: voucherLabel, text: L10n.iHaveAVoucherCode, isBold: true)
        setupLabel(label: bookForAnotherLabel, text: L10n.bookForAnotherPerson, isBold: true)
        setupLabel(label: termsLabel, text: L10n.byClickingSignUpYouAgreeToOur, isBold: false)
        setupLabel(label: loginVoucherLabel, text:  L10n.iHaveAVoucherCode, isBold: true)
        setupLabel(label: loginTermsLabel, text: L10n.byClickingSignUpYouAgreeToOur, isBold: false)
        setupLabel(label: loginBookLabel, text:L10n.bookForAnotherPerson, isBold: true)
        setupImageCheckBoxes(button: voucherButton)
        setupImageCheckBoxes(button: loginVoucherButton)
        setupImageCheckBoxes(button: bookForAnotherButton)
        setupImageCheckBoxes(button: loginBookForAnotherButton)
        setupUnderLinedTextField(textField: voucherTextField, placeholder: L10n.enterCode)
        setupUnderLinedTextField(textField: bookForAnotherTextField, placeholder: L10n.enterName)
        setupUnderLinedTextField(textField: loginVoucherTextField, placeholder: L10n.enterCode)
        setupUnderLinedTextField(textField: loginBookForAnotherTextField, placeholder: L10n.enterName)
        setupBookingButtons(button: signUpAndBookButton, title: L10n.signUpBook)
        setupBookingButtons(button: loginAndBookButton, title: L10n.loginBook)
        setupMainButtons(button: loginButton, title: L10n.login, corner: .topRight)
        setupMainButtons(button: signUpButton, title: L10n.register, corner: .topLeft)
        cancelButton.setImage(Asset.component67.image, for: .normal)
        cancelButton.tintColor = .white
        setupUnderLined(button: termsAndConditionButton)
        setupUnderLined(button: loginTermsAndConditionButton)
        voucherTextField.isHidden = true
        loginVoucherTextField.isHidden = true
        bookForAnotherTextField.isHidden = true
        loginBookForAnotherTextField.isHidden = true
        passwordTextField.isSecureTextEntry = true
        loginPasswordTextField.isSecureTextEntry = true
        mobileNumberTextField.keyboardType = .numberPad
                self.layoutIfNeeded()

    }
    
    func setupMainButton(loginIsSelected: Bool = false, registerIsSelected: Bool = true) {
        signUpButton.isSelected = registerIsSelected
        loginButton.isSelected = loginIsSelected
        
    }
    
    func setupSignUpButtonWhenTapped() {
        self.signUpButton.backgroundColor = ColorName.white.color
        self.signUpButton.setTitleColor(ColorName.darkRoyalBlue.color, for: UIControl.State.normal)
        self.cancelButton.tintColor = ColorName.white.color
        self.loginButton.setTitleColor(ColorName.white.color, for: UIControl.State.normal)
        self.loginButton.backgroundColor = .clear
    }
    
    func setupLoginButtonWhenTapped() {
        self.loginButton.backgroundColor = ColorName.white.color
        self.loginButton.setTitleColor(ColorName.darkRoyalBlue.color, for: UIControl.State.normal)
        self.cancelButton.tintColor = ColorName.darkRoyalBlue.color
        self.signUpButton.backgroundColor = .clear
        self.signUpButton.setTitleColor(ColorName.white.color, for: UIControl.State.normal)

    }

    
    //MARK:- Private Methods
    private func setupBackgroundImageView() {
        backGroundImageView.image = Asset.component72.image
        backGroundImageView.roundCorners([.topRight, .topLeft], radius: 20)
    }
    
    private func setupTextFields() {
        nameTextField.setup(leftImage: Asset.nameLogo.image, placeholder: L10n.yourName)
        emailTextField.setup(leftImage: Asset.component81.image, placeholder: L10n.yourEmail)
        mobileNumberTextField.setup(leftImage: Asset.component131.image, placeholder: L10n.mobileNumber)
        passwordTextField.setup(leftImage: Asset.component91.image, placeholder: L10n.choosePassword)
        loginEmailTextField.setup(leftImage: Asset.component81.image, placeholder: L10n.yourEmail)
        loginPasswordTextField.setup(leftImage: Asset.component91.image, placeholder: L10n.enterPassword)
    }
    
    private func setupLabel(label: UILabel, text: String, isBold: Bool) {
        label.text = text
        label.textAlignment = .center
        label.textColor = ColorName.white.color
        label.adjustsFontSizeToFitWidth = true
        if isBold {
            label.font = FontFamily.PTSans.bold.font(size: 12)
        } else {
            label.font = FontFamily.PTSans.regular.font(size: 12)
        }
    }
    
    private func setupImageCheckBoxes(button: UIButton) {
        button.setImage(Asset.rectangle1798.image, for: .normal)
        button.tintColor = .white
    }
    
    private func setupUnderLinedTextField(textField: UITextField, placeholder: String) {
        textField.textColor = ColorName.white.color
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: ColorName.white.color, NSAttributedString.Key.font: UIFont(font: FontFamily.PTSans.bold, size: 12)!])
    }
    
    private func setupBookingButtons(button: UIButton, title: String) {
        button.backgroundColor = ColorName.darkRoyalBlue.color
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = button.frame.height / 5
        button.titleLabel?.font = FontFamily.PTSans.bold.font(size: 17)
        button.setTitleColor(ColorName.white.color, for: .normal)
    }
    
    private func setupUnderLined(button: UIButton) {
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: FontFamily.PTSans.bold.font(size: 12),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: L10n.termsConditions,
                                                        attributes: yourAttributes)
        button.setAttributedTitle(attributeString, for: .normal)
    }
    
    private func setupMainButtons(button: UIButton, title: String, corner: UIRectCorner) {
        button.roundCorners(corner, radius: 20.0)
        signUpButton.backgroundColor = .white
        button.setTitle(title, for: .normal)
        signUpButton.setTitleColor(ColorName.darkRoyalBlue.color, for: UIControl.State.normal)
        button.titleLabel?.font = FontFamily.PTSans.bold.font(size: 20)

    }
    
    
}
