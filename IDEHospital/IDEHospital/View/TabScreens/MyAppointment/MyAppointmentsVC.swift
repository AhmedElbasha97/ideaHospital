//
//  MyAppointmentsVC.swift
//  IDEHospital
//
//  Created by bido elbasha on 15/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit
import UIKit
//MARK:- MyAppointments protcol
protocol MyAppointmentsVCProtcol: class {
    func showNoData(label1: String)
    func showloader()
    func hideLoader()
    func showingAlerts(errorMassage: String)
    func reloadData()
    func setUPNavBarComeFromSettings(haveSettingBTN: Bool)
    func setUpTabBar()
    func setUPNavBarComeFromHome(haveSettingBTN: Bool)

}

class MyAppointmentsVC: UIViewController {
    //MARK:- properties
    @IBOutlet weak var myAppointmantView: MyAppointmentsView!
    //variables
    private var viewModel: AppointmentViewModelProtcol!
    private var appointmentindex: Int!
    private var index: Int!
    //MARK:-life cycle function
    override func viewDidLoad() {
        super.viewDidLoad()
        myAppointmantView.setUp(view: self.myAppointmantView)
       
        setUpTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.setUPNavBar()
            viewModel.getDataToAppointmentTableView()
      }
    // MARK:- Public Methods
    class func create(comeFromSettings: Bool) -> MyAppointmentsVC {
        let myAppointmentsVC: MyAppointmentsVC = UIViewController.create(storyboardName: Storyboards.tabScreens, identifier:
            ViewControllers.myAppointmentsVC)
        myAppointmentsVC.viewModel = AppointmentViewModel(view: myAppointmentsVC)
        myAppointmentsVC.viewModel.navugateFromWhere(comeFromSettings: comeFromSettings)
        return myAppointmentsVC
    }

}

//MARK:- private func
extension MyAppointmentsVC{
    
    //set up table view
    private func setUpTableView() {
        myAppointmantView.appiontmentTableView.register(UINib(nibName: Cells.appointmentTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.appointmentTableViewCell)
        myAppointmantView.appiontmentTableView.dataSource = self
        myAppointmantView.appiontmentTableView.delegate = self
    }
    
    private func SetTabBar(){
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 2
    }
    
    private func setupNavigation(haveSettingBTN: Bool, back: Back) {
        self.setupNavController(title: L10n.myAppointments, settingColor: false)
        self.setupNavigationItems(backAction: back, haveSettingBTN: haveSettingBTN)
    }
}

extension MyAppointmentsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfCells()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.myAppointmantView.appiontmentTableView.dequeueReusableCell(withIdentifier: Cells.appointmentTableViewCell , for: indexPath) as? AppointmentTableViewCell else {
            return UITableViewCell()
        }
      
        cell.SendDataToViewModel(cell: viewModel.getDataOfTheCell(index: indexPath.row), index: indexPath.row)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.myAppointmantView.appiontmentTableView.deselectRow(at: indexPath, animated: true)
    }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 40
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 40
        }
    }
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.detectLastItem(index: indexPath.row)
    }
}
//MARK:- conform delegate
extension MyAppointmentsVC: AppointmentTableViewCellDelegate{
    func removeFromAppointmentTable(customTableViewCell: UITableViewCell, didTapButton button: UIButton, appointmentID: Int, index: Int) {
        self.appointmentindex = appointmentID
        self.index = index
        let alert = CancelAppointmentVC.create(yesDelegate: self, label: L10n.areYouSureWantToDeleteThisAppointment)
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        self.present(alert, animated: true, completion: nil)
    }
    
 
    func showLocationOnMab(lng: Decimal, lat: Decimal) {
        self.viewModel.openLocAtionOnMap(lat: lat, log: lng)
    }
    
    
}

extension MyAppointmentsVC: MyAppointmentsVCProtcol {
    func showNoData(label1: String) {
        self.myAppointmantView.nodataLabel.isHidden = true
    }
    
    func showloader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func showingAlerts(errorMassage: String) {
        showPopUp(type: .failure(errorMassage))
    }
    
    func reloadData() {
        myAppointmantView.appiontmentTableView.reloadData()
    }
    
      func setUPNavBarComeFromHome(haveSettingBTN: Bool) {
        setupNavigation(haveSettingBTN: haveSettingBTN, back: .dismissCurrent)
    }
    
    func setUpTabBar() {
        SetTabBar()
    }
    
    func setUPNavBarComeFromSettings(haveSettingBTN: Bool) {
        setupNavigation(haveSettingBTN: haveSettingBTN, back: .popUpCurrent)
    }
    
    
}
extension MyAppointmentsVC: yesDelegate{
    
    func yesButton() {
        self.viewModel.removeFromAppointment(id: appointmentindex, index: index)
    }

    
}
