//
//  SuccessBookViewModel.swift
//  IDEHospital
//
//  Created by Kamal on 1/9/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import Foundation
protocol SuccessBookedViewModelProtocl {
    func getImageAndTilte() -> (String, String)
     func okButtonAction() -> String 
}

class SuccessBookedViewModel {
    
    private let popUptype: PopUpType
    private let okbuttonAction: OkButtonAction
    init(popUptype: PopUpType, okbuttonAction: OkButtonAction) {
        self.popUptype = popUptype
        self.okbuttonAction = okbuttonAction
    }
}

extension SuccessBookedViewModel: SuccessBookedViewModelProtocl {
    func getImageAndTilte() -> (String, String) {
        switch popUptype {
        case .success(let title):
            return (Asset.success.name, title)
        case .failure(let title):
            return (Asset.failure.name, title)
        }
    }
    
    func okButtonAction() -> String {
        return okbuttonAction.rawValue
    }

}
