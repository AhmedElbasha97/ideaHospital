//
//  SuccessfullyBookedView.swift
//  IDEHospital
//
//  Created by Kamal on 1/3/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

class SuccessfullyBookedView: UIView {
    
    //MARK:- Outlets
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var successImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    //MARK:- Public Methods
    func setupView(image: String, title: String) {
        setupImageView(image: image)
        setupLabel(text: title)
        setupButton(button: okButton)
        popUpView.layer.cornerRadius = popUpView.frame.height / 19
        self.backgroundColor = ColorName.brownishGrey.color.withAlphaComponent(0.8)
    }
    
    //MARK:- Private Methods
    private func setupImageView(image: String) {
        successImageView.image = UIImage(named: image)
        successImageView.clipsToBounds = true
        successImageView.contentMode = .scaleToFill
    }
    
    private func setupLabel(text: String) {
        mainLabel.textAlignment = .center
        mainLabel.text = text
        mainLabel.textColor = ColorName.darkRoyalBlue.color
        mainLabel.font = FontFamily.PTSans.bold.font(size: 15)
        mainLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setupButton(button:UIButton) {
        button.backgroundColor = ColorName.darkRoyalBlue.color
        button.layer.cornerRadius = button.frame.height / 2.5
        button.layer.borderWidth = 0
        button.setTitle(L10n.ok, for: .normal)
        button.titleLabel?.font = FontFamily.PTSans.bold.font(size: 15)
        button.setTitleColor(ColorName.white.color, for:UIControl.State.normal)
    }
}
