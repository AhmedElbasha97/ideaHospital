//
//  ReviewDoctor.swift
//  IDEHospital
//
//  Created by Kamal on 1/7/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import Foundation

struct ReviewDoctor: Codable {
    let rating: Int
    let comment: String
    
    enum CodingKeys: String, CodingKey {
        case rating, comment
    }
}

struct ReviewResponse: Codable {
    let code: Int
    let message: String?
    let errors: String?
}
