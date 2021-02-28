//
//  ReviewViewModel.swift
//  IDEHospital
//
//  Created by Kamal on 1/7/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import Foundation

protocol ReviewViewModelProtocol {
    func doctorReview(review: ReviewDoctor, doctorID: Int)
}

class ReviewViewModel {
    
}

extension ReviewViewModel {
    private func reviewDoctor(review: ReviewDoctor, doctorID: Int) {
        APIManager.reviewDoctor(doctorID: doctorID, review: review) { (response) in
            switch response {
            case .failure (let error):
                print(error)
            case .success(let result):
                print(result)
            }
        }
    }
}

extension ReviewViewModel: ReviewViewModelProtocol {
    func doctorReview(review: ReviewDoctor,doctorID: Int) {
        reviewDoctor(review: review, doctorID: doctorID)
    }
}
