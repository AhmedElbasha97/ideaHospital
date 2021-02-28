//
//  DoctorProfileVC.swift
//  IDEHospital
//
//  Created by bido elbasha on 04/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

//MARK:- DoctorProfileVC protcol
protocol DoctorProfileVCProtcol: class {
    func showloader()
    func hideLoader()
    func showingAlerts(errorMassage: String)
    func reloadDataTableView()
    func showNoData()
    func showDataForDoctorProfile(data: DoctorModel)
    func setImageFullHeartforFavoriteButton()
    func setImageNulHeartforFavoriteButton()
    func getCompaniesText(text: String)
    func imagOfDoctor(doctorImage: UIImage)
    func datteToShow(date: String)
    func reloadDataForCollectionView()
    func hideNoTimeAvailableLabel(hide: Bool)
    func changeBackGroundColorOfBookingButton()
    func enableBookingButton()
    func changeBackgrounUIViewCell(index1: IndexPath, index2: IndexPath)
    func showReviewsCounter(text: String)
    func getIntOfTime(id: Int, doctorName: String)
    func showVoucherPopUp(id: Int)
    func goToConfirm(appointment: AppointmentUser, voucher: Int)

    func enableBackwardAndForward()
    func goToVoucher()
    func goToAuthPopUp()
    func goToReviews()
  

}

class DoctorProfileVC: UIViewController {
    //MARK:- properties
    //outLets
    @IBOutlet weak var doctorProfileView: DoctorProfileView!
    //variables
    var viewModel: DoctorProfileViewModelProtcol!
    private var bookingTime: Int!
    private var doctorID: Int!
    private var doctorName: String!
    
    //MARK:- life Cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doctorProfileView.setUpUI(view: doctorProfileView)
        self.viewModel.getDataT0DoctoProfile()
        setUpTableView()
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavBar()
        viewModel.reloadReviews(id: doctorID)
       
    }
    
    //MARK:- Public func
    class func create(id: Int) -> DoctorProfileVC {
        let doctorProfileVC: DoctorProfileVC = UIViewController.create(storyboardName: Storyboards.doctorProfile, identifier:
            ViewControllers.doctorProfileVC)
        doctorProfileVC.viewModel = DoctorProfileViewModel(view: doctorProfileVC, doctorId: id)
        doctorProfileVC.doctorID = id
        return doctorProfileVC
    }
    //MARK:-Buttons
    @IBAction func addOrRemoveFromFavoriteBtnTapped(_ sender: UIButton) {
        self.viewModel.addOrRemoveFromFavorite()
        self.doctorProfileView.addToFavoriteButton.setImage(Asset.heart.image, for: .normal)
    }
    
    @IBAction func doctorProfileButtonBtnTapped(_ sender: UIButton) {
        self.doctorProfileView.showDoctorProfile()
    }
    
    @IBAction func backwardButtonTapped(_ sender: UIButton) {
        self.viewModel.dateToShowWithTime(nextDate: false)
        self.doctorProfileView.ChangeButtonColorToSilver()
    }
    
    
    @IBAction func forwardButtonTapped(_ sender: UIButton) {
        self.viewModel.dateToShowWithTime(nextDate: true)
        self.doctorProfileView.ChangeButtonColorToSilver()
    }
    
    @IBAction func bookingButtonTapped(_ sender: UIButton) {
        viewModel.decideWhichPopUpToShow()
    }
    
    @IBAction func showLocationOnMapBtnTapped(_ sender: UIButton) {
        self.viewModel.showLocationOnMap()
    }
    
    @IBAction func reviewButtonTapped(_ sender: UIButton) {
        self.viewModel.reloadData(id: doctorID)
        self.viewModel.reloadReviews(id: doctorID)
        self.doctorProfileView.showReviewsTableView()
    }
    
    @IBAction func reviewTap(_ sender: UIButton) {
        viewModel.DecideToOpenReviews()
    }
}

