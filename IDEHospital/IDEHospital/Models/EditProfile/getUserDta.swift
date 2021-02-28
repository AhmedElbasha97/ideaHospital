//
//  getUserDta.swift
//  IDEHospital
//
//  Created by bido elbasha on 15/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//


import Foundation
struct getUserModel: Codable  {
    let name: String!
    let email: String!
    let mobile: String!
    let accessToken: String!
    enum CodingKeys: String, CodingKey {
        case name, email, mobile
        case accessToken = "access_token"
    }
    
}
struct getUserResponse: Codable  {
    let success: Bool?
    let data: getUserModel?
    let code: Int
    let message: String?

}
