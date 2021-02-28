//
//  MyAppointmentsViewModel.swift
//  IDEHospital
//
//  Created by bido elbasha on 15/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import SDWebImage
import UIKit

protocol AppointmentViewModelProtcol: class {
    func getDataToAppointmentTableView()
    func numberOfCells() -> Int
    func getDataOfTheCell(index: Int) -> AppointmentModel
    func removeFromAppointment(id: Int, index: Int)
    func detectLastItem(index: Int)
    func openLocAtionOnMap(lat: Decimal, log: Decimal)
    func setUPNavBar()
    func navugateFromWhere(comeFromSettings: Bool)
}

class AppointmentViewModel{
    //MARK:- Variables
    private weak var view: MyAppointmentsVCProtcol?
    private var cellsData = [AppointmentModel]()
    private var totalpages: Int!
    private var page: Int = 1
    private var comeFromSeetings: Bool!
    
    // MARK:- Life Cycle Methods
    init(view: MyAppointmentsVCProtcol) {
        self.view = view
    }
}
//MARK:- Private Func
extension AppointmentViewModel{
    //MARK:- API
    //get data of appointment
    private func getAppointmentData(page: Int) {
        self.view?.showloader()
        APIManager.getUserAppointment(page: page) { (result) in
            switch result{
              case .failure(let error):
                print(error)
                if UserDefaultsManager.shared().token == ""{
                    print("true")
                    self.view?.showingAlerts(errorMassage: error.localizedDescription)
                }
            case .success(let data):
                if data.reault == true && data.code == 200{
                if self.page == 1{
                    self.cellsData = data.data.items
                    self.totalpages = data.data.totalPages
                }else{
                    for cell in data.data.items{
                        self.cellsData.append(cell)
                    }
                }
                }else{
                    self.view?.showingAlerts(errorMassage: data.message ?? "")
                }
            }
            print(self.cellsData)
            self.view?.reloadData()
            self.view?.hideLoader()
        }
        
    }
    // remove data from appointment
    private func removeFromAppointments(id: Int, index: Int){
        APIManager.deleteFromAppointment(id: id) { (response) in
            switch response {
            case .success(let result):
                self.cellsData.remove(at: index)
                 print(result.result ?? true)
                 
                 self.view?.reloadData()
            case .failure(let error):
                self.view?.showingAlerts(errorMassage: "\(error.localizedDescription)")
            }
        }
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
        if index == (cellsData.count - 1){
            if totalpages > page{
                print("\(index)")
                print("has Been Ahiced")
                page += 1
                self.getAppointmentData(page: page)
                
            }
        }
    }
    private func comeFromWhere(){
        if comeFromSeetings{
            self.view?.setUPNavBarComeFromSettings(haveSettingBTN: false)
        }else{
            self.view?.setUPNavBarComeFromHome(haveSettingBTN: true)
            self.view?.setUpTabBar()
        }
    }
}

extension AppointmentViewModel: AppointmentViewModelProtcol{
    func openLocAtionOnMap(lat: Decimal, log: Decimal) {
        openLocationInGoogelMap(lat: lat, log: log)
    }
    
    func removeFromAppointment(id: Int, index: Int) {
        removeFromAppointments(id: id, index: index)
    }
    
    func getDataOfTheCell(index: Int) -> AppointmentModel {
        return cellsData[index]
    }
    
    func numberOfCells() -> Int {
        print(cellsData.count)
        if cellsData.count == 0{
            return cellsData.count
        } else {
            self.view?.showNoData(label1: "")
            return cellsData.count
        }
    }
    
    func getDataToAppointmentTableView() {
        getAppointmentData(page: self.page)
    }
    
    func detectLastItem(index: Int) {
        self.getDataForAnothePage(index: index)
    }
    
    func setUPNavBar(){
        self.comeFromWhere()
    }
    
    func navugateFromWhere(comeFromSettings: Bool) {
        self.comeFromSeetings = comeFromSettings
    }
}



