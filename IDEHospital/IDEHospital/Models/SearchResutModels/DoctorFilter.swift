//
//  DoctorFilter.swift
//  IDEHospital
//
//  Created by Kamal on 12/22/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

struct DoctorsFilter {
    
    enum SortType: String {
        case rating
        case fees
        case empty
    }
    
    let categoryId: Int!
    var page: Int!
    var specialtyId: Int?
    var cityId: Int?
    var regionId: Int?
    var doctorName: String?
    var companyId: Int?
    var orderBy: String?
    
    func parameters() -> [String: Any] {
        var params = [String: Any]()
        params["main_category_id"] = categoryId
        params["page"] = page
        params["specialty_id"] = specialtyId
        params["city_id"] = cityId
        params["region_id"] = regionId
        params["name"] = doctorName
        params["company_id"] = companyId
        params["order_by"] = orderBy
        return params
    }
}
