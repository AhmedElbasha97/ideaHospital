//
//  DeletingResponse.swift
//  IDEHospital
//
//  Created by bido elbasha on 20/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation
struct DeletingResponse: Codable {
    
    let result: Bool?
    let message: String?
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case result = "success"
        case code
        case message
    }
    
}
