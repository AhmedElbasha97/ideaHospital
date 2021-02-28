//
//  UIButtonShape.swift
//  IDEHospital
//
//  Created by bido elbasha on 18/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

class CommonUIButton: UIButton{
    
    // MARK:- Public Methods
    func setUPUIButton(backGroundColor: Color, titleOfTheButton: String, sizeOfTheFont: CGFloat) {
        self.backgroundColor = backGroundColor
        self.layer.cornerRadius = self.frame.height / 4
        self.layer.borderWidth = 0
        self.setTitle("\(titleOfTheButton)", for: .normal)
        self.titleLabel?.font = FontFamily.PTSans.bold.font(size: sizeOfTheFont)
        self.setTitleColor(ColorName.white.color, for:UIControl.State.normal)
    }
    
}
