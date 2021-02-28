//
//  DactorModel.swift
//  IDEHospital
//
//  Created by bido elbasha on 17/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation


struct DoctorModel: Codable {
    let id: Int
    let rating: Int
    let reviewsCount: Int
    let name: String
    let bio: String
    let secondBio: String
    let specialty: String
    let address: String
    let langtuid: Decimal
    let latiduit: Decimal
    let fees: Int
    let waitingTime: Int
    let image: String
    let city: String
    let region: String
    let isFavorited: Bool
    let companies: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, rating, bio, address, fees, city, region, companies, specialty
        case reviewsCount = "reviews_count"
        case secondBio = "second_bio"
        case langtuid = "lng"
        case latiduit = "lat"
        case waitingTime = "waiting_time"
        case isFavorited = "is_favorited"
    }
    
}


