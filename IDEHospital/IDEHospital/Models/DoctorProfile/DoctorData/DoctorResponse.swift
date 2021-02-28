//
//  DoctorResponse.swift
//  IDEHospital
//
//  Created by bido elbasha on 05/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import Foundation
struct DoctorResponse: Codable{
    let reault: Bool?
    let data: DoctorModel
    let code: Int
    let message: String?
    let errors: AppointmentErrors?
    
    enum CodingKeys: String, CodingKey {
        case reault = "success"
        case data, code, message, errors
    }
}
