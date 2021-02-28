//
//  AppointmentTableViewCellViewModel.swift
//  IDEHospital
//
//  Created by bido elbasha on 20/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit
import SDWebImage

//MARK:- protocol
protocol AppointmentTableViewCellViewModelProtocol: class {
    func cellconfiguretion(cell: AppointmentModel, Index: Int)
}

//MARK:- class
class AppointmentTableViewCellViewModel{
   
    private weak var view: AppointmentTableViewCellProtcol?
    
    // MARK:- Life Cycle Methods
      init(view: AppointmentTableViewCellProtcol) {
          self.view = view
      }
}
//MARK:- private func
extension AppointmentTableViewCellViewModel{
    //download image
    private func getImageOfDoctor(path: String, completion: @escaping (UIImage?) -> Void) {
        
         SDWebImageManager.shared.loadImage(with: URL(string: path), options: .highPriority, progress: nil) { (image, _, error, _, _, _) in
         if let error = error {
             print(error.localizedDescription)
         } else if let image = image {
             completion(image)
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
    //set up time
    private func setUpTime(time: Int) -> String{
        let timeInterval = TimeInterval(time)
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
//MARK:- Conform protocol
extension AppointmentTableViewCellViewModel: AppointmentTableViewCellViewModelProtocol{

    
    func cellconfiguretion(cell: AppointmentModel, Index: Int) {
        getImageOfDoctor(path: cell.doctor.image) { (image) in
            self.view?.configure(doctorName: cell.doctor.name, description: cell.doctor.bio, doctorImage: image!, date: self.setUpDate(date: cell.appointment), time: self.setUpTime(time: cell.appointment), raiting: Double(cell.doctor.rating) , reviews: "\(cell.doctor.reviewsCount)", appointmentID: cell.id, lng: cell.doctor.langtuid, lat: cell.doctor.langtuid, index: Index)
        }
    }
    
    
}

