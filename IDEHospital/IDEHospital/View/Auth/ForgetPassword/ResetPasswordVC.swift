//
//  ResetPasswordVC.swift
//  IDEHospital
//
//  Created by Kamal on 12/28/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit
protocol ResetPasswordVCProtocol: class {
    func showAlert(message: String)
    func showloader()
    func hideLoader()
    func dismissVC()
    func succseded(message:String)
}
class ResetPasswordVC: UIViewController {
    //MARK:- Properties
   private var viewModel: ResetPasswordViewModelProtocol!
    
    //MARK:- Outlets
    @IBOutlet weak var resetView: ResetPasswordView!
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        resetView.setupView()
        self.viewModel = ResetPasswordViewModel(view: self)
        setupNavigation()
    }
    
    // MARK:- Public Methods
    class func create() -> ResetPasswordVC {
        let reset: ResetPasswordVC = UIViewController.create(storyboardName: Storyboards.Auth, identifier: ViewControllers.resetPasswordVC)

        return reset
    }
    
    //MARK:- IBActions
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        viewModel.goToMain(user: AuthUser(email: resetView.emailTextField.text ))

    }
}
//MARK:- private func
extension ResetPasswordVC{
    private func setupNavigation() {
        setupNavController(title: "Reset Password", settingColor: false)
         setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: false)
    }
}

extension ResetPasswordVC: ResetPasswordVCProtocol {
    func showAlert(message: String) {
        showPopUp(type: .failure(message))
    }
    func succseded(message:String){
        showPopUp(type: .success(message),Okbutton: .delegation, delegate: self)
        
    }

    
    func showloader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func dismissVC() {
        let homeVC = HomeVC.create()
        let nav = UINavigationController(rootViewController: homeVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = nav
    }
}
extension ResetPasswordVC: SuccessDelegate{
    
    func okPressed() {
        dismissVC()
    }
}
