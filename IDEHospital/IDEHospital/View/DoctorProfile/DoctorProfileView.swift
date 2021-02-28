//
//  DoctorProfileView.swift
//  IDEHospital
//
//  Created by bido elbasha on 04/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit
import  Cosmos
class DoctorProfileView: UIView {
    //MARK:- Proberties
    //MARK:- outlets
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var doctorImageView: CircularImageView!
    @IBOutlet weak var reviewButtonLabel: CommonUILabel!
    @IBOutlet weak var reviewButtonCount: CommonUILabel!
    @IBOutlet weak var doctorNameLabel: CommonUILabel!
    @IBOutlet weak var raitingView: CosmosView!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    @IBOutlet weak var doctorDescriptionLabel: CommonUILabel!
    @IBOutlet weak var dateLabelView: UIView!
    @IBOutlet weak var dateLabel: CommonUILabel!
    @IBOutlet weak var backwardbutton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var bookingButton: UIButton!
    @IBOutlet weak var doctorProfileButton: UIButton!
    @IBOutlet weak var reviewsButton: UIButton!
    @IBOutlet weak var doctorProfileScrollView: UIScrollView!
    @IBOutlet weak var doctorProfileView: UIView!
    @IBOutlet weak var doctorDescripLabel: CommonUILabel!
    @IBOutlet weak var doctorDescripImageView: UIImageView!
    @IBOutlet weak var doctorSpecialtyLabel: CommonUILabel!
    @IBOutlet weak var doctorSpecialtyImageView: UIImageView!
    @IBOutlet weak var addressLabel: CommonUILabel!
    @IBOutlet weak var addressImageView: UIImageView!
    @IBOutlet weak var presentLocationButton: UIButton!
    @IBOutlet weak var presentLocationImageView: UIImageView!
    @IBOutlet weak var waitingTimeLabel: CommonUILabel!
    @IBOutlet weak var waitingTimeImageView: UIImageView!
    @IBOutlet weak var exemenationFeesLabel: CommonUILabel!
    @IBOutlet weak var exemenationFeesImageView: UIImageView!
    @IBOutlet weak var noDateLabel: UILabel!
    @IBOutlet weak var companiesLabel: CommonUILabel!
    @IBOutlet weak var companiesImageVIew: UIImageView!
     
    //MARK:- life cycle Func
    func setUpUI(view: UIView) {
        self.layoutSubviews()
        self.doctorImageView.setUpUIimage()
        setUPUIBookingButton(button: bookingButton, titleOfTheButton: L10n.book, sizeOfTheFont: 12)
        self.doctorNameLabel.setUpUILabael(size: 15, isBold: true, Textolor: ColorName.white.color)
        self.doctorDescriptionLabel.setUpUILabael(size: 12, isBold: false, Textolor: ColorName.white.color)
        self.dateLabel.setUpUILabael(size: 12, isBold: true, Textolor: ColorName.white.color)
        setUpStarRating(raitingDetails: raitingView)
        setUpUITwoDiffrentViewButton(button: doctorProfileButton, cornerWanted: [.topLeft], radiusWanted: 25, label: L10n.doctorProfile)
        setUpUITwoDiffrentViewButton(button: reviewsButton, cornerWanted: [.topRight], radiusWanted: 25, label: " ")
        setUpUiForReviewButton(button: reviewButton, label: L10n.tabReview)
        setUpUiForLoctionButton(button: presentLocationButton)
        doctorDescripLabel.setUpUILabael(size: 12, isBold: false, Textolor: ColorName.black.color)
        doctorSpecialtyLabel.setUpUILabael(size: 12, isBold: false, Textolor: ColorName.black.color)
        addressLabel.setUpUILabael(size: 12, isBold: false, Textolor: ColorName.black.color)
        waitingTimeLabel.setUpUILabael(size: 12, isBold: false, Textolor: ColorName.black.color)
        exemenationFeesLabel.setUpUILabael(size: 12, isBold: false, Textolor: ColorName.black.color)
         companiesLabel.setUpUILabael(size: 12, isBold: false, Textolor: ColorName.black.color)
        setUpUIImageProfileView(imageView: doctorDescripImageView, image: Asset.logoDoctorProfile.image)
        setUpUIImageProfileView(imageView: doctorSpecialtyImageView, image: Asset.lifeDOctorProfile.image)
        setUpUIImageProfileView(imageView: addressImageView, image: Asset.pinDoctorProfile.image)
        setUpUIImageProfileView(imageView: presentLocationImageView, image: Asset.pinButtonDoctorProfile.image)
        setUpUIImageProfileView(imageView: waitingTimeImageView, image: Asset.clockDOctorProfile.image)
        setUpUIImageProfileView(imageView: exemenationFeesImageView, image: Asset.moneyDoctorProfile.image)
        setUpUIImageProfileView(imageView: companiesImageVIew, image: Asset.careProfileDOctor.image)
        setUpBackGroundForEveryView()
        setUpTableView()
        setUpIntialViewForTheSmallView()
        setUpLabelNoDateAvalable()
        setUpUILabelForReviewButton(label: reviewButtonLabel, text: L10n.reviews)
      setUpUILabelForReviewButtonCounter(label: reviewButtonCount)
   
        
    }
    //show scroll view
    func showDoctorProfile(){
        self.reviewTableView.isHidden = true
        self.doctorProfileView.isHidden = false
        self.doctorProfileButton.backgroundColor = ColorName.white.color
        self.reviewsButton.backgroundColor = ColorName.veryLightPink.color
    }
    //change back ground of the cell
    func changingBackGroundOfCollectionView(setselectedindex: IndexPath, didSelectedIndexPath: IndexPath){
      timeCollectionView.cellForItem(at: didSelectedIndexPath)?.backgroundColor = ColorName.niceBlue.color
      timeCollectionView.cellForItem(at: setselectedindex)?.backgroundColor = ColorName.darkRoyalBlue.color
    }
    //change booking button back ground
    func ChangeButtonColorToSilver(){
            bookingButton.backgroundColor = ColorName.veryLightPink.color
    }
    
