//
//  ValidationManager.swift
//  IDEHospital
//
//  Created by ahmedElbasha on 06/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

class Validations {
    
    //MARK:- Singleton
    private static let sharedInstance = Validations()
    
    //MARK:- Public Methods
    class func shared() -> Validations {
        return Validations.sharedInstance
    }
    
    func isEmptyEmail(email: String?) -> Bool {
        guard let email = email?.trimmed, !email.isEmpty else {
            return false
        }
        return true
    }
    
    func isValidEmail(email: String?) -> Bool {
        let regEx =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let pred = NSPredicate(format: "SELF MATCHES %@", regEx)
        if !pred.evaluate(with: email) {
            return false
        }
        return true
    }
    
    func isValidPassword(password: String?) -> Bool {
        guard let password = password, password.count >= 8 else {
            return false
        }
        return true
    }
    
    func isEmptyPassword(password: String?) -> Bool {
        guard let password = password , !password.isEmpty else {
            return false
        }
        return true
    }
    
    func isEmptyName(name: String?) -> Bool {
        guard let name = name , !name.isEmpty else {
            return false
        }
        return true
    }

    func isvalidName(name: String?) -> Bool {
        let regEx = "^[a-zA-Z- ]*$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regEx)
        if !pred.evaluate(with: name) {
            return false
        }
        return true
    }
    
    func isEmptyMobileNumber(number: String?) -> Bool {
          if number!.isEmpty  {
              return false
          }
          return true
      }
    
    func isvalidMobileNumber(number: String?) -> Bool {
        if number!.count != 11 {
            return false
        }
        return true
    }
    
    func isvalidVoucher(number: String?) -> Bool {
          if number!.count != 6 {
              return false
          }
          return true
      }
    
}
