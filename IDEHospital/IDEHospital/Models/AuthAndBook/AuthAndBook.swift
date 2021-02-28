//
//  AuthAndBook.swift
//  IDEHospital
//
//  Created by Kamal on 1/15/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import Foundation

struct AuthBook: Codable {
    let email: String?
    let password: String?
    let mobile: String?
    let name: String?
    let doctor_id: Int?
    let appointment: Int?
    let patient_name: String?
    let book_for_another: Int?
    let voucher: String?
    
    init(email: String? = nil, password: String?, mobile: String? = nil, name: String? = nil, doctor_id: Int? = nil, appointment: Int? = nil, patient_name: String? = nil, book_for_another: Int? = nil,voucher: String? = nil) {
        self.email = email
        self.password = password
        self.mobile = mobile
        self.name = name
        self.doctor_id = doctor_id
        self.appointment = appointment
        self.patient_name = patient_name
        self.book_for_another = book_for_another
        self.voucher = voucher
    }
}

struct UserBookResponse: Codable {
    let data: UserAuthData?
    let code: Int
    let success: Bool?
    let errors: UserErrors?
  let message: String?
}

struct UserErrors: Codable {
    let voucher: [String]?
    let appointment: [String]?
    let email: [String]?

}

struct UserAuthData: Codable {
    let id: Int?
    let name: String?
    let email: String?
    let mobile: String?
    let access_token: String?
}



