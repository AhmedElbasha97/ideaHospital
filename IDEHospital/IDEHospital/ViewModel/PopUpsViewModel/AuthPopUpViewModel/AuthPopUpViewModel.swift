//
//  AuthPopUpViewModel.swift
//  IDEHospital
//
//  Created by Kamal on 1/15/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import Foundation
import UIKit

protocol AuthPopUpViewModelProtocol {
    func loginAndBook(email: String?, password: String?, patientName: String?, voucher: String?, doctorId: Int?, appointment: Int?)
    func signUpAndBook(email: String?, password: String?, mobile: String?, name: String?, patientName: String?, voucher: String?, doctorId: Int?, appointment: Int?)
    func checkLoginBookForAnother(index: Int, texField: UITextField)
    func checkLoginVoucher(index: Int, texField: UITextField)
    func checkVoucher(index: Int, texField: UITextField)
    func checkBookForAnother(index: Int, texField: UITextField)
    func checkIndex(button: UIButton)
    func returnIndex() -> Int
}

class AuthPopUpViewModel {
    //MARK:- Properties
    weak private var view: AuthPopUpVCProtocol!
    var user: AuthBook!
    var checkVoucher: Bool? = false
    var checkBookForAnother: Bool? = false
    var checkLoginVoucher: Bool? = false
    var checkLoginBookForAnother: Bool? = false
    let box = [Asset.rectangle1798.image, Asset.correct.image]
    var index = 0
    var checkView: Bool?
    
    //MARK:- Init
    init(view: AuthPopUpVCProtocol) {
        self.view = view
    }
}

//MARK:- Private Methods
extension AuthPopUpViewModel {
    private func authValidate(email: String?, password: String?, name: String? = nil, mobileNumber: String? = nil, patientName: String?, voucher: String?, checkVoucher: Bool?, checkName: Bool?, checkAuth: Bool?) -> Bool {
        if !Validations.shared().isEmptyEmail(email: email) {
            view.popUpAlert(popUp: .failure(L10n.pleaseEnterYourEmail))
            return false
        }
        if !Validations.shared().isValidEmail(email: email) {
            view.popUpAlert(popUp: .failure(L10n.pleaseCheckUrEmail))
            return false
        }
        if !Validations.shared().isValidPassword(password: password) {
            view.popUpAlert(popUp: .failure(L10n.pleaseEnterYourPassword))
            return false
        }
        if !Validations.shared().isEmptyPassword(password: password) {
            view.popUpAlert(popUp: .failure(L10n.enterPassword))
            return false
        }
        if checkAuth == true {
            if !Validations.shared().isEmptyName(name: name) {
                view.popUpAlert(popUp: .failure(L10n.enterName))
                return false
            }
            if !Validations.shared().isvalidName(name: name) {
                view.popUpAlert(popUp: .failure(L10n.invalidName))
                return false
            }
            if !Validations.shared().isEmptyMobileNumber(number: mobileNumber) {
                view.popUpAlert(popUp: .failure(L10n.pleaseEnterYourMobileNumber))
                return false
            }
            if !Validations.shared().isvalidMobileNumber(number: mobileNumber) {
                view.popUpAlert(popUp: .failure(L10n.yourNumberMustBe11Numbers))
                return false
            }
        }
        
        if checkVoucher == true {
            if !Validations.shared().isvalidVoucher(number: voucher) {
                view.popUpAlert(popUp: .failure(L10n.yourVoucherMustBe6Numbers))
                return false
            }
            if !Validations.shared().isEmptyPassword(password: voucher) {
                view.popUpAlert(popUp: .failure(L10n.pleaseEnterYourVoucher))
                return false
            }
        }
        
        if  checkName == true {
            if !Validations.shared().isEmptyName(name: patientName) {
                view.popUpAlert(popUp: .failure(L10n.enterName))
                return false
            }
            if !Validations.shared().isvalidName(name: patientName) {
                view.popUpAlert(popUp: .failure(L10n.invalidName))
                return false
            }
        }
        return true
    }
    
    private func checkAppointmentResponse(_ response: UserBookResponse) {
        if response.success == true && response.code == 201 {
            view?.popUpSuccessAlert(popUp: .success(L10n.successfullyBooked))
        } else if let voucherError = response.errors?.voucher?[0] {
            view?.popUpAlert(popUp: .failure(voucherError))
            
        } else if let appointmentError = response.errors?.appointment?[0] {
            view.popUpAlert(popUp: .failure(appointmentError))
        } else if let emailError = response.errors?.email?[0] {
            view?.popUpAlert(popUp: .failure(emailError))
        }
        else if let emailOrPasswordError = response.message {
            view.popUpAlert(popUp: .failure(emailOrPasswordError))
        }
    }
    