//MARK:- private func
extension DoctorProfileVC{
    private func setUpTableView(){
        doctorProfileView.reviewTableView.register(UINib(nibName: Cells.reviewsTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.reviewsTableViewCell)
        doctorProfileView.reviewTableView.dataSource = self
        doctorProfileView.reviewTableView.delegate = self
    }
    
    private func setUpNavBar(){
        self.setupNavController(title: L10n.doctorProfile, settingColor: false)
        self.setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: true)
    }
    
    //MARK:- set up collection view
    private func setUpCollectionView(){
        doctorProfileView.timeCollectionView.register(UINib(nibName: Cells.timeCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Cells.timeCollectionViewCell)
        doctorProfileView.timeCollectionView.delegate = self
        doctorProfileView.timeCollectionView.dataSource = self
        
    }
        
}
//MARK:- set up table view
extension DoctorProfileVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("in count cells \(viewModel.reviewsCount())")
        return viewModel.reviewsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = doctorProfileView.reviewTableView.dequeueReusableCell(withIdentifier: Cells.reviewsTableViewCell , for: indexPath) as? ReviewsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(cell:self.viewModel.getDataOdTheCell(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel.detectLastItem(index: indexPath.row)
        print(self.viewModel.reviewsCount())
    }
}
//MARK:- set up Colllection view
extension DoctorProfileVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numbersOfViews()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 5
        return UIEdgeInsets(top: 10, left: inset, bottom: 20, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150   )
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = doctorProfileView.timeCollectionView.dequeueReusableCell(withReuseIdentifier: Cells.timeCollectionViewCell, for: indexPath) as? TimeCollectionViewCell else {return UICollectionViewCell ()}
        cell.configure(viewData: viewModel.dataOfView(index: indexPath.row), selected: !viewModel.checkSelectedItem(index: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
        self.viewModel.CheckAvalaplityOfTime(timeAvailablty: viewModel.dataOfView(index: indexPath.item).booked, index: indexPath)
    }
}
//MARK:- protocols
//view protocol
extension DoctorProfileVC: DoctorProfileVCProtcol {
 
    
    func enableBackwardAndForward() {
        self.doctorProfileView.backwardbutton.isEnabled = true
        self.doctorProfileView.forwardButton.isEnabled = true
    }
    
    
    func changeBackgrounUIViewCell(index1: IndexPath, index2: IndexPath) {
        self.doctorProfileView.changingBackGroundOfCollectionView(setselectedindex: index1, didSelectedIndexPath: index2)
    }
    
    
    func showNoData() {
        self.doctorProfileView.noDateLabel.isHidden = true
    }
    func showloader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func showingAlerts(errorMassage: String) {
        showPopUp(type: .failure(errorMassage))
    }
    
    func reloadDataTableView() {
        self.doctorProfileView.reviewTableView.reloadData()
    }
    func reloadDataForCollectionView(){
        self.doctorProfileView.timeCollectionView.reloadData()
    }
    func showDataForDoctorProfile(data: DoctorModel){
        self.doctorProfileView.takeDateFromViewModel(viewData: data)
        
    }
    func setImageFullHeartforFavoriteButton(){
        self.doctorProfileView.changeBackGroundOfFavoriteButtonToFullHeart()
    }
    
    func setImageNulHeartforFavoriteButton(){
        self.doctorProfileView.changeBackGroundOfFavoriteButtonToEmpetyHeart()
    }
    
    func getCompaniesText(text: String){
        self.doctorProfileView.companiesLabel.text = text
    }
    
    func imagOfDoctor(doctorImage: UIImage)  {
        self.doctorProfileView.doctorImageView.image = doctorImage
    }
    
    func datteToShow(date: String){
        self.doctorProfileView.dateLabel.text = date
        self.doctorProfileView.dateLabel.textAlignment = .center
    }
    
    func hideNoTimeAvailableLabel(hide: Bool){
        self.doctorProfileView.noDateLabel.isHidden = hide
    }
    
    func changeBackGroundColorOfBookingButton(){
        self.doctorProfileView.changeButtonColorToDarkBlue()
    }
    
    func enableBookingButton(){
        self.doctorProfileView.bookingButton.isEnabled = true
    }
    
