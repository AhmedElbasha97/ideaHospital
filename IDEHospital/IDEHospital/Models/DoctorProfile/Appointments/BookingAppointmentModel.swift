//
//  BookingAppointmentModel.swift
//  IDEHospital
//
//  Created by bido elbasha on 05/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import Foundation
struct TimeModel: Codable {
    let time: Int
    let booked: Bool
    
    enum CodingKeys: String, CodingKey {
        case time, booked
    }
}

struct dateModel: Codable {
    let date: Int
    let times: [TimeModel]
    
    enum CodingKeys: String, CodingKey {
        case date, times
    }
}
