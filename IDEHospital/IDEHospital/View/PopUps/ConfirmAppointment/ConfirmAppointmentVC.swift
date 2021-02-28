//
//  ConfrimAppointmentVC.swift
//  IDEHospital
//
//  Created by Kamal on 1/3/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

protocol ConfirmAppointmentProtocol: class {
    func popUpAlert(popUp: PopUpType)
}

class ConfirmAppointmentVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var confirmView: ConfirmAppointmentView!
    
    //MARK:- Properties
    private var viewModel: ConfirmAppointmentViewModelProtocol!
    weak var delegate: DoctorProfilePopUpDelegate?
    //MARK:-  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmView.setupView(dateAndTime: viewModel.getDateAndTime(), doctorName: viewModel.getDoctorName())
    }
    
    //MARK:- Public Methods
    class func create(appointment: AppointmentUser, name: String, docotorDelegate: DoctorProfilePopUpDelegate?, voucher: Int) -> ConfirmAppointmentVC {
        let confirm: ConfirmAppointmentVC = UIViewController.create(storyboardName: Storyboards.PopUps, identifier: ViewControllers.confirmAppointmentVC)
        confirm.viewModel = ConfirmAppointmentViewModel(view: confirm, doctorName: name, appointment: appointment, voucher: voucher)
        confirm.delegate = docotorDelegate
        return confirm
    }
    
    //MARK:- IBActions
    @IBAction func confirmButton(_ sender: UIButton) {
        viewModel.doctorBook()
        self.dismissCurrent()
        delegate?.confirmDelegation()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismissCurrent()
        delegate?.cancelDelegation()
    }
}

extension ConfirmAppointmentVC: ConfirmAppointmentProtocol {
    
    func popUpAlert(popUp: PopUpType) {
        self.dismissCurrent()
        delegate?.showError(popUp: popUp)
    }
}
