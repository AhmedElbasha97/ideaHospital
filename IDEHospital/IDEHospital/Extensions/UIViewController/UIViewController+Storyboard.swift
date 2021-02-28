//
//  UIViewController+Storyboard.swift
//  IDEHospital
//
//  Created by Kamal on 12/7/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//


import UIKit

extension UIViewController {
    
    class func create<T: UIViewController>(storyboardName: String, identifier: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
}
