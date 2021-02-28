//
//  ResetPasswordViewModel.swift
//  IDEHospital
//
//  Created by Kamal on 12/28/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

protocol ResetPasswordViewModelProtocol {
    func goToMain(user: AuthUser?)
}

class ResetPasswordViewModel {
    //MARK:- Properties
    private weak var view: ResetPasswordVCProtocol!
    init(view: ResetPasswordVCProtocol) {
        self.view = view
    }
}

//MARK:- Private Methods
extension ResetPasswordViewModel {
    private func reset(user: AuthUser) {
        self.view.showloader()
        APIManager.reset(with: user) { (response) in
            switch response {
            case .success(let data):
                if data.code == 202 && data.success == true {
                    self.view.succseded(message: "Password Sent To Your E-mail")
                } else {
                    self.view.showAlert(message: data.errors?.email?[0] ?? "")
                }
                print(data.code)
            case .failure(let error):
                print(error)
            }
            self.view.hideLoader()
        }
    }
    
    private func validateUser(user: AuthUser) -> Bool {
        if !Validations.shared().isValidEmail(email: user.email){
            view.showAlert( message: L10n.pleaseCheckUrEmail)
            return false
        }
        return true
    }
}

extension ResetPasswordViewModel: ResetPasswordViewModelProtocol {
       func goToMain(user: AuthUser?) {
         if validateUser(user: user!) {
            reset(user: user!)
         }
     }
}
