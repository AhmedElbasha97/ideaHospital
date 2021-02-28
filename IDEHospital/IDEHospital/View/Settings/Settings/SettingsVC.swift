//
//  SettingsVC.swift
//  IDEHospital
//
//  Created by bido elbasha on 26/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit
protocol SettingsVCProtocol: class {
    func reloadTableView()
    func navigatorForGuestSettings(id: Int)
    func navigatorForUserSettings(id: Int)
    func showingAlerts(errorMassage: String) 
}
class SettingsVC: UIViewController {
    //MARK:- properties
    //OutLets
    @IBOutlet var settingsView: SettingsView!
    //variables
    var ViewModel: SettingsViewModelProtocol!
    //MARK:- lifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.setUp()
        ViewModel.determineTheVC(signedIn: true)
        self.tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = ColorName.veryLightPink.color
        setUpTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setupNavController(title: L10n.settings, settingColor: true)
        self.setupNavigationItemsSettings(backAction: .popUpCurrent, color: ColorName.whiteTwo.color)
    }
    
    //MARK:-Public Func
    class func create() -> SettingsVC {
        let searchResult: SettingsVC = UIViewController.create(storyboardName: Storyboards.settings, identifier:
            ViewControllers.settingsVC)
        searchResult.ViewModel = SettingsViewModel(view: searchResult)
        return searchResult
    }
}
//MARK:- private Func
extension SettingsVC{
    //set up table view
    private func setUpTableView(){
        settingsView.settingsTableView.register(UINib(nibName: Cells.settingsTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.settingsTableViewCell)
        settingsView.settingsTableView.dataSource = self
        settingsView.settingsTableView.delegate = self
    }
    
    func shareAPP(){
        let textToShare = L10n.shareText
        
        if let myWebsite = URL(string: L10n.appLink) {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = settingsView.settingsTableView
            self.present(activityVC, animated: true)
        }
    }
}
//MARK:- table view dataSource and delegate
extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel.cellNum()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.settingsView.settingsTableView.dequeueReusableCell(withIdentifier: Cells.settingsTableViewCell , for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.Configure(image: ViewModel.cellData(index: indexPath.row).icons, label: ViewModel.cellData(index: indexPath.row).label)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.ViewModel.determineNavigatorForSettings(isSignedIn: true, id: indexPath.row)
    }
    
}
//MARK;- protocol for setting vc
extension SettingsVC: SettingsVCProtocol{

    func navigatorForUserSettings(id: Int) {
        switch id{
        case 0:
         navigationController?.pushViewController(EditProfileVC.create(), animated: true)
        case 1:
            navigationController?.pushViewController(MyFavoriteVC.create(comeFromSettings: true), animated: true)
        case 2:
            navigationController?.pushViewController(MyAppointmentsVC.create(comeFromSettings: true), animated: true)
        case 3:
            print("about Us")
             let terms = AboutUsAndTermsAndConditionVC.create(goToAboutUs: true)
             terms.setupNavigationItemsSettings(backAction: .dismissCurrent, color: ColorName.steelGrey.color)
             let nav = UINavigationController(rootViewController: terms)
             nav.modalPresentationStyle = .fullScreen
             present(nav, animated: true)
             
        case 4:
        print("contactUs")
        let homeNurseVC = HomeNurseVC.create(gotoContactUs: true)
            navigationController?.pushViewController(homeNurseVC, animated: true)
        case 5:
        //put func for sharing
        print("share")
        shareAPP()
        case 6:
            print("terms And Condition")
            print("terms And Condition")
               let terms = AboutUsAndTermsAndConditionVC.create(goToAboutUs: false)
               terms.setupNavigationItemsSettings(backAction: .dismissCurrent, color: ColorName.steelGrey.color)
               let nav = UINavigationController(rootViewController: terms)
               nav.modalPresentationStyle = .fullScreen
               present(nav, animated: true)
               
        default:
            let alert = CancelAppointmentVC.create(yesDelegate: self,label: L10n.areYouSureYouWantToLogOut)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true)

        }
    }
    
    func navigatorForGuestSettings(id: Int) {
        switch id{
        case 0:
            navigationController?.pushViewController(LoginVC.create(), animated: true)
            print("gotologin")
        case 1:
            print("about Us")
             let terms = AboutUsAndTermsAndConditionVC.create(goToAboutUs: true)
             terms.setupNavigationItemsSettings(backAction: .dismissCurrent, color: ColorName.steelGrey.color)
             let nav = UINavigationController(rootViewController: terms)
             nav.modalPresentationStyle = .fullScreen
             present(nav, animated: true)
             
        case 2:
            print("contactUs")
           let homeNurseVC = HomeNurseVC.create(gotoContactUs: true)
           navigationController?.pushViewController(homeNurseVC, animated: true)
        case 3:
            //put func for sharing
            print("share")
            shareAPP()
        default:
            print("terms And Condition")
            let terms = AboutUsAndTermsAndConditionVC.create(goToAboutUs: false)
            terms.setupNavigationItemsSettings(backAction: .dismissCurrent, color: ColorName.steelGrey.color)
            let nav = UINavigationController(rootViewController: terms)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
            
        }
    }
    
    func reloadTableView() {
        self.settingsView.settingsTableView.reloadData()
    }
    
    
    func showingAlerts(errorMassage: String) {
        showPopUp(type: .failure(errorMassage))
     }
}

extension SettingsVC: yesDelegate{
    func yesButton() {
        self.ViewModel.logingOut()
        self.navigationController?.pushViewController(HomeVC.create(), animated: true)
    }
}
