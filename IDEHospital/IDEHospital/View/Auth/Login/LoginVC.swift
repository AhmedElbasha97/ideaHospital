//
//  LoginVC.swift
//  IDEHospital
//
//  Created by Kamal on 12/27/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

protocol AuthProtocol: class {
    func showAlert(message: String)
    func showloader()
    func hideLoader()
    func dismissVC()
    
}

class LoginVC: UIViewController {
    
    //MARK:- Properties
    private var viewModel: LoginViewModelProtocol!
    
    //MARK:- Outlets
    @IBOutlet weak var loginView: LoginView!
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.setupLoginView()
        setupNavigation()
        
    }
    
    // MARK:- Public Methods
    class func create() -> LoginVC {
        let loginVC: LoginVC = UIViewController.create(storyboardName: Storyboards.Auth, identifier: ViewControllers.loginVC)
        loginVC.viewModel = LoginViewModel(view: loginVC)
        
        return loginVC
    }
    
    //MARK:- IBActions
    @IBAction func loginButton(_ sender: Any) {
        viewModel.goToMain(user: AuthUser(email: loginView.emailTextField.text ?? "", password: loginView.passwordTextField.text ?? ""))
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let signUp = SignUpVC.create()
        navigationController?.pushViewController(signUp, animated: true)
    }
    
    @IBAction func forgetPasswordButton(_ sender: Any) {
        let reset = ResetPasswordVC.create()
        navigationController?.pushViewController(reset, animated: true)
    }
}

//MARK:- Private Methods
extension LoginVC {
    private func setupNavigation() {
        setupNavController(title: L10n.loginTitle, settingColor: false)
        setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: false)
    }
}

extension LoginVC: AuthProtocol {

    
    func showAlert( message: String) {
        showPopUp(type: .failure(message))
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
