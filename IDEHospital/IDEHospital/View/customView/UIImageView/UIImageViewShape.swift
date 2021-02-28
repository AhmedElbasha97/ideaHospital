//
//  UIImageViewShape.swift
//  IDEHospital
//
//  Created by bido elbasha on 18/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView{
    
    // MARK:- Public Methods
    func setUpUIimage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.borderColor = ColorName.darkRoyalBlue.color.cgColor
        self.layer.borderWidth = 1
        }
    
}
