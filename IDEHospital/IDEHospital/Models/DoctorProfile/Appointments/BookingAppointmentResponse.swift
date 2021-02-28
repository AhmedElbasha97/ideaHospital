//
//  BookingAppointmentResponse.swift
//  IDEHospital
//
//  Created by bido elbasha on 05/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import Foundation
struct BookingAppointmentResponse: Codable {
    let reault: Bool
    let data: [dateModel]
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case reault = "success"
        case data, code
    }
    
}
