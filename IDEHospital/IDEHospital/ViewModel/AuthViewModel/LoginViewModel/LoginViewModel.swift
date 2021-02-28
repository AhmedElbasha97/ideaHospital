//
//  LoginViewModel.swift
//  IDEHospital
//
//  Created by Kamal on 12/27/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

protocol LoginViewModelProtocol {
    func goToMain(user: AuthUser?)
}

class LoginViewModel {
    
    //MARK:- Properties
    var view: AuthProtocol!
    
    //MARK:- Init
    init(view: AuthProtocol) {
        self.view = view
    }
    
}

//MARK:- Private Methods
extension LoginViewModel {
    private func login(user: AuthUser) {
        self.view.showloader()
        APIManager.login(with: user) { (response) in
            switch response {
            case .success(let data):
                if data.code == 201 && data.success == true {
                    self.view.dismissVC()
                    UserDefaultsManager.shared().token = data.data?.access_token
                } else {
                    self.view.showAlert(message: data.message ?? "")
                }
                print(data.code)
            case .failure(let error):
                print(error)
            }
            self.view.hideLoader()
        }
    }
    
    private func validate(user: AuthUser) -> Bool {
        if !Validations.shared().isValidEmail(email: user.email) {
            view.showAlert(message: L10n.pleaseCheckUrEmail)
            return false
        }
        if !Validations.shared().isValidPassword(password: user.password) {
            view.showAlert(message: L10n.pleaseMakeSureYourPasswordIs8OrMoreCharacters)
            return false
        }
        return true
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    func goToMain(user: AuthUser?) {
        if validate(user: user!) {
            login(user: user!)
        }
    }
    
}

