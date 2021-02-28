//
//  AuthPopUpVC.swift
//  IDEHospital
//
//  Created by Kamal on 1/14/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

protocol AuthPopUpVCProtocol: class {
    func popUpAlert(popUp: PopUpType)
    func popUpSuccessAlert(popUp: PopUpType)
}
protocol reloadDoctorData: class {
    func reloadtime(popUp: PopUpType)
}
class AuthPopUpVC: UIViewController {
    //MARK:- Properties
    var doctorId: Int?
    var appointment: Int?
    private var viewModel: AuthPopUpViewModelProtocol!
    
    //MARK:- Outlets
    @IBOutlet weak var popUpView: AuthPopUpView!
    weak var delegate: reloadDoctorData?
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.setupView()
    }
    
    //MARK:- Public Methods
    class func create(doctorID: Int, appointment: Int, delegate: reloadDoctorData) -> AuthPopUpVC {
        let auth: AuthPopUpVC = UIViewController.create(storyboardName: Storyboards.authPopUps, identifier: ViewControllers.authPopUpVC)
        auth.viewModel = AuthPopUpViewModel(view: auth)
        auth.doctorId = doctorID
        auth.appointment = appointment
        auth.delegate = delegate
        return auth
    }
    
    //MARK:- IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        popUpView.signUpPopView.isHidden = true
        popUpView.loginPopView.isHidden = false
        popUpView.setupLoginButtonWhenTapped()
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        popUpView.signUpPopView.isHidden = false
        popUpView.loginPopView.isHidden = true
        popUpView.setupSignUpButtonWhenTapped()

    }
    
    @IBAction func cancelButtonpressed(_ sender: UIButton) {
        dismissCurrent()
      
    }
    
    @IBAction func voucherChechBox(_ sender: UIButton) {
        viewModel.checkIndex(button: sender)
        viewModel.checkVoucher(index: viewModel.returnIndex(), texField: popUpView.voucherTextField)
    }
    
    @IBAction func bookForAnotherCheckBox(_ sender: UIButton) {
        viewModel.checkIndex(button: sender)
        viewModel.checkBookForAnother(index: viewModel.returnIndex(), texField: popUpView.bookForAnotherTextField)
    }
    
    @IBAction func loginVoucherCheckBox(_ sender: UIButton) {
        viewModel.checkIndex(button: sender)
        viewModel.checkLoginVoucher(index: viewModel.returnIndex(), texField: popUpView.loginVoucherTextField)
    }
    
    @IBAction func loginBookCheckBox(_ sender: UIButton) {
        viewModel.checkIndex(button: sender)
        viewModel.checkLoginBookForAnother(index: viewModel.returnIndex(), texField: popUpView.loginBookForAnotherTextField)
    }
    
    @IBAction func termsButtonPressed(_ sender: UIButton) {
         showTermsAndCondition()
    }
    
    @IBAction func termsConditionsButtonPressed(_ sender: UIButton) {
         showTermsAndCondition()
    }

    @IBAction func loginAndBookButtonPressed(_ sender: UIButton) {
     viewModel.loginAndBook(email: popUpView.loginEmailTextField.text, password: popUpView.loginPasswordTextField.text, patientName: popUpView.loginBookForAnotherTextField.text, voucher: popUpView.loginVoucherTextField.text, doctorId: self.doctorId, appointment: self.appointment)
    }
    
    @IBAction func signUpAndBookButtonPressed(_ sender: UIButton) {
        viewModel.signUpAndBook(email: popUpView.emailTextField.text, password: popUpView.passwordTextField.text, mobile: popUpView.mobileNumberTextField.text, name: popUpView.nameTextField.text, patientName: popUpView.bookForAnotherTextField.text, voucher: popUpView.voucherTextField.text, doctorId: self.doctorId, appointment: self.appointment)
    }
}
//MARK:- private function
extension AuthPopUpVC{
    //show terms and condition
    private func showTermsAndCondition() {
         let terms = AboutUsAndTermsAndConditionVC.create(goToAboutUs: false)
          terms.setupNavigationItemsSettings(backAction: .dismissCurrent, color: ColorName.steelGrey.color)
          let nav = UINavigationController(rootViewController: terms)
          nav.modalPresentationStyle = .fullScreen
          present(nav, animated: true)
     }
     
    
}
extension AuthPopUpVC: AuthPopUpVCProtocol {
 
    func popUpSuccessAlert(popUp: PopUpType) {
        self.dismissCurrent()
           delegate?.reloadtime(popUp: popUp)
          
            
    }
    
    func popUpAlert(popUp: PopUpType) {
        showPopUp(type: popUp)
    }
}

extension AuthPopUpVC: SuccessDelegate {
 
    func okPressed() {
        self.dismissCurrent()
    }

}
