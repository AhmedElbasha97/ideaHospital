//
//  HomeNurseView.swift
//  IDEHospital
//
//  Created by Kamal on 12/16/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

class HomeNurseView: UIView {
    //MARK:- Outlets
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var nameTextField: CommonTextField!
    @IBOutlet weak var emailTextField: CommonTextField!
    @IBOutlet weak var mobileNumberTextField: CommonTextField!
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBOutlet weak var sendRequestButton: CommonUIButton!
    //MARK:- Public Methods
    func setupNurseView(mainLabel: String, contactUsLabel: String) {
        setupBackground()
        nameTextField.setup(leftImage: Asset.nameLogo.image , placeholder: L10n.yourName)
        emailTextField.setup(leftImage: Asset.emailLogo.image, placeholder: L10n.yourEmail)
        mobileNumberTextField.setup(leftImage: Asset.mobileLogo.image, placeholder: L10n.mobileNumber)
        self.sendRequestButton.setUPUIButton(backGroundColor: ColorName.darkRoyalBlue.color, titleOfTheButton: L10n.sendRequest, sizeOfTheFont: 20)
        setupLabel(label: mainLabel)
        setupcontactLabelLabel(label: contactUsLabel)
        setupTextView()
        mobileNumberTextField.keyboardType = .phonePad
    }
    

    
    private func setupLabel(label: String) {
        mainLabel.numberOfLines = 2
        let attributedString = NSMutableAttributedString(string: label)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        mainLabel.attributedText = attributedString
        mainLabel.adjustsFontSizeToFitWidth = true
        mainLabel.textAlignment = .center
        mainLabel.textColor = ColorName.white.color
        mainLabel.font = FontFamily.PTSans.regular.font(size: 12)
    }
    private func setupcontactLabelLabel(label: String) {
        contactLabel.numberOfLines = 2
        let attributedString = NSMutableAttributedString(string: label)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        contactLabel.attributedText = attributedString
        contactLabel.adjustsFontSizeToFitWidth = true
        contactLabel.textAlignment = .center
        contactLabel.textColor = ColorName.white.color
        contactLabel.font = FontFamily.PTSans.regular.font(size: 12)
    }
    private func setupTextView() {
        let attributedString = NSMutableAttributedString(string: L10n.enterDetails)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.font, value: FontFamily.PTSans.bold.font(size: 15), range:NSMakeRange(0, attributedString.length))
        detailTextView.attributedText = attributedString
        detailTextView.textColor = ColorName.white.color
        detailTextView.backgroundColor = .clear
        detailTextView.layer.borderWidth = 1
        detailTextView.layer.borderColor = ColorName.white.color.cgColor
        detailTextView.layer.cornerRadius = 5
    }
}

