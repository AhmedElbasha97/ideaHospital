//
//  UIViewController+NavController.swift
//  IDEHospital
//
//  Created by bido elbasha on 12/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

extension UIViewController{
    enum Back: String {
        case dismissCurrent
        case popUpCurrent
    }
    
    func setupNavController(title: String, settingColor: Bool) {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.clipsToBounds = true
        if settingColor{
            navigationController?.navigationBar.barTintColor = ColorName.darkRoyalBlue.color
        } else {
            navigationController?.navigationBar.barTintColor = ColorName.veryLightPink.color
        }
        
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : ColorName.white.color,
            NSAttributedString.Key.font: FontFamily.PTSans.bold.font(size: 20) as Any
        ]
    }
    
    func setupNavigationItems(backAction: Back, haveSettingBTN: Bool) {
        let backItem = UIBarButtonItem(image: Asset.backArrow.image, style: .done, target: self, action: Selector(backAction.rawValue))
        backItem.tintColor = ColorName.steelGrey.color
        let leftPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftPadding.width = 18
        navigationItem.leftBarButtonItems = [leftPadding, backItem]
        if haveSettingBTN{
            let settingsItem = UIBarButtonItem(image: Asset.settings.image, style: .done, target: self, action: #selector(showSettings))
            settingsItem.tintColor = ColorName.steelGrey.color
            let rightPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            rightPadding.width = 18
            navigationItem.rightBarButtonItems = [rightPadding, settingsItem]
        }
        
    }
    
    @objc func popUpCurrent() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissCurrent() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func showSettings() {
        self.navigationController?.pushViewController(SettingsVC.create(), animated: true)
    }
    
    func setupNavigationItemsSettings(backAction: Back, color: UIColor) {
        let backItem = UIBarButtonItem(image: Asset.settingsBack.image, style: .done, target: self, action: Selector(backAction.rawValue))
        backItem.tintColor = color
        let leftPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftPadding.width = 18
        navigationItem.leftBarButtonItems = [leftPadding, backItem]
        
    }
}
