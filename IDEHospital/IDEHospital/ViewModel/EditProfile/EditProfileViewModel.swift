//
//  EditProfileViiewModel.swift
//  IDEHospital
//
//  Created by bido elbasha on 15/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import Foundation
protocol EditProfileViewModelprotocol: class {
    func getUserData()
     func editProfile(userName: String?, userEmail:String?, mobile:String?, oldPassword:String?,newPassword:String?, confirmPassword: String?)
}
class EditProfileViewModel{
    //MARK:- Properties
    //Variables
    private var userEdit: EditUserProfile!
    private var userData: getUserModel!
    weak var view: EditProfileVCProtcol!
     //MARK:- life cycle method
    init(view: EditProfileVCProtcol) {
        self.view = view
    }
    
}
//MARK:- private func
extension EditProfileViewModel{
    //API
    //getting data of the user
    private func gettingDataOfTheUser(){
        APIManager.getUserData { (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
                self.view.showErrorAlert(massage: error.localizedDescription)
            case.success(let data):
                if data.code == 200 && data.success == true {
                    self.userData = data.data
                    self.view.showDataOnTextField(userData: (data.data ?? nil)!)
                } else {
                    self.view.showErrorAlert(massage: data.message ?? "")
                }
                print(data.code)
                
            }
    
        }
    }
    //Edit Profile
    private func editProfileData(userData:EditUserProfile){
        APIManager.editUserData(userData: userData) { (response) in
            switch response{
                case .failure(let error):
                       self.view.showErrorAlert(massage: error.localizedDescription)
                case.success(let data):
                    if data.code == 200 && data.success == true {
                        self.view.showSuccesAlert()
                        
                    } else {
                        self.view.showErrorAlert(massage: data.message ?? "")
                    }
                    print(data.code)
            }
        }
        
    }
    //valdition
    private func validateUser(userName: String?, userEmail:String?, mobile:String?, oldPassword:String?,newPassword:String?, confirmPassword: String?) -> Bool{
        if userData.name == userName && userData.email == userEmail && userData.mobile == mobile && oldPassword == "123456"{
            view.showErrorAlert(massage: "please edit the data needed to be edit or go out")
        }
        if !Validations.shared().isvalidName(name: userName) {
            view.showErrorAlert(massage: L10n.lettersOnly)
            return false
        }
        
        if !Validations.shared().isValidEmail(email: userEmail){
            view.showErrorAlert(massage: L10n.pleaseCheckUrEmail)
            return false
        }
        
        if !Validations.shared().isvalidMobileNumber(number: mobile) {
            view.showErrorAlert(massage: L10n.yourNumberMustBe11Numbers)
            return false
        }
        if oldPassword != "123456"{
        if !Validations.shared().isValidPassword(password: newPassword) {
            view.showErrorAlert(massage: L10n.pleaseMakeSureYourPasswordIs8OrMoreCharacters)
            return false
        }
   
        if confirmPassword != newPassword {
            view.showErrorAlert(massage: L10n.pleaseMakeSureYourPasswordIsTheSame)
            return false
        }
        }
        return true
    }
    
}
extension EditProfileViewModel: EditProfileViewModelprotocol{
    func getUserData()  {
        gettingDataOfTheUser()
    }
    
      func editProfile(userName: String?, userEmail:String?, mobile:String?, oldPassword:String?,newPassword:String?, confirmPassword: String?) {
        
        if validateUser(userName: userName, userEmail: userEmail, mobile:mobile, oldPassword:oldPassword, newPassword:newPassword, confirmPassword: confirmPassword) {
            if oldPassword == "123456"{
                userEdit = EditUserProfile(name: userName, email: userEmail, mobile: mobile )
            }else{
                userEdit = EditUserProfile(name: userName, email: userEmail, mobile: mobile, password: newPassword, old_password: oldPassword)
            }
           editProfileData(userData: userEdit)
}
}
}
