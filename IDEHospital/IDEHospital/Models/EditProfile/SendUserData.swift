//
//  getUserData.swift
//  IDEHospital
//
//  Created by bido elbasha on 15/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import Foundation
struct EditUserProfile: Codable {
        let name: String?
        let email: String?
        let mobile: String?
        let password: String?
        let old_password: String?
        
        init(name: String? = nil, email: String? = nil, mobile: String? = nil, password: String? = nil, old_password:String? = nil) {
            self.name = name
            self.email = email
            self.mobile = mobile
            self.password = password
            self.old_password = old_password
        }
    
    
}
