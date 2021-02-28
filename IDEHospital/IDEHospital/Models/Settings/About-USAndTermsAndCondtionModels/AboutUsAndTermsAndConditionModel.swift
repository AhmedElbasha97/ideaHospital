//
//  AboutUsModel.swift
//  IDEHospital
//
//  Created by bido elbasha on 27/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation
struct AboutUsModel: Codable {
    let aboutUs: String
    enum CodingKeys: String, CodingKey {
     case aboutUs = "about_us"
    }
}

struct TermsAndConditionsModel: Codable {
    let TermsAndConditions: String
    enum CodingKeys: String, CodingKey {
     case TermsAndConditions = "terms_and_conditions"
    }
}
