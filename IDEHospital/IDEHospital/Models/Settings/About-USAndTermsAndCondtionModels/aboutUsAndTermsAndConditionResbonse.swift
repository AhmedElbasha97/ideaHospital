//
//  aboutUsAndTermsAndConditionResbonse.swift
//  IDEHospital
//
//  Created by bido elbasha on 27/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation
struct AboutUsResponse: Codable {
    let reault: Bool
    let code: Int
    let data: AboutUsModel
    
    enum CodingKeys: String, CodingKey {
        case reault = "success"
        case code
        case data
    }
    
}

struct TermsAndCondtionResponse: Codable {
    let reault: Bool
    let code: Int
    let data: TermsAndConditionsModel
    
    enum CodingKeys: String, CodingKey {
        case reault = "success"
        case code
        case data
    }
    
}
