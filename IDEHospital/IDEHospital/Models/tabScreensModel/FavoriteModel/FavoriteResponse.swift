//
//  FavoriteResponse.swift
//  IDEHospital
//
//  Created by bido elbasha on 19/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation
struct FavoriteResponse: Codable {
    
    let reault: Bool?
    let data: DataModelFavorite
    let code: Int
    let message: String?
    let errors: AppointmentErrors?
    
    enum CodingKeys: String, CodingKey {
        case reault = "success"
        case data, code, message, errors
    }
    
}