    func showReviewsCounter(text: String){
        self.doctorProfileView.reviewButtonCount.text = text
    }
    
    func getIntOfTime(id: Int, doctorName: String){
        self.bookingTime = id
        self.doctorName = doctorName
    }
    
    func showVoucherPopUp(id: Int) {
        print("success switch")
        switch id {
        case 1:
            showPopUp(type: .failure(L10n.lettersOnly), Okbutton: .delegation, delegate: self)
        case 2:
            showPopUp(type: .failure(L10n.invalidName), Okbutton: .delegation, delegate: self)
        case 3:
            showPopUp(type: .failure(L10n.yourCodeMustBe6Numbers), Okbutton: .delegation, delegate: self)
        case 4:
            showPopUp(type: .failure(L10n.pleaseEnterValidateVoucher), Okbutton: .delegation, delegate: self)
        default:
            showPopUp(type: .failure(L10n.pleaseEnterCorrectName), Okbutton: .delegation, delegate: self)
        }
    }
        
    func goToConfirm(appointment: AppointmentUser, voucher: Int) {
        let confirm = ConfirmAppointmentVC.create(appointment: appointment, name: doctorName, docotorDelegate: self, voucher: voucher)

        confirm.modalPresentationStyle = .overFullScreen
        confirm.modalTransitionStyle = .crossDissolve

        self.present(confirm, animated: true)
    }
    func goToVoucher(){
        let voucher = VoucherPopUpVC.create(delegate: self)
            voucher.modalPresentationStyle = .overFullScreen
            voucher.modalTransitionStyle = .crossDissolve
        navigationController?.present(voucher, animated: true)
    }
    func goToAuthPopUp(){
        let auth = AuthPopUpVC.create(doctorID: doctorID, appointment: bookingTime, delegate: self)
        auth.modalPresentationStyle = .overFullScreen
        auth.modalTransitionStyle = .crossDissolve
        self.present(auth, animated: true)
    }
    func goToReviews(){
        let review = ReviewVC.create(id: doctorID)
        navigationController?.pushViewController(review, animated: true)
    }

}
//MARK:- Delegates
extension DoctorProfileVC: DoctorProfilePopUpDelegate {
    func showError(popUp: PopUpType) {
        showPopUp(type: popUp)
    }
    
    func cancelDelegation() {
        let cancel = CancelAppointmentVC.create(noDelegate: self, label: L10n.areYouSureWantToDeleteThisAppointment)
        cancel.modalPresentationStyle = .overFullScreen
        cancel.modalTransitionStyle = .crossDissolve
        self.present(cancel, animated: true)
    }
    
    
    func confirmDelegation() {
        showPopUp(type: .success(L10n.appointmentSuccessfullyBooked),Okbutton: .doctorProfileView, reloadDelegate:  self)
        
    }
    
    func voucherDelegation(id: Int, voucher: String?, patientName: String?, bookForAnother: Int, useVoucher: Int) {
        viewModel.checkStateVoucher(id: id, voucher: voucher, patientName: patientName, bookForAnother: bookForAnother, useVoucher: useVoucher)
    }
}
extension DoctorProfileVC: reloadData{
    func reload() {
        self.doctorProfileView.bookingButton.isEnabled = false
        self.doctorProfileView.bookingButton.backgroundColor = ColorName.veryLightPink.color
        self.viewModel.reloadtime(doctorId: doctorID)
    }
    
    
}

extension DoctorProfileVC: SuccessDelegate {
    
    func okPressed() {
        let voucher = VoucherPopUpVC.create(delegate: self)
        voucher.modalPresentationStyle = .overFullScreen
        voucher.modalTransitionStyle = .crossDissolve
        self.present(voucher, animated: true)
    }
}

extension DoctorProfileVC: noDelegate{
    func noButton() {
        viewModel.showAppointment()
    }

}

extension DoctorProfileVC: reloadDoctorData{
    
    func reloadtime(popUp: PopUpType) {
        showPopUp(type: popUp,Okbutton: .doctorProfileView, delegate:  self, reloadDelegate: self)
    }

}
