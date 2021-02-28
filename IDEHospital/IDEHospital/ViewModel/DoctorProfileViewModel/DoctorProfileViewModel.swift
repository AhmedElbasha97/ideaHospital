//
//  DoctorProfileViewModel.swift
//  IDEHospital
//
//  Created by bido elbasha on 05/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit
import SDWebImage
//MARK:- protcols
protocol DoctorProfileViewModelProtcol: class {
    func getDataT0DoctoProfile()
    func reviewsCount() -> Int
    func getDataOdTheCell(index: Int) -> ReviewModel
    func removeOrAddFromFavorite(id: Int)
    func detectLastItem(index: Int)
    func showLocationOnMap()
    func dateToShowWithTime(nextDate: Bool)
    func addOrRemoveFromFavorite()
    func numbersOfViews() -> Int
    func dataOfView(index: Int) -> TimeModel
    func CheckAvalaplityOfTime(timeAvailablty: Bool, index: IndexPath)
    func checkSelectedItem(index:  IndexPath) -> Bool
    func checkStateVoucher(id: Int, voucher: String?, patientName: String?, bookForAnother: Int, useVoucher: Int)
    func showAppointment()
    func reloadData(id: Int)
    func reloadtime(doctorId: Int)
    func reloadReviews(id: Int)
    func decideWhichPopUpToShow()
    func DecideToOpenReviews()
}

class DoctorProfileViewModel{
    //MARK:- properties
    //MARK:- Variables
    private var dateArr = [dateModel]()
    private var AppointmentArr: dateModel!
    private var doctorData: DoctorModel!
    private var reviews = [ReviewModel]()
    private var page = 1
    private var totalpages: Int!
    private var doctorId: Int = 19
    private var dateIndex: Int = 0
    private weak var view: DoctorProfileVCProtcol?
    private var timeArr = [TimeModel]()
    private var slectedId: IndexPath = IndexPath(index: -1)
    private var voucher = ""
    private var patientName = ""
    private var bookForAnother = 0

    private var voucherId = 0

    // MARK:- Life Cycle Methods
    init(view: DoctorProfileVCProtcol , doctorId: Int) {
        self.view = view
        self.doctorId = doctorId
    }
}

//MARK:- Private Function
extension DoctorProfileViewModel{
    //get doctor data
    private func getDoctorData(id:Int){
        self.view?.showloader()
        APIManager.getDoctorData(doctorId: id) { (response) in
            switch response{
            case .success(let data):
                if data.code == 200 && data.reault == true{
                self.doctorData = data.data
                self.view?.showDataForDoctorProfile(data: self.doctorData)
                self.getImageOfDoctor(path: self.doctorData.image)
                self.setUpTextToCompaniesLabel()
                self.setUpImageForFavooriteButton()
                
                print("data come for data")
                print(data)
                    
                }else{
                    self.view?.showingAlerts(errorMassage: data.message ?? "")
                   
                }
            case .failure(let error):
                self.view?.showingAlerts(errorMassage: "\(error.localizedDescription)")
                
                
            }
        }
        self.view?.hideLoader()
    }
    //get reviews data
    private func getReviews(id: Int, page: Int){
        self.view?.showloader()
        APIManager.getReviews(doctorId: id, page: page) { (response) in
            switch response{
            case .success(let data):
                if self.page == 1{
                    self.reviews = data.data.items
                    self.totalpages = data.data.totalPages
                    self.view?.showReviewsCounter(text: "\("\(data.data.items.count)" + L10n.review)")
                }else{
                    for cell in data.data.items{
                        self.reviews.append(cell)
                    }
                }
            case .failure(let error):
                self.view?.showingAlerts(errorMassage: "\(error.localizedDescription)")
            }
            self.view?.reloadDataTableView()
        }
        self.view?.hideLoader()
    }
    //get appointment data
    private func getAppointment(id: Int){
        self.view?.showloader()
        APIManager.getAppointment(doctorId: id){ (response) in
            switch response{
            case .success(let data):
                self.dateArr = data.data
                self.setDateAndTime()
                self.view?.reloadDataForCollectionView()
                self.view?.enableBackwardAndForward()
                self.slectedId = IndexPath(index: -1)
                print ("data come for appointment")
            case .failure(let error):
                self.view?.showingAlerts(errorMassage: "\(error.localizedDescription)")
                
            }
        }
        self.view?.hideLoader()
    }
    //removeOrAddToFavorite
    private func removeFromFavorites(id: Int){
        APIManager.removeOrAddToFavorite(id: id) { (response) in
            switch response {
            case .success(let result):
                
                print(result.result ?? true)
                self.setDateAndTime()
                self.getDoctorData(id: self.doctorData.id)
                self.view?.reloadDataTableView()
            case .failure(let error):
                self.view?.showingAlerts(errorMassage: "\(error.localizedDescription)")
            }
        }
    }
    private func setUpImageForFavooriteButton(){
        if doctorData.isFavorited{
            self.view?.setImageFullHeartforFavoriteButton()
        }else{
            self.view?.setImageNulHeartforFavoriteButton()
        }
    }
    private func setUpTextToCompaniesLabel(){
        var companiesLabel = ""
        var i = 0
        for companie in doctorData.companies{
            if(i !=  doctorData.companies.count - 1){
                companiesLabel += (companie + ",")
            }else{
                companiesLabel += companie
            }
            i += 1
        }
        self.view?.getCompaniesText(text: companiesLabel)
    }
    //download image
    private func getImageOfDoctor(path: String) {
        
        SDWebImageManager.shared.loadImage(with: URL(string: path), options: .highPriority, progress: nil) { (image, _, error, _, _, _) in
            if let error = error {
                print(error.localizedDescription)
            } else if let image = image {
                self.view?.imagOfDoctor(doctorImage: image)
            }
            
        }
    }
    //set up date
    private func setUpDate(date:Int) -> String{
        let timeInterval = TimeInterval(date)
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
    
    // show location on google map
    private func openLocationInGoogelMap(lat: Decimal, log: Decimal) {
        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(lat),\(log)&zoom=14&views=traffic&q=\(lat),\(log)")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=loc:\(lat),\(log)&zoom=14&views=traffic&q=\(lat),\(log)")!, options: [:], completionHandler: nil)
        }
    }
    // get data of another page
    private func getDataForAnothePage(index: Int){
        if index == (reviews.count - 1){
            if totalpages > page{
                print("\(index)")
                print("has Been Ahiced")
                page += 1
                self.getReviews(id:doctorId, page: page)
                
            }
        }
    }
    
    
    private func setDateAndTime(){
        print(dateIndex)
        print(dateArr.count)
        AppointmentArr = dateArr[dateIndex]
        timeArr = dateArr[dateIndex].times
        self.view?.datteToShow(date: self.setUpDate(date: AppointmentArr.date))
        self.view?.reloadDataForCollectionView()
    }
    
    private func setUpTime(indexPath: Int) -> TimeModel{
        return AppointmentArr.times[indexPath]
    }
    private func setUpDate() -> String{
        return setUpDate(date: AppointmentArr.date)
    }
}

