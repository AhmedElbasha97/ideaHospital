//
//  UIView+BackgroundImage.swift
//  IDEHospital
//
//  Created by Kamal on 12/14/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setupBackground() {
        let background = UIImageView(image: Asset.backGround.image)
        background.frame = self.bounds
        addSubview(background)
        self.sendSubviewToBack(background)
    }
}
extension UIView {
   func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
      let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath

      self.layer.mask = mask
   }
}
extension UIView {
   func roundCornersview(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
