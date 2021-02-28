//
//  AppointmentModel.swift
//  IDEHospital
//
//  Created by bido elbasha on 19/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation
struct AppointmentModel: Codable{
    
    let id: Int
    let appointment: Int
    let patientName: String
    let bookForAnother: Bool
    let doctor: DoctorModel
    let voucher: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, appointment, doctor, voucher
        case patientName = "patient_name"
        case bookForAnother = "book_for_another"
    }
   

}
