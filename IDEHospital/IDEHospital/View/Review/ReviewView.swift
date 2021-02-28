//
//  ReviewView.swift
//  IDEHospital
//
//  Created by Kamal on 1/4/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit
import Cosmos
class ReviewView: UIView {
    
    //MARK:- Outlets
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var starView: CosmosView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    //MARK:- Private Methods
    func setupView() {
        setUpStarRating()
        setupLabel(label: mainLabel, text: L10n.pleaseRateYourExperienceWithTheDoctor)
        setupTextField(textField: commentTextField, placeholder: L10n.addComment)
        setupBackground()
        setupButton()
    }
    
    
    //MARK:- Public Methods
    private func setUpStarRating() {
        starView.backgroundColor = .clear
        starView.settings.filledImage = Asset.rate.image
        starView.settings.emptyImage = Asset.group1074.image
        starView.settings.starSize = 15
        starView.settings.updateOnTouch = true
    }
    
    private func setupLabel(label: UILabel, text: String) {
         label.text = text
         label.textAlignment = .center
         label.textColor = ColorName.white.color
         label.font = FontFamily.PTSans.bold.font(size: 15)
         label.adjustsFontSizeToFitWidth = true
     }
    
    private func setupTextField(textField: UITextField, placeholder: String) {
        textField.textColor = ColorName.white.color
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)

    textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: ColorName.white.color, NSAttributedString.Key.font: UIFont(font: FontFamily.PTSans.bold, size: 12)!])

    }
    
    private func setupButton() {
        submitButton.backgroundColor = ColorName.darkRoyalBlue.color
        submitButton.setTitle(L10n.submitReview, for: .normal)
        submitButton.layer.cornerRadius = submitButton.frame.height / 5
        submitButton.titleLabel?.font = FontFamily.PTSans.bold.font(size: 20)
        submitButton.setTitleColor(ColorName.white.color, for: .normal)
    }
}
