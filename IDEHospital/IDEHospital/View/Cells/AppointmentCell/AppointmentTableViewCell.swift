//
//  TableViewCell.swift
//  IDEHospital
//
//  Created by bido elbasha on 15/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit
import Cosmos

protocol AppointmentTableViewCellProtcol: class{
    func configure(doctorName: String, description: String, doctorImage: UIImage, date: String, time: String, raiting: Double, reviews: String, appointmentID: Int, lng: Decimal, lat: Decimal, index: Int)
    func SendDataToViewModel(cell: AppointmentModel, index: Int)
}

class AppointmentTableViewCell: UITableViewCell {

    //MARK:- properties
    @IBOutlet weak var doctorImageView: CircularImageView!
    @IBOutlet weak var doctorNameLabel: CommonUILabel!
    @IBOutlet weak var descriptionLabel: CommonUILabel!
    @IBOutlet weak var dateLabel: CommonUILabel!
    @IBOutlet weak var timeLabel: CommonUILabel!
    @IBOutlet weak var raitinView: CosmosView!
    
    //MARK:-Variables
    //viewModel
     private var viewModel: AppointmentTableViewCellViewModelProtocol!
    //delegate
    var delegate: AppointmentTableViewCellDelegate?
    var callback: ((UITableViewCell) -> Void)?
    private var appointmentID: Int!
    private var lng: Decimal!
    private var lat: Decimal!
    private var index : Int!
    //MARK:- life cycle function
    override func awakeFromNib() {
        super.awakeFromNib()
        self.doctorImageView.setUpUIimage()
        self.doctorNameLabel.setUpUILabael(size: 15, isBold: true, Textolor: ColorName.white.color)
        self.descriptionLabel.setUpUILabael(size: 12, isBold: false, Textolor: ColorName.white.color)
        self.dateLabel.setUpUILabael(size: 12, isBold: false, Textolor: ColorName.white.color)
        self.timeLabel.setUpUILabael(size: 12, isBold: false, Textolor: ColorName.white.color)

        self.viewModel = AppointmentTableViewCellViewModel(view: self)
         self.setUpViewCell(cell: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

        
    //
    //MARK:- Button
    //cancel button
    @IBAction func cancelButton(_ sender: UIButton) {
        callback?(self)
        self.delegate?.removeFromAppointmentTable(customTableViewCell: self, didTapButton: sender , appointmentID: appointmentID, index: index)
    }
    
    //show location
    @IBAction func locationButton(_ sender: Any) {
        callback?(self)
        self.delegate?.showLocationOnMab(lng: lng, lat: lat)
    
    }

}
//MARK:- private function
extension AppointmentTableViewCell{
    //MARK:- setUp UI
 
    
    private func setUpUILabael(label: UILabel, text: String, size: CGFloat, isBold: Bool){
     
    }
    
 
    
    private func setUpStarRaiting(raiting: Double, reviews: String, raitingView: CosmosView){
        raitingView.rating = raiting
        raitingView.text = "\(reviews + L10n.review)"
        raitingView.settings.textColor = ColorName.white.color
    }
    

}
extension AppointmentTableViewCell: AppointmentTableViewCellProtcol{
    func SendDataToViewModel(cell: AppointmentModel, index: Int) {
        viewModel.cellconfiguretion(cell: cell, Index: index)
    }
    
    func configure (doctorName: String, description: String, doctorImage: UIImage, date: String, time: String, raiting: Double, reviews: String, appointmentID: Int, lng: Decimal, lat: Decimal, index: Int) {
        self.doctorNameLabel.text = doctorName
        self.descriptionLabel.text = description
        self.dateLabel.text = date
        self.timeLabel.text = time
        self.doctorImageView.image = doctorImage
        setUpStarRaiting(raiting: raiting, reviews: reviews, raitingView: raitinView)
       self.appointmentID = appointmentID
        self.lat = lat
        self.lng = lng
        self.index = index
    }
}
//MARK:- Delegat
protocol AppointmentTableViewCellDelegate {
    func removeFromAppointmentTable (customTableViewCell: UITableViewCell, didTapButton button: UIButton, appointmentID: Int, index:Int)
    func showLocationOnMab(lng: Decimal, lat: Decimal)
}
