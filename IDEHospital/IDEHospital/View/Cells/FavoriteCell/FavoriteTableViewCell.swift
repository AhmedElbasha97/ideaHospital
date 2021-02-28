//
//  FavoriteTableViewCell.swift
//  IDEHospital
//
//  Created by bido elbasha on 15/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit
import Cosmos

protocol FavoriteTableViewCellProtcol: class{
    func configure(doctorName: String, doctorSpecialty: String, doctorImage: UIImage, hospitalName: String, hospitalLocation: String, Fees: String, waitingTime: String, raiting: Double, reviews: String, doctorID: Int)
    func SendDataToViewModel(cell: DoctorModel,index: Int)
}

class FavoriteTableViewCell: UITableViewCell {
    
    //MARK:- properties
    @IBOutlet weak var raitingView: CosmosView!
    @IBOutlet weak var dactorImageView: CircularImageView!
    @IBOutlet weak var dactorNameLabel: CommonUILabel!
    @IBOutlet weak var dactorSecialistLabel: CommonUILabel!
    @IBOutlet weak var hospitalNameLabel: CommonUILabel!
    @IBOutlet weak var hospitalLocationLabel: CommonUILabel!
    @IBOutlet weak var waitingTimeLabel: CommonUILabel!
    @IBOutlet weak var examinationFeesLabel : CommonUILabel!
    @IBOutlet weak var bookingbutton: CommonUIButton!
    
    //MARK:-Variables
    //viewModel
    private var viewModel: FavoriteTableCellViewModelProtocol!
    //delegate
    var delegate: favoriteTableVIewCellDelegate?
    var callback: ((UITableViewCell) -> Void)?
    var index : Int!
    private var doctorID: Int!
    
    //MARK:-life cycle function
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpViewCell(cell: self)
        self.viewModel = FavoriteTableCellViewModel(view: self)
        self.bookingbutton.setUPUIButton(backGroundColor: ColorName.darkRoyalBlue.color, titleOfTheButton: L10n.viewProfile, sizeOfTheFont: 12)
        self.dactorImageView.setUpUIimage()
        self.dactorNameLabel.setUpUILabael( size: 15, isBold: true, Textolor: ColorName.white.color)
        self.dactorSecialistLabel.setUpUILabael( size: 15, isBold: true, Textolor: ColorName.white.color)
        self.hospitalNameLabel.setUpUILabael( size: 12, isBold: false, Textolor: ColorName.white.color)
        self.hospitalLocationLabel.setUpUILabael( size: 12, isBold: false, Textolor: ColorName.white.color)
        self.examinationFeesLabel.setUpUILabael( size: 12, isBold: false, Textolor: ColorName.white.color)
        self.waitingTimeLabel.setUpUILabael( size: 12, isBold: false, Textolor: ColorName.white.color)


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- button
    //bokking button
    @IBAction func bookingButton(_ sender: Any) {
        callback?(self)
        self.delegate?.booking(doctorID: doctorID)
    }
    
    //cancel button
    @IBAction func cancelButtton(_ sender: Any) {
        callback?(self)
        self.delegate?.removeFromFavoriteTable(doctorID: doctorID, index: index)
    }
    
    
}

//MARK:- private function
extension FavoriteTableViewCell{
    //MARK:- setUp UI


  
    
    private func setUpStarRaiting(raiting: Double, reviews: String){
        raitingView.rating = raiting
        raitingView.text = "\(reviews + L10n.review)"
        raitingView.settings.textColor = ColorName.white.color
    }
}
extension FavoriteTableViewCell: FavoriteTableViewCellProtcol{
    func SendDataToViewModel(cell: DoctorModel, index: Int) {
        viewModel.cellconfiguretion(cell: cell)
        self.index = index
    }
    
    func configure (doctorName: String, doctorSpecialty: String, doctorImage: UIImage, hospitalName: String, hospitalLocation: String, Fees: String, waitingTime: String, raiting: Double, reviews: String, doctorID: Int) {
        
        dactorNameLabel.text = doctorName
      dactorSecialistLabel.text =  doctorSpecialty
        hospitalNameLabel.text =  hospitalName
       hospitalLocationLabel.text =  hospitalLocation
       examinationFeesLabel.text =  Fees
        waitingTimeLabel.text =  waitingTime
        self.dactorImageView.image = doctorImage
       setUpStarRaiting(raiting: raiting, reviews: reviews)
       self.doctorID = doctorID
        
    }
}

//MARK:- Delegate
protocol favoriteTableVIewCellDelegate {
    func removeFromFavoriteTable (doctorID: Int, index: Int)
    func booking(doctorID: Int)
}