    private func loginBookDoctorAppointment(user: AuthBook) {
        APIManager.authBook(user: user) { (result) in
            switch result {
            case .success(let response):
                self.checkAppointmentResponse(response)
                guard let data = response.data else { return }
                UserDefaultsManager.shared().token = data.access_token
            case .failure (let error):
                print(error)
                self.view.popUpAlert(popUp: .failure("response Error"))
            }
        }
    }
    
    private func signUpBookDoctorAppointment(user: AuthBook) {
        APIManager.signUpBook(user: user) { (result) in
            switch result {
            case .success(let response):
                self.checkAppointmentResponse(response)
                guard let data = response.data else { return }
                UserDefaultsManager.shared().token = data.access_token
            case .failure (let error):
                print(error)
                self.view.popUpAlert(popUp: .failure("response Error"))
            }
        }
    }
}

extension AuthPopUpViewModel: AuthPopUpViewModelProtocol {
    func returnIndex() -> Int {
        return self.index
    }
    
    func checkIndex(button: UIButton) {
        self.index = (self.index >= self.box.count-1) ? 0 : self.index+1
        button.setImage(box[index], for: .normal)
    }
    
    func loginAndBook(email: String?, password: String?, patientName: String?, voucher: String?, doctorId: Int?, appointment: Int?) {
        if authValidate(email: email, password: password, patientName: patientName, voucher: voucher, checkVoucher: self.checkLoginVoucher, checkName: self.checkLoginBookForAnother, checkAuth: false) {
            if self.checkLoginVoucher == false && self.checkLoginBookForAnother == false {
                guard let appointment = appointment else { return }
                user = AuthBook(email: email, password: password, doctor_id: doctorId, appointment: Int(appointment))
            } else if self.checkLoginVoucher == true {
                guard let appointment = appointment else { return }
                user = AuthBook(email: email, password: password, doctor_id: doctorId, appointment: Int(appointment), voucher: voucher)
            } else if self.checkLoginBookForAnother == true {
                guard let appointment = appointment else { return }
                user = AuthBook(email: email, password: password, doctor_id: doctorId, appointment: Int(appointment), patient_name: patientName)
            }
            loginBookDoctorAppointment(user: user)
        }
    }
    
    func signUpAndBook(email: String?, password: String?, mobile: String? = nil, name: String? = nil, patientName: String?, voucher: String?, doctorId: Int?, appointment: Int?) {
        if authValidate(email: email, password: password, name: name, mobileNumber: mobile, patientName: patientName, voucher: voucher, checkVoucher: self.checkVoucher, checkName: self.checkBookForAnother,checkAuth: true) {
            if self.checkVoucher == false && self.checkBookForAnother == false {
                guard let appointment = appointment else { return }
                user = AuthBook(email: email, password: password, mobile: mobile, name: name, doctor_id: doctorId, appointment: Int(appointment))
            } else if self.checkVoucher == true {
                guard let appointment = appointment else { return }
                user = AuthBook(email: email, password: password, mobile: mobile, name: name, doctor_id: doctorId, appointment: Int(appointment), voucher: voucher)
            } else if self.checkBookForAnother == true {
                guard let appointment = appointment else { return }
                user = AuthBook(email: email, password: password, mobile: mobile, name: name, doctor_id: doctorId, appointment: Int(appointment), patient_name: patientName)
            }
            signUpBookDoctorAppointment(user: user)
        }
    }
    
    func checkLoginBookForAnother(index: Int, texField: UITextField) {
        if index == 0 {
            texField.text = ""
            texField.isHidden = true
            checkLoginBookForAnother = false
        } else {
            texField.isHidden = false
            checkLoginBookForAnother = true
        }
    }
    
    func checkLoginVoucher(index: Int, texField: UITextField) {
        if index == 0 {
            texField.text = ""
            texField.isHidden = true
            checkLoginVoucher = false
        } else {
            texField.isHidden = false
            checkLoginVoucher = true
        }
    }
    
    func checkBookForAnother(index: Int, texField: UITextField) {
        if index == 0 {
            texField.text = ""
            texField.isHidden = true
            checkBookForAnother = false
        } else {
            texField.isHidden = false
            checkBookForAnother = true
        }
    }
    
    func checkVoucher(index: Int, texField: UITextField) {
        if index == 0 {
            texField.text = ""
            texField.isHidden = true
            checkVoucher = false
        } else {
            texField.isHidden = false
            checkVoucher = true
        }
    }
}

