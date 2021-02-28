//
//  VoucherViewModel.swift
//  IDEHospital
//
//  Created by Kamal on 1/3/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import Foundation
import UIKit
protocol VoucherViewModelProtocol {
    func checkFirstSwitch(firstSwitch: UISwitch)
    func checksecondSwitch(secondSwitch: UISwitch)
    func switchValidation(code: String?, firstSwitch: UISwitch, name: String?, secondSwitch: UISwitch)
}

class VoucherViewModel {
    //MARK: Outlets
    weak var view: VoucherPopUpProtocol!
    private var appointment: AppointmentUser!
    
    //MARK:- Init
    init(view: VoucherPopUpProtocol) {
        self.view = view
    }
}

//MARK:- Private Methods
extension VoucherViewModel {
    private func validataName(name: String?) -> Bool {
        if !Validations.shared().isvalidName(name: name) {
            view.voucherConfirmation(id: 1, voucher: nil, patientName: nil, bookForAnother: 0, useVoucher: 0)
            return false
        }
        if !Validations.shared().isEmptyName(name: name) {
            view.voucherConfirmation(id: 2, voucher: nil, patientName: nil, bookForAnother: 0, useVoucher: 0)
            return false
        }
        return true
    }
    
    private func validateVoucher(code: String?) -> Bool {
        if code?.count != 6 {
            view.voucherConfirmation(id: 3, voucher: code, patientName: nil , bookForAnother: 0, useVoucher: 0)
            return false
        }
        return true
    }
    
    private func validateFirst(code: String?, firstSwitch: UISwitch) -> Bool {
        if firstSwitch.isOn {
            if validateVoucher(code: code) {
                return true
            } else {
                view.voucherConfirmation(id: 4, voucher: nil, patientName: nil, bookForAnother: 0, useVoucher: 0)
            }
        }
        return false
    }
    
    private func validateSecond(name: String?, secondSwitch: UISwitch) -> Bool {
        if secondSwitch.isOn {
            if validataName(name: name) {
                return true
            } else {
                view.voucherConfirmation(id: 5, voucher: nil, patientName: nil, bookForAnother: 0, useVoucher: 0)
            }
        }
        return false
    }
}

extension VoucherViewModel: VoucherViewModelProtocol {
    func switchValidation(code: String?, firstSwitch: UISwitch, name: String?, secondSwitch: UISwitch) {
        if validateFirst(code: code, firstSwitch: firstSwitch) || validateSecond(name: name, secondSwitch: secondSwitch) {
            if validateSecond(name: name, secondSwitch: secondSwitch) {
                print("\(validateSecond(name: name, secondSwitch: secondSwitch))")
                if validateFirst(code: code, firstSwitch: firstSwitch) {
                    print("\(validateFirst(code: code, firstSwitch: firstSwitch))")
                    view.voucherConfirmation(id: 6, voucher: code, patientName: name, bookForAnother: 1, useVoucher: 1)
                    print("\(validateSecond(name: name, secondSwitch: secondSwitch))")
                } else {
                    view.voucherConfirmation(id: 6, voucher: code, patientName: name, bookForAnother: 1, useVoucher: 0)
                }
            } else {
                view.voucherConfirmation(id: 6, voucher: code, patientName: name, bookForAnother: 0, useVoucher: 1)
            }
        }
        view.voucherConfirmation(id: 6, voucher: code, patientName: name, bookForAnother: 0, useVoucher: 0)
    }
    
    func checkFirstSwitch(firstSwitch: UISwitch) {
        if !firstSwitch.isOn {
            view.switchOneOff()
        } else {
            view.switchOneOn()
        }
    }
    
    func checksecondSwitch(secondSwitch: UISwitch) {
        if !secondSwitch.isOn {
            view.switchtwoOff()
        } else {
            view.switchtwoOn()
        }
    }
    
    
}

