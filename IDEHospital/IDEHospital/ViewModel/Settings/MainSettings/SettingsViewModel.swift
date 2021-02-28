//
//  Settings.swift
//  IDEHospital
//
//  Created by bido elbasha on 26/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

protocol SettingsViewModelProtocol: class{
    func cellNum() -> Int
    func cellData(index: Int) -> SettingsTableViewModel
    func determineTheVC(signedIn: Bool)
    func determineNavigatorForSettings(isSignedIn: Bool, id: Int)
    func logingOut() 
}

class SettingsViewModel{
      //MARK:- Properties
      private var view: SettingsVCProtocol!
      private var Settting: [SettingsTableViewModel]!
      //MARK:- Init
       init(view: SettingsVCProtocol) {
           self.view = view
       }
    
}

//MARK:- private func
extension SettingsViewModel{
 //determine which table view of setting will be used
    private func detectWhichSettingWillLoad(isSignedIn: Bool) -> [SettingsTableViewModel]{
        let logIn = SettingsTableViewModel(icons: Asset.settingsLogin.image, label: L10n.login)
        let aboutUs = SettingsTableViewModel(icons: Asset.settingsAboutUs.image, label: L10n.aboutUs)
        let contactUs = SettingsTableViewModel(icons: Asset.settingscontact.image, label: L10n.contactUs)
        let share = SettingsTableViewModel(icons: Asset.settingsshare.image, label: L10n.share)
        let termsAndCondition = SettingsTableViewModel(icons: Asset.settingssheet.image, label: L10n.termsConditions)
        let editProfile = SettingsTableViewModel(icons: Asset.settingsuser.image, label: L10n.editProfile)
        let favorites = SettingsTableViewModel(icons: Asset.settingsFavorite.image, label: L10n.favorite)
        let bookAppointment = SettingsTableViewModel(icons: Asset.settingsClendar.image, label: L10n.bookedAppointments)
        let logOut = SettingsTableViewModel(icons: Asset.settingsLogOut.image, label: L10n.logout)
        if isSignedIn{
            return  [editProfile, favorites, bookAppointment, aboutUs, contactUs, share, termsAndCondition, logOut]
        }else{
            return [logIn, aboutUs, contactUs, share, termsAndCondition]
        }
        self.view.reloadTableView()
        
        
    }
//determine which navigator used
    private func deteremineWhichNavigatorTOUse(isSignedIn: Bool, id: Int){
        if isSignedIn{
            view.navigatorForUserSettings(id: id)
        }else{
            view.navigatorForGuestSettings(id: id)
        }
   }
//logOut the user
    private func logOutTheUser() {
        APIManager.logOut { (response) in
            switch response{
            case .success(let result):
                if result.message != nil{
                    self.view.showingAlerts(errorMassage: result.message!)
                }
                UserDefaultsManager.shared().token = nil
                print(result.result ?? false)
            case .failure(let error):
                self.view.showingAlerts(errorMassage: error.localizedDescription)
            }
        }
    }
}
//MARK:- protocol for Setting View Model
extension SettingsViewModel: SettingsViewModelProtocol{
    func logingOut()  {
     logOutTheUser()
    }

    func determineNavigatorForSettings(isSignedIn: Bool, id: Int) {
        if UserDefaultsManager.shared().token == nil{
        deteremineWhichNavigatorTOUse(isSignedIn: false, id: id)
        }else{
        deteremineWhichNavigatorTOUse(isSignedIn: true, id: id)
        }
     
    }

    
    func cellNum() -> Int {
        print("\(Settting.count)")
        return Settting.count
    }
    
    func cellData(index: Int) -> SettingsTableViewModel {
        return Settting[index]
    }
    
    func determineTheVC(signedIn: Bool) {
        if UserDefaultsManager.shared().token == nil{
                Settting = detectWhichSettingWillLoad(isSignedIn: false)
        }else{
                Settting = detectWhichSettingWillLoad(isSignedIn: true)
            
        }

        print("yes detect")
    }
    
    
}
