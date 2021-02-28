//
//  CategoryResponse.swift
//  IDEHospital
//
//  Created by Kamal on 12/11/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

struct CategoryResonse: Codable {
    
    let data: CategoryData
}

struct CategoryData: Codable {
    
    let specialties: [Speciality]
    let cities: [City]
    let companies: [Company]
}

struct Speciality: Codable {
    
    let id: Int
    let name: String
}

struct City: Codable {
    
    let id: Int
    let name: String
    let regions: [Region]
}

struct Region: Codable {
    
    let id: Int
    let name: String
}

struct Company: Codable {
    
    let id: Int
    let name: String
}

