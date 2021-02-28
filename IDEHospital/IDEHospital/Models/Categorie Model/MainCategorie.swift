//
//  File.swift
//  IDEHospital
//
//  Created by bido elbasha on 08/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

struct MainCategorie: Codable {
    
    let id: Int
    let name: String
    let image: String
    let color: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, color
    }
}
