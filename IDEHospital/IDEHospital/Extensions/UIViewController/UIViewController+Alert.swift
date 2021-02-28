//
//  UIViewController+Alert.swift
//  IDEHospital
//
//  Created by Kamal on 12/7/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//


import UIKit

extension UIViewController {
    func openAlert(message: String) {
        showPopUp(type: .failure(message))
    }
}

extension UIViewController {
    func showPopUp(type: PopUpType, Okbutton: OkButtonAction = .dismissCurrent, delegate: SuccessDelegate? = nil, reloadDelegate:reloadData? = nil) {
        let alert = SuccessfullyBookedVC.create(popUpType: type, okButton: Okbutton, delegate: delegate, relaodDelegate: reloadDelegate)
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        present(alert, animated: true)
    }
    
    @objc func goToHome() {
        let home = HomeVC.create()
     
              let nav = UINavigationController(rootViewController: home)
              nav.modalPresentationStyle = .fullScreen
              present(nav, animated: true)
    }
}
