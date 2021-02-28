//
//  FavoriteTableCellViewModel.swift
//  IDEHospital
//
//  Created by bido elbasha on 20/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//


import UIKit
import SDWebImage
//MARK:- Protocols
protocol FavoriteTableCellViewModelProtocol: class {
    func cellconfiguretion(cell: DoctorModel)
}
//Mark:- Class
class FavoriteTableCellViewModel{
   
    private weak var view: FavoriteTableViewCellProtcol?
    
    // MARK:- Life Cycle Methods
      init(view: FavoriteTableViewCellProtcol) {
          self.view = view
      }

}
//MARK:- private func
extension FavoriteTableCellViewModel{
    //MARK:- API
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
}
//MARK:- conform protcol
extension FavoriteTableCellViewModel: FavoriteTableCellViewModelProtocol{
    func cellconfiguretion(cell: DoctorModel) {
        getImageOfDoctor(path: cell.image) { (image) in
            self.view?.configure(doctorName: cell.name, doctorSpecialty: cell.specialty, doctorImage: image!, hospitalName: cell.secondBio, hospitalLocation: "\(cell.region): \(cell.address)", Fees: "\(L10n.examinationFees + "\(cell.fees)" + L10n.le)", waitingTime: "\(L10n.waitingTime + "\(cell.waitingTime)" + L10n.minutes)", raiting: Double(cell.rating), reviews: "\(cell.reviewsCount)", doctorID: cell.id)
        }
    }
    
    
}
