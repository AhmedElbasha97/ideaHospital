//
//  ResetPasswordView.swift
//  IDEHospital
//
//  Created by Kamal on 12/28/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

class ResetPasswordView: UIView {
    @IBOutlet weak var emailTextField: CommonTextField!
    @IBOutlet weak var resetButton: UIButton!
    
    func setupView() {
        self.layoutSubviews()
        emailTextField.setup(leftImage: Asset.component81.image, placeholder: L10n.yourEmail)
        setupButton(button: resetButton, titleOfTheButton: L10n.setNewPassword, sizeOfTheFont: 20, color: ColorName.darkRoyalBlue.color)
        setupBackground()
        self.layoutIfNeeded()
    }
    
    private func setupButton(button: UIButton, titleOfTheButton: String, sizeOfTheFont: CGFloat, color: UIColor ) {
        button.backgroundColor = color
        button.layer.cornerRadius = button.frame.height / 4
        button.layer.borderWidth = 0
        button.setTitle("\(titleOfTheButton)", for: .normal)
        button.titleLabel?.font = FontFamily.PTSans.bold.font(size: sizeOfTheFont)
        button.setTitleColor(ColorName.white.color, for:UIControl.State.normal)
    }
    
    
}
