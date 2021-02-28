//
//  AppDelegate.swift
//  IDEHospital
//
//  Created by ahmedElbasha on 06/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().previousNextDisplayMode = .alwaysHide
        return true
    }
    
    static func getMainWindow() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}







