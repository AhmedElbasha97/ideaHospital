//
//  UITextField+Padding.swift
//  IDEHospital
//
//  Created by Kamal on 12/10/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func leftPadding(image: UIImage) {
        let leftIcon = UIImageView(image: image)
        leftIcon.frame.size = CGSize(width: 24.6, height: 27.1)
        self.leftViewMode = UITextField.ViewMode.always
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 43, height: self.bounds.height))
        leftIcon.center = leftPadding.center
        leftPadding.addSubview(leftIcon)
        leftPadding.backgroundColor = ColorName.darkRoyalBlue.color
        self.leftView = leftPadding
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.height/4
    }
    
    func rightPadding() {
        let rightIcon = UIImageView(image: Asset.arrow.image)
        self.rightViewMode = UITextField.ViewMode.always
        self.rightView = rightIcon
    }
}

class PaddedTextField: UITextField {
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rightBounds = CGRect(x: bounds.size.width-33, y: bounds.size.height/2.5, width: 20, height: 11.4)
        return rightBounds
    }
}