    func changeButtonColorToDarkBlue(){
          bookingButton.backgroundColor = ColorName.darkRoyalBlue.color
    }
    //showing reviews
    func showReviewsTableView(){
         self.reviewTableView.isHidden = false
        self.doctorProfileView.isHidden = true
        self.reviewsButton.backgroundColor = ColorName.white.color
         self.doctorProfileButton.backgroundColor = ColorName.veryLightPink.color
         self.reviewTableView.reloadData()
    }
    //favorite btn when tabbed
    func changeBackGroundOfFavoriteButtonToFullHeart(){
        self.addToFavoriteButton.setImage(Asset.heart2.image, for: .normal)
    }
    
    func changeBackGroundOfFavoriteButtonToEmpetyHeart(){
        self.addToFavoriteButton.setImage(Asset.heart.image, for: .normal)

    }
    // set up data for view
    func takeDateFromViewModel(viewData: DoctorModel){
        self.doctorNameLabel.text = viewData.name
        self.doctorDescriptionLabel.text = viewData.bio
        self.raitingView.rating = Double(viewData.rating)
        self.doctorDescripLabel.text = viewData.specialty
        self.doctorSpecialtyLabel.text = viewData.secondBio
        self.addressLabel.text = viewData.address
        self.exemenationFeesLabel.text = "\(L10n.examinationFees + "\(viewData.fees)" + L10n.le)"
        self.waitingTimeLabel.text = "\(L10n.waitingTime + "\(viewData.waitingTime)" + L10n.minutes)"
    }
}
//MARK:- private func to setup view
extension DoctorProfileView{
      private func setUPUIBookingButton(button: UIButton, titleOfTheButton: String, sizeOfTheFont: CGFloat) {
            button.backgroundColor = ColorName.veryLightPink.color
            button.layer.cornerRadius = button.frame.height / 4
            button.layer.borderWidth = 0
            button.setTitle("\(titleOfTheButton)", for: .normal)
            button.titleLabel?.font = FontFamily.PTSans.bold.font(size: sizeOfTheFont)
            button.setTitleColor(ColorName.white.color, for:UIControl.State.normal)
            button.isEnabled = false
            forwardButton.isEnabled = false
             backwardbutton.isEnabled = false
        }
   
  
    private func setUpLabelNoDateAvalable(){
        noDateLabel.text = "\(L10n.noAppointmentAvailable)"
        noDateLabel.font = FontFamily.PTSans.bold.font(size: 20)
        noDateLabel.textAlignment = .center
        noDateLabel.textColor = ColorName.white.color
    }
    

    private func setUpBackGroundForEveryView(){
        self.setupBackground()
        self.dateLabelView.backgroundColor = ColorName.darkRoyalBlue.color
        self.doctorProfileScrollView.backgroundColor = ColorName.whiteTwo.color
        self.doctorProfileView.backgroundColor = ColorName.whiteTwo.color
        self.timeCollectionView.backgroundColor = .clear
    }
    
    private func setUpIntialViewForTheSmallView(){
        self.doctorProfileButton.backgroundColor = ColorName.white.color
        self.reviewTableView.isHidden = true
    }

    private func setUpStarRating(raitingDetails: CosmosView) {
            raitingDetails.backgroundColor = .clear
            raitingDetails.settings.filledImage = Asset.fillStar.image
            raitingDetails.settings.emptyImage = Asset.emptyStars.image
            raitingDetails.settings.starSize = 15
            raitingDetails.settings.updateOnTouch = false
    }
    
    private func setUpUITwoDiffrentViewButton (button: UIButton, cornerWanted: UIRectCorner, radiusWanted: CGFloat, label: String){
        button.roundCorners(cornerWanted, radius: radiusWanted)
        button.setTitle("\(label)", for: .normal)
        button.titleLabel?.font = FontFamily.PTSans.bold.font(size: 15)
        button.backgroundColor = ColorName.veryLightPink.color
        button.setTitleColor(ColorName.black.color, for:UIControl.State.normal)
    }
   
    
 
    private func setUpUILabelForReviewButton(label: UILabel, text: String){
        label.text = text
        reviewButtonLabel.setUpUILabael(size: 15, isBold: true, Textolor:  ColorName.black.color)
         label.textAlignment = .center
    }
    
    private func setUpUiForReviewButton(button: UIButton, label: String){
        let yourAttributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 10),
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: "\(label)",attributes: yourAttributes)
        button.setAttributedTitle(attributeString, for: .normal)
    }
    
    private func setUpUIImageProfileView(imageView: UIImageView, image: UIImage){
        imageView.image = image
    }
    
    private func setUpUiForLoctionButton(button:UIButton){
        button.setTitle("\(L10n.viewOnMap)", for: .normal)
        button.setTitleColor(ColorName.richPurple.color, for:UIControl.State.normal)
          button.titleLabel?.font = FontFamily.PTSans.bold.font(size: 12)
    }
    
    private func setUpTableView(){
        reviewTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        reviewTableView.backgroundColor = ColorName.whiteTwo.color
        reviewTableView.allowsSelection = false
        reviewTableView.rowHeight = 70
        reviewTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    private func setUpUILabelForReviewButtonCounter(label: UILabel){
        reviewButtonCount.setUpUILabael(size: 13, isBold: false, Textolor: ColorName.richPurple.color)
       label.textAlignment = .center
     }

}
