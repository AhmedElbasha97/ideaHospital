//
//  HomeNurseviewModel.swift
//  IDEHospital
//
//  Created by Kamal on 12/19/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

protocol HomeNurseViewModelProtocol {
    
    func decideWhatToShoew(gotoContactUs: Bool)
    func setUpTheDataOfTheView()
    func requestDone(name: String, email: String, number: String, message: String)
}

class homeNurseViewModel {
    //MARK:- Properties
    private var view: HomeNurseProtocol!
    private var gotoContactUs: Bool!
    //MARK:- Init
    init(view: HomeNurseProtocol) {
        self.view = view
    }
}

//MARK:- Private Methods
extension homeNurseViewModel {
    private func setUPDataOfTheView(gotoContactUs: Bool){
        if gotoContactUs{
            view.usedLabel(contactLabel: L10n.forMoreInformationCall19199, mainLabel: L10n.cotntactUSTextView)
            view.navSetUp(title: L10n.contactUs, haveSettingBTN: false)
        }else{
            view.usedLabel(contactLabel: "   ", mainLabel: L10n.textview)
            view.navSetUp(title: L10n.homeNurse, haveSettingBTN: true)
        }
    }
    
    private func validateUser(name: String, email: String, number: String, message: String) -> Bool {
        if !Validations.shared().isvalidName(name: name) {
            view.popUpFailure(popUp: .failure(L10n.lettersOnly))
            return false
        }
        
        if !Validations.shared().isEmptyName(name: name) {
            view.popUpFailure(popUp: .failure(L10n.pleaseEnterYourName))
            return false
        }
        
        if !Validations.shared().isEmptyEmail(email: email) {
            view.popUpFailure(popUp: .failure(L10n.pleaseEnterYourEmail))
            return false
        }
        
        if !Validations.shared().isValidEmail(email: email){
            view.popUpFailure(popUp: .failure(L10n.pleaseCheckUrEmail))
            return false
        }
        
        if !Validations.shared().isEmptyMobileNumber(number: number) {
            view.popUpFailure(popUp: .failure(L10n.pleaseEnterYourMobileNumber))
            return false
        }
        
        if !Validations.shared().isvalidMobileNumber(number: number) {
            view.popUpFailure(popUp: .failure(L10n.yourNumberMustBe11Numbers))
            
            return false
        }
        
        if message.isEmpty || message == L10n.enterDetails {
            view.popUpFailure(popUp: .failure(L10n.enterDetails))
            return false
        }
        return true
    }
    
    
    private func sendNurseRequest(name: String, email: String, number: String, message: String) {
        APIManager.sendNurseRequest(name, email, number, message) { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                print(result)
            }
        }
    }
    
    private func sendContactUsRequest(name: String, email: String, number: String, message: String) {
        APIManager.sendContactUsRequest(name, email, number, message) { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                print(result)
            }
        }
    }
}

extension homeNurseViewModel: HomeNurseViewModelProtocol {
    func decideWhatToShoew(gotoContactUs: Bool) {
        self.gotoContactUs = gotoContactUs
    }
    
    func setUpTheDataOfTheView() {
        setUPDataOfTheView(gotoContactUs: self.gotoContactUs)
    }
    
    func requestDone(name: String, email: String, number: String, message: String) {
        if validateUser(name: name, email: email, number: number, message: message) {
            if gotoContactUs{
                sendContactUsRequest(name: name, email: email, number: number, message: message)
            }else {
                sendNurseRequest(name: name, email: email, number: number, message: message)
            }
            view.popUpAlert(popUp: .success("thanks \(name) For submitting"))
        }
    }
}

