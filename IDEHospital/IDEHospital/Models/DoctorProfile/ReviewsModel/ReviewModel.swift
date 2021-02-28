//
//  ReviewModel.swift
//  IDEHospital
//
//  Created by bido elbasha on 05/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import Foundation
struct ReviewModel: Codable{
        let id: Int
        let rating: Int
        let comment: String
        let commentedBy: String
    enum CodingKeys: String, CodingKey {
            case id, rating, comment
            case commentedBy = "commented_by"
        }
       

    
}
struct PaginationModel: Codable{
        let total: Int
        let page: Int
        let perPage: Int
        let totalPages: Int
        let items: [ReviewModel]
        
        enum CodingKeys: String, CodingKey {
            case total, page, items
            case perPage = "per_page"
            case totalPages = "total_pages"
        }
        

}
