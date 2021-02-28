//
//  ReviewsTableViewCell.swift
//  IDEHospital
//
//  Created by bido elbasha on 04/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit
import Cosmos
class ReviewsTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: CommonUILabel!
    @IBOutlet weak var userOpinionLabel: CommonUILabel!
    @IBOutlet weak var raitingView: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpViewCell(cell: self)
        self.userOpinionLabel.setUpUILabael(size: 10, isBold: false, Textolor: ColorName.black.color)
        self.userNameLabel.setUpUILabael(size: 12, isBold: true, Textolor: ColorName.darkRoyalBlue.color)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
  
        // Configure the view for the selected state
    }
    func configure (cell: ReviewModel){
        print("getincell")
        userOpinionLabel.text = cell.comment
        userNameLabel.text = cell.commentedBy
        setUpStarRating(raiting: cell.rating)
    }
    
}
extension ReviewsTableViewCell{
 
    private func setUpStarRating(raiting: Int) {
            raitingView.rating = Double(raiting)
            raitingView.backgroundColor = .clear
            raitingView.settings.filledImage = Asset.fillStar.image
            raitingView.settings.emptyImage = Asset.emptyStars.image
            raitingView.settings.starSize = 15
            raitingView.settings.updateOnTouch = false
    }
    
    
}
