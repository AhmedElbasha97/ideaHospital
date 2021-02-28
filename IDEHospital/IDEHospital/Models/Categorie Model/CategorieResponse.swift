//
//  File.swift
//  IDEHospital
//
//  Created by bido elbasha on 09/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//


import Foundation

struct CategorieResponse: Codable {
    
    let reault: Bool
    let data: [MainCategorie]
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case reault = "success"
        case data, code
    }
}
