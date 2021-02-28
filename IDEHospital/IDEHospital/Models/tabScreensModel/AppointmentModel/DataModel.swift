//
//  DataModel.swift
//  IDEHospital
//
//  Created by bido elbasha on 17/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

struct DataModelAppointment: Codable {
    
    let total: Int
    let page: Int
    let perPage: Int
    let totalPages: Int
    let items: [AppointmentModel]
    
    enum CodingKeys: String, CodingKey {
        case total, page, items
        case perPage = "per_page"
        case totalPages = "total_pages"
    }
    
}
