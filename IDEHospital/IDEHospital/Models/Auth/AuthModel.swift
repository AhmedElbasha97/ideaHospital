//
//  User.swift
//  IDEHospital
//
//  Created by Kamal on 12/27/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

struct AuthUser: Codable {
    let name: String?
    let email: String?
    let mobile: String?
    let password: String?
    
    init(name: String? = nil, email: String?, mobile: String? = nil, password: String? = nil) {
        self.name = name
        self.email = email
        self.mobile = mobile
        self.password = password
    }
}

struct AuthResponse: Codable {
    
    let success: Bool?
    let data: AuthData?
    let code: Int
    let errors: AuthError?
    let message: String?
}

struct AuthError: Codable {
    let email: [String]?
}

struct AuthData: Codable {
    
    let id: Int?
    let name: String?
    let email: String?
    let mobile: String?
    let access_token: String?

}
