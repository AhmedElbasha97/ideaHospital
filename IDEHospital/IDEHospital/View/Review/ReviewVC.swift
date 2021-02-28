//
//  ReviewVC.swift
//  IDEHospital
//
//  Created by Kamal on 1/4/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

class ReviewVC: UIViewController {

    @IBOutlet weak var reviewView: ReviewView!
    
    private var viewModel : ReviewViewModelProtocol!
    private var doctorID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavController(title: "Review", settingColor: false)
        self.setupNavigationItems(backAction: .dismissCurrent, haveSettingBTN: true)
        reviewView.setupView()
        viewModel = ReviewViewModel()
    }
    
    //MARK:- Public Methods
    class func create(id: Int) -> ReviewVC {
        let review: ReviewVC = UIViewController.create(storyboardName: Storyboards.Review, identifier: ViewControllers.reviewVC)
        review.doctorID = id
        return review
    }

    @IBAction func submitButton(_ sender: UIButton) {
        let review = ReviewDoctor(rating: Int(reviewView.starView.rating), comment: reviewView.commentTextField.text ?? "")
        viewModel.doctorReview(review: review, doctorID: doctorID)
        navigationController?.popViewController(animated: true)
    }
}
