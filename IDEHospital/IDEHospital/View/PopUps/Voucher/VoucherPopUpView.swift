//
//  VoucherPopUp.swift
//  IDEHospital
//
//  Created by Kamal on 1/2/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

class VoucherPopUpView: UIView {
    //MARK:- Outlets
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var MainLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var enterCodeTextField: UITextField!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var lineView2: UIView!
    @IBOutlet weak var yesLabel2: UILabel!
    @IBOutlet weak var noLabel2: UILabel!
    @IBOutlet weak var enterNameTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var firstSwitch: UISwitch!
    @IBOutlet weak var secondSwitch: UISwitch!
    
    //MARK:- Public Methods
    func setupView() {
        setupLabel(label: MainLabel, text: L10n.doYouHaveAVoucherCode)
        setupLabel(label: secondaryLabel, text: L10n.areYouBookingForAnotherPerson)
        setupLabel(label: yesLabel, text: L10n.yes)
        setupLabel(label: noLabel, text: L10n.no)
        setupLabel(label: yesLabel2, text: L10n.yes)
        setupLabel(label: noLabel2, text: L10n.no)
        setupButton(button: continueButton, titleOfTheButton: L10n.continue, sizeOfTheFont: 15, color: ColorName.darkRoyalBlue.color)
        setupTextField(textField: enterCodeTextField, placeHolder: L10n.enterCode)
        setupTextField(textField: enterNameTextField, placeHolder: L10n.enterName)
        setupSwitch(button: firstSwitch)
        setupSwitch(button: secondSwitch)
        setuplineView(view: lineView)
        setuplineView(view: lineView2)
        popView.layer.cornerRadius = popView.frame.height / 19
        self.backgroundColor = ColorName.brownishGrey.color.withAlphaComponent(0.8)
    }
    
    //MARK:- Private Methods
    private func setupLabel(label: UILabel, text: String) {
        label.text = text
        label.textAlignment = .center
        label.textColor = ColorName.darkRoyalBlue.color
        label.font = FontFamily.PTSans.bold.font(size: 15)
        label.adjustsFontSizeToFitWidth = true
    }
    
    private func setupButton(button: UIButton, titleOfTheButton: String, sizeOfTheFont: CGFloat, color: UIColor ) {
        button.backgroundColor = color
        button.layer.cornerRadius = button.frame.height / 2.5
        button.layer.borderWidth = 0
        button.setTitle("\(titleOfTheButton)", for: .normal)
        button.titleLabel?.font = FontFamily.PTSans.bold.font(size: sizeOfTheFont)
        button.setTitleColor(ColorName.white.color, for:UIControl.State.normal)
    }
    
    private func setupTextField(textField: UITextField, placeHolder: String) {
        textField.layer.cornerRadius = textField.frame.height / 4
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes:[NSAttributedString.Key.foregroundColor: ColorName.blackTwo.color, NSAttributedString.Key.font: FontFamily.PTSans.regular.font(size: 15)])
        textField.layer.borderColor = CGColor(srgbRed: 0, green: 24/255, blue: 103/255, alpha: 1)
        textField.layer.borderWidth = 1.0
        
    }
    
    private func setupSwitch(button: UISwitch) {
        button.onTintColor = ColorName.darkRoyalBlue.color
        button.thumbTintColor = ColorName.white.color
        button.transform = CGAffineTransform(scaleX: -0.75, y: 0.75)
        firstSwitch.isSelected = true
        button.transform = CGAffineTransform(scaleX: -0.75, y: 0.75)
    }
    
    private func setuplineView(view: UIView) {
        view.backgroundColor = ColorName.darkRoyalBlue.color
    }
}
