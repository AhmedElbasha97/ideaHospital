//
//  UITextField+common.swift
//  IDEHospital
//
//  Created by Kamal on 12/16/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation
import UIKit

class CommonTextField: UITextField {
    
    // MARK:- Properties
    let padding = UIEdgeInsets(top: 0, left: 53, bottom: 0, right: 0)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // MARK:- Public Methods
    func setup(leftImage: UIImage, placeholder: String) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: ColorName.white.color, NSAttributedString.Key.font: UIFont(font: FontFamily.PTSans.bold, size: 15)!])
        self.textColor = ColorName.white.color
        self.font = UIFont(font: FontFamily.PTSans.bold, size: 15)
        self.backgroundColor = .clear
        let leftIcon = UIImageView(image: leftImage)
        self.leftViewMode = .always
        self.leftView = leftIcon
        self.borderStyle = .none
        self.layoutIfNeeded()
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.height - 2, width: frame.width, height: 2)
        bottomLine.backgroundColor = ColorName.white.color.cgColor
        self.layer.addSublayer(bottomLine)
        self.layer.masksToBounds = true
    }
}
