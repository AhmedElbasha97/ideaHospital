//
//  UIViewController+BackgroundImage.swift
//  IDEHospital
//
//  Created by Kamal on 12/14/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation
import UIKit

private func setupBackground(view: UIView) {
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    backgroundImage.image = Asset.component22.image
    backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
    view.insertSubview(backgroundImage, at: 0)
}

