//
//  userAppointements.swift
//  IDEHospital
//
//  Created by Kamal on 1/7/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import Foundation

struct AppointmentUser: Codable {
    var doctorId: Int?
    var appointment: Int
    var bookForAnother: Int?
    var patientName: String?
    var voucher: String?
    
    init(doctorId: Int? = nil, appointment: Int, bookForAnother: Int? = nil, patientName: String? = nil, voucher: String? = nil) {
         self.doctorId = doctorId
         self.appointment = appointment
         self.bookForAnother = bookForAnother
         self.patientName = patientName
         self.voucher = voucher
     }
    
    enum CodingKeys: String, CodingKey {
        case appointment, voucher
        case bookForAnother = "book_for_another"
        case doctorId = "doctor_id"
        case patientName = "patient_name"
    }
}

struct AppointmentResponse: Codable {
    let code: Int
    let success: Bool?
    let message: String?
    let errors: AppointmentErrors?
}

struct AppointmentErrors: Codable {
    let voucher: [String]?
    let appointment: [String]?
}
