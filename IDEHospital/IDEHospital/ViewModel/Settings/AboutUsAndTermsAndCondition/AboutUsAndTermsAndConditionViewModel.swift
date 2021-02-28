//
//  AboutUsViewModel.swift
//  IDEHospital
//
//  Created by bido elbasha on 27/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation
protocol AboutUsViewModelProtocol {
    func getVCData()
    func goToAboutUs(goToAboutUs: Bool)
}
class AboutUsAndTermsAndConditionViewModel{
    //MARK:- Properties
    private var goToAboutUs: Bool!
    private var view: AboutUsAndTermsAndConditionVCProtcol!
    //MARK:- Init
     init(view: AboutUsAndTermsAndConditionVCProtcol!) {
         self.view = view
     }
}
//MARK:- Private func
extension AboutUsAndTermsAndConditionViewModel{
    //MARK:-Api
    //about us
    func getAboutUsDta() {
        self.view.showloader()
        APIManager.getAboutUsData { (response) in
             switch response{
             case.success(let result):
                self.view.showDataInLabel(data: result.data.aboutUs.htmlToAttributedString!)
                 print("\(String(describing: result.data.aboutUs.htmlToString))")
             case .failure(let error):
                self.view.showingAlerts(errorMassage: error.localizedDescription)
                 print("\(error.localizedDescription)")
             }
         }
        self.view.hideLoader()
    }
    //terms and condition
    func getTermsAndConditionData() {
        self.view.showloader()
        APIManager.getTermsAndConditionData { (response) in
             switch response{
             case.success(let result):
                self.view.showDataInLabel(data: result.data.TermsAndConditions.htmlToAttributedString!)
                 print("\(String(describing: result.data.TermsAndConditions.htmlToString))")
             case .failure(let error):
                self.view.showingAlerts(errorMassage: error.localizedDescription)
                 print("\(error.localizedDescription)")
             }
         }
        self.view.hideLoader()
    }
    private func decideWhichDataToShow(){
        if goToAboutUs{
            view.setUpLabelOfNavBar(label: L10n.aboutUs)
            getAboutUsDta()
        }else{
            view.setUpLabelOfNavBar(label: L10n.termsConditions)
            getTermsAndConditionData()
        }
    }
}
//MARK:- Conform view model protocol
extension AboutUsAndTermsAndConditionViewModel: AboutUsViewModelProtocol {
    func getVCData() {
       decideWhichDataToShow()
    }
    func goToAboutUs(goToAboutUs: Bool){
        self.goToAboutUs = goToAboutUs
    }

}
