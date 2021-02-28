//
//  SignUpViewModel.swift
//  IDEHospital
//
//  Created by Kamal on 12/28/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

protocol SignUpViewModelProtocol {
    func goToMain(user: AuthUser?, confirmPassword: String?)
}

class SignUpViewModel {
    
    weak var view: AuthProtocol!
    init(view: AuthProtocol) {
        self.view = view
    }
}

//MARK:- Private Methods
extension SignUpViewModel {
    private func register(user: AuthUser) {
        self.view.showloader()
        APIManager.register(with: user) { (response) in
            switch response {
            case .success(let data):
                if data.code == 201 && data.success == true {
                    self.view.dismissVC()
                    UserDefaultsManager.shared().token = data.data?.access_token
                } else {
                    self.view.showAlert(message: data.errors?.email?[0] ?? "")
                }
                print(data.code)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.view.hideLoader()
        }
    }
    
    private func validateUser(user: AuthUser, confirmPassword: String) -> Bool {
        if !Validations.shared().isvalidName(name: user.name) {
            view.showAlert(message: L10n.lettersOnly)
            return false
        }
        
        if !Validations.shared().isValidEmail(email: user.email){
            view.showAlert(message: L10n.pleaseCheckUrEmail)
            return false
        }
        
        if !Validations.shared().isvalidMobileNumber(number: user.mobile) {
            view.showAlert(message: L10n.yourNumberMustBe11Numbers)
            return false
        }
        if !Validations.shared().isValidPassword(password: user.password) {
            view.showAlert(message: L10n.pleaseMakeSureYourPasswordIs8OrMoreCharacters)
            return false
        }
        if confirmPassword != user.password {
            view.showAlert(message: L10n.pleaseMakeSureYourPasswordIsTheSame)
            return false
        }
        return true
    }
}

extension SignUpViewModel: SignUpViewModelProtocol {
    func goToMain(user: AuthUser?, confirmPassword: String?) {
        if validateUser(user: user!, confirmPassword: confirmPassword!) {
            register(user: user!)
        }
    }
}
