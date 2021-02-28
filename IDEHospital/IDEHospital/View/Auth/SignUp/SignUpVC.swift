//
//  SignUpVC.swift
//  IDEHospital
//
//  Created by Kamal on 12/27/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    //MARK:- Properties
    private var viewModel: SignUpViewModelProtocol!
    
    //MARK:- Outlets
    @IBOutlet weak var signUpView: SignUpView!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.setupView()
        setupNavigation()
    }
    
    //MARK:- IBActions
    @IBAction func signUpButton(_ sender: Any) {
        viewModel.goToMain(user: AuthUser(name: signUpView.nameTextField.text, email: signUpView.emailTextField.text, mobile: signUpView.mobileTextField.text, password: signUpView.passwordTextField.text), confirmPassword: signUpView.confirmPasswordTextField.text)
        
    }
    @IBAction func termsButton(_ sender: Any) {
                 print("terms And Condition")
         let terms = AboutUsAndTermsAndConditionVC.create(goToAboutUs: false)
         terms.setupNavigationItemsSettings(backAction: .dismissCurrent, color: ColorName.steelGrey.color)
         let nav = UINavigationController(rootViewController: terms)
         nav.modalPresentationStyle = .fullScreen
         present(nav, animated: true)
         
    }
    
    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUp: SignUpVC = UIViewController.create(storyboardName: Storyboards.Auth, identifier: ViewControllers.signUpVC)
        signUp.viewModel = SignUpViewModel(view: signUp)
        return signUp
    }
}

//MARK:- Private Methods
extension SignUpVC {
    private func setupNavigation() {
        setupNavController(title: L10n.signUp, settingColor: false)
         setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: false)
    }
}

extension SignUpVC: AuthProtocol {
    func showAlert(message: String) {
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