extension DoctorProfileViewModel: DoctorProfileViewModelProtcol{
    func decideWhichPopUpToShow() {
        if UserDefaultsManager.shared().token == nil {
          view?.goToAuthPopUp()
            }else{
          view?.goToVoucher()
        }
    }
    
    func DecideToOpenReviews() {
        if UserDefaultsManager.shared().token == nil {
            self.view?.showingAlerts(errorMassage: "Please Sign Up To Review")
           }else{
            view?.goToReviews()
           }
    }
    

    
    func reloadReviews(id: Int) {
        getReviews(id: id, page: page)
    }
    
    func showAppointment() {
    
        let appointment = AppointmentUser(doctorId: doctorData.id, appointment: timeArr[self.slectedId.item].time, bookForAnother: self.bookForAnother, patientName: self.patientName, voucher: self.voucher)

        view?.goToConfirm(appointment: appointment, voucher: self.voucherId)

    }
    
    func checkStateVoucher(id: Int, voucher: String?, patientName: String?, bookForAnother: Int, useVoucher: Int) {
        print(id)
        if id == 6 {
            if useVoucher == 1 {
                self.voucher = voucher!

                self.voucherId = useVoucher

            }
            if bookForAnother == 1 {
                self.bookForAnother = bookForAnother
                self.patientName = patientName!
            }

            let appointment = AppointmentUser(doctorId: doctorData.id, appointment: timeArr[self.slectedId.item].time, bookForAnother: bookForAnother, patientName: patientName )
            view?.goToConfirm(appointment: appointment, voucher: useVoucher)

        } else {
            view?.showVoucherPopUp(id: id)
        }
    }
    
    func dataOfView(index: Int) -> TimeModel {
        return AppointmentArr.times[index]
    }
    
    func checkSelectedItem(index: IndexPath) -> Bool{
        if self.slectedId == index{
            return true
        }else{
            return false
        }
    }
    
    func dateToShowWithTime(nextDate: Bool) {
        self.slectedId = IndexPath(index: -1)
        if nextDate {
            if (self.dateArr.count - 1) != dateIndex{
                self.dateIndex += 1
            }
            setDateAndTime()
        }else{
            if self.dateIndex == 0{
                setDateAndTime()
            }else{
                self.dateIndex -= 1
                setDateAndTime()
            }
        }
    }
    
    func getDataT0DoctoProfile() {
        self.getDoctorData(id: doctorId)
        self.getReviews(id: doctorId, page: page)
        self.getAppointment(id: doctorId)
    }
    
    func reviewsCount() -> Int {
        print(reviews.count)
        return reviews.count
    }
    
    func getDataOdTheCell(index: Int) -> ReviewModel {
        print("\(reviews[index])")
        return reviews[index]
    }
    
    func removeOrAddFromFavorite(id: Int) {
        removeFromFavorites(id: doctorId)
    }
    
    func detectLastItem(index: Int) {
        getDataForAnothePage(index: index)
    }
    
    func showLocationOnMap() {
        openLocationInGoogelMap(lat: doctorData.langtuid, log: doctorData.langtuid)
    }
    
    func addOrRemoveFromFavorite() {
        if UserDefaultsManager.shared().token != nil{
            removeFromFavorites(id: doctorData.id)
        }else{
            self.view?.showingAlerts(errorMassage: L10n.pleaseSignInAtFristToAddThisDoctorToFavorite)
        }
    }
    
    func numbersOfViews() -> Int{
        if timeArr.count != 0 {
            self.view?.hideNoTimeAvailableLabel(hide: true)
        }else{
            self.view?.hideNoTimeAvailableLabel(hide: false)
        }
        return timeArr.count
    }
    
    func CheckAvalaplityOfTime(timeAvailablty: Bool, index: IndexPath){
        if !timeAvailablty {
            self.view?.enableBookingButton()

            self.view?.changeBackGroundColorOfBookingButton()
            self.view?.changeBackgrounUIViewCell(index1: index, index2: self.slectedId)
            
            self.view?.getIntOfTime(id: timeArr[index.item].time, doctorName: doctorData.name)
            self.slectedId = index
        }else {
            
        }
    }
    func reloadData(id: Int){
        getReviews(id: id, page: page)
    }
    func reloadtime(doctorId: Int) {
        self.getAppointment(id: doctorId)
    }
    
}
