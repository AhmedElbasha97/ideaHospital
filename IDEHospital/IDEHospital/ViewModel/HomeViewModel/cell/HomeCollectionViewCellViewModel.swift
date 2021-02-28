//
//  HomeCollectionViewCellViewModel.swift
//  IDEHospital
//
//  Created by bido elbasha on 18/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit
import SDWebImage

protocol HomeCollectionViewCellViewModelProtocol {
    func fetchData(data: MainCategorie)
}
class HomeCollectionViewCellViewModel{
    private weak var view: HomeCollectionViewCellProtocol?
    
    // MARK:- Life Cycle Methods
      init(view: HomeCollectionViewCellProtocol) {
          self.view = view
      }
}
//MARK:- PrivateFunc
extension HomeCollectionViewCellViewModel{
      //MARK:- download categorie image
    func downloadImage(for URLImage: String, completion: @escaping (UIImage?) -> Void) {
          
          SDWebImageManager.shared.loadImage(with: URL(string: URLImage), options: .highPriority, progress: nil) { (image, _, error, _, _, _) in
              if let error = error {
                  print(error.localizedDescription)
              } else if let image = image {
                  completion(image)
              }
  
          }
      }
}
extension HomeCollectionViewCellViewModel: HomeCollectionViewCellViewModelProtocol{
    func fetchData(data: MainCategorie) {
        downloadImage(for: data.image) { (image) in
            self.view?.configurefunc(categoryLabel: data.name, cotegoryImage: (image ?? nil)!, colorOfBackGround: UIColor.init(hexString: data.color))
        }
        
    }
    
    
}
