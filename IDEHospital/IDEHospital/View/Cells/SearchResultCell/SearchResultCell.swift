//
//  SearchResultCell.swift
//  IDEHospital
//
//  Created by Kamal on 12/21/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit
import Cosmos

protocol CellDelegate: class {
    func favAlert(tableViewCell: UITableViewCell)
    func goToDoctorProfile(id: Int)
}

class SearchResultCell: UITableViewCell {
    //MARK:- Outlets
    @IBOutlet weak var doctorImageView: CircularImageView!
    @IBOutlet weak var doctorNameLabel: CommonUILabel!
    @IBOutlet weak var specialityLabel: CommonUILabel!
    @IBOutlet weak var specialityImageView: UIImageView!
    @IBOutlet weak var specialityDetailsLabel: CommonUILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationLabel: CommonUILabel!
    @IBOutlet weak var timeImageView: UIImageView!
    @IBOutlet weak var timeLabel: CommonUILabel!
    @IBOutlet weak var feesImageView: UIImageView!
    @IBOutlet weak var feesDetailsLabel: CommonUILabel!
    @IBOutlet weak var rateDetails: CosmosView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var bookNowButton: CommonUIButton!
    @IBOutlet weak var borderView: UIView!
    
    //MARK:- Properties
    var viewModel: SearchResultCellViewModelProtocol!
    weak var delegate: CellDelegate?
    private var doctorId: Int!
    
    //MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        viewModel = SearchResultCellViewModel()
        self.setUpViewCell(cell: self)
    }
    
    //MARK:- Public Methods
    func setupCell() {
        self.bookNowButton.setUPUIButton(backGroundColor: ColorName.darkRoyalBlue.color, titleOfTheButton: "Book Now", sizeOfTheFont: 12)
        doctorNameLabel.setUpUILabael(size: 15, isBold: true, Textolor: ColorName.white.color)
        specialityLabel.setUpUILabael(size: 15, isBold: true, Textolor: ColorName.white.color)
       specialityDetailsLabel.setUpUILabael(size: 15, isBold: false, Textolor: ColorName.white.color)
        locationLabel.setUpUILabael(size: 15, isBold: false, Textolor: ColorName.white.color)
        timeLabel.setUpUILabael(size: 15, isBold: false, Textolor: ColorName.white.color)
       feesDetailsLabel.setUpUILabael(size: 15, isBold: false, Textolor: ColorName.white.color)
        setUpStarRating()
        self.doctorImageView.setUpUIimage()
        favButton.tintColor = .none
        favButton.backgroundColor = .none
        
    }
    
    func configure(doctor: Item) {
        doctorId = doctor.id
        specialityLabel.text = doctor.specialty
        locationLabel.text = doctor.address
        timeLabel.text = "Waiting Time : \(doctor.waitingTime) minutes"
        feesDetailsLabel.text = "Examination Fees : \(doctor.fees) LE"
        rateDetails.rating = Double(doctor.rating)
        rateDetails.text = "\(doctor.reviewsCount) \(L10n.review)"
        specialityDetailsLabel.text = doctor.secondBio
        doctorNameLabel.text = doctor.name
        if doctor.isFavorited {
            favButton.setImage(Asset.heart2.image, for: .normal)
        } else {
            favButton.setImage(Asset.heart.image, for: .normal)
        }
        viewModel.downloadImage(with: doctor) { [weak self] (image) in
            self?.doctorImageView.image = image
        }
    }
    
    //MARK:- IBActions
    @IBAction func favButtobTabed(_ sender: Any) {
     delegate?.favAlert(tableViewCell: self)
    }
    
    @IBAction func doctorProfileView(_ sender: Any) {
        delegate?.goToDoctorProfile(id: doctorId)
    }
}

extension SearchResultCell {
    //MARK:- setUp UI

    
    private func setUpStarRating() {
        rateDetails.backgroundColor = .clear
        rateDetails.settings.textColor = ColorName.white.color
        rateDetails.settings.filledImage = Asset.rate.image
        rateDetails.settings.emptyImage = Asset.group1074.image
        rateDetails.settings.starSize = 15
        rateDetails.settings.updateOnTouch = false
    }
}
