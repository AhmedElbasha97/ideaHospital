//
//  UILabelShape.swift
//  IDEHospital
//
//  Created by bido elbasha on 18/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

class CommonUILabel: UILabel{
   
    // MARK:- Public Methods
    func setUpUILabael(size: CGFloat, isBold: Bool, Textolor: Color){
          self.sizeToFit()
          self.numberOfLines = 0
          self.textColor = Textolor
          if isBold {
              self.font = FontFamily.PTSans.bold.font(size: size)
          } else {
              self.font = FontFamily.PTSans.regular.font(size: size)
          }
      }
  
}
