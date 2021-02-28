//
//  ConfirmAppointmentViewModel.swift
//  IDEHospital
//
//  Created by Kamal on 1/7/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//
import Foundation
protocol ConfirmAppointmentViewModelProtocol {
    func doctorBook()
    func getDateAndTime() -> String
    func getDoctorName() -> String
}

class ConfirmAppointmentViewModel {
    //MARK:- Properties
    var view: ConfirmAppointmentProtocol!
    var doctorName: String!
    var appointment: AppointmentUser!
    var voucher: Int?
    
    //MARK:- Init
    init(view: ConfirmAppointmentProtocol!, doctorName: String, appointment: AppointmentUser, voucher: Int) {
        self.view = view
        self.doctorName = doctorName
        self.appointment = appointment
        self.voucher = voucher
    }
}

extension ConfirmAppointmentViewModel {
    private func checkAppointmentResponse(_ response: AppointmentResponse) {
        if response.success == true , response.code == 202 {
            view?.popUpAlert(popUp: .success(L10n.successfullyBooked))
            print("1111")
        } else if let responseMessage = response.message {
            view?.popUpAlert(popUp: .failure(responseMessage))
            print("22222")
            
        } else if let voucherError = response.errors?.voucher?[0] {
            DispatchQueue.main.async {
                self.view?.popUpAlert(popUp: .failure(voucherError))
                
            }
            print("333")
            
        } else if let appointmentError = response.errors?.appointment?[0] {
            view.popUpAlert(popUp: .failure(appointmentError))
            print("4444")
        }
    }
    
    private func bookDoctorAppointment(user: AppointmentUser) {
        APIManager.bookAppointement(user: user) { (result) in
            switch result {
            case .success(let response):
                self.checkAppointmentResponse(response)
            case .failure (let error):
                print(error)
                self.view.popUpAlert(popUp: .failure("response Error"))
            }
        }
    }
    
    private func createTime(timestamp: Int) -> String {
        var strDate = ""
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = L10n.timeFormat //Specify your format that you want
        dateFormatter.amSymbol = L10n.am
        dateFormatter.pmSymbol = L10n.pm
        strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    private func createDate(timestamp: Int) -> String {
        var strDate = ""
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = L10n.dateFormat //Specify your format that you want
        strDate = dateFormatter.string(from: date)
        return strDate
    }
}

extension ConfirmAppointmentViewModel: ConfirmAppointmentViewModelProtocol {
    
    func doctorBook() {
        var user: AppointmentUser!
        if self.voucher == 0 {
            user = AppointmentUser(doctorId: appointment.doctorId, appointment: appointment.appointment , bookForAnother: appointment.bookForAnother, patientName: appointment.patientName)
            print("asfasdasdasfdasd")
            
        } else {
            user = AppointmentUser(doctorId: appointment.doctorId, appointment: appointment.appointment , bookForAnother: appointment.bookForAnother, patientName: appointment.patientName, voucher: appointment.voucher)
        }
        bookDoctorAppointment(user: user)
    }
    
    func getDoctorName() -> String {
        return doctorName
    }
    
    func getDateAndTime() -> String {
        return "\(createDate(timestamp: appointment.appointment)) \(createTime(timestamp: appointment.appointment))"
    }
}
