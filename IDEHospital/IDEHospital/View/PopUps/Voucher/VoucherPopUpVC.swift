//
//  VoucherPopUpVC.swift
//  IDEHospital
//
//  Created by Kamal on 1/2/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

protocol DoctorProfilePopUpDelegate: class {
    func voucherDelegation(id: Int, voucher: String?, patientName: String?, bookForAnother: Int, useVoucher: Int)
    func confirmDelegation()
    func cancelDelegation()
    func showError(popUp: PopUpType)

}

protocol VoucherPopUpProtocol: class {
    func switchOneOn()
    func switchOneOff()
    func switchtwoOff()
    func switchtwoOn()
    func popUpAlert(popUp: PopUpType)
    func voucherConfirmation(id: Int, voucher: String?, patientName: String?, bookForAnother: Int, useVoucher: Int)
    func getVoucherCode()-> String?
    func getPatientName() -> String?
}

class VoucherPopUpVC: UIViewController {
    
    //MARK:- Properties
    private var viewModel: VoucherViewModelProtocol!
    weak var delegate: DoctorProfilePopUpDelegate?
    
    //MARK:- Outlets
    @IBOutlet weak var popUpView: VoucherPopUpView!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.setupView()
        switchOneChanged()
        switchTwoChanged()
    }
    
    //MARK:- IBActions
    @IBAction func continueButton(_ sender: UIButton) {
        self.viewModel.switchValidation(code: popUpView.enterCodeTextField.text ?? "", firstSwitch: popUpView.firstSwitch, name: popUpView.enterNameTextField.text ?? "", secondSwitch: popUpView.secondSwitch)
    }
    
    //MARK:- Public Methods
    class func create(delegate: DoctorProfilePopUpDelegate?) -> VoucherPopUpVC {
        let voucher: VoucherPopUpVC = UIViewController.create(storyboardName: Storyboards.PopUps, identifier: ViewControllers.voucherPopUpVC)
        voucher.viewModel = VoucherViewModel(view: voucher)
        voucher.delegate = delegate
        return voucher
    }
    
    func switchOneChanged() {
        popUpView.firstSwitch.isOn = true
        popUpView.firstSwitch.setOn(true, animated: false)
        popUpView.firstSwitch.addTarget(self, action: #selector(switchOneValueDidChange(_:)), for: .valueChanged)
    }
    
    func switchTwoChanged() {
        popUpView.secondSwitch.isOn = true
        popUpView.secondSwitch.setOn(true, animated: false)
        popUpView.secondSwitch.addTarget(self, action: #selector(switchTwoValueDidChange(_:)), for: .valueChanged)
    }
    
    @objc func switchOneValueDidChange(_ sender: UISwitch) {
        viewModel.checkFirstSwitch(firstSwitch: sender)
    }
    
    @objc func switchTwoValueDidChange(_ sender: UISwitch) {
        viewModel.checksecondSwitch(secondSwitch: sender)
    }
}

extension VoucherPopUpVC: VoucherPopUpProtocol {
    func getVoucherCode() -> String? {
        popUpView.enterCodeTextField.text
    }
    
    func getPatientName() -> String? {
        popUpView.enterNameTextField.text

    }
    
    
    func voucherConfirmation(id: Int, voucher: String?, patientName: String?, bookForAnother: Int, useVoucher: Int) {
        self.dismissCurrent()
        delegate?.voucherDelegation(id: id, voucher: voucher, patientName: patientName, bookForAnother: bookForAnother, useVoucher: useVoucher)
    }
    
    func switchtwoOff() {
        popUpView.enterNameTextField.text = ""
        popUpView.enterNameTextField.isUserInteractionEnabled = false
        popUpView.enterNameTextField.isHidden = true
    }
    
    func switchOneOn() {
        popUpView.enterCodeTextField.isUserInteractionEnabled = true
        popUpView.enterCodeTextField.isHidden = false
    }
    
    func switchOneOff() {
        popUpView.enterCodeTextField.text = ""
        popUpView.enterCodeTextField.isUserInteractionEnabled = false
        popUpView.enterCodeTextField.isHidden = true
    }
    
    func switchtwoOn() {
        popUpView.enterNameTextField.isUserInteractionEnabled = true
        popUpView.enterNameTextField.isHidden = false
        
    }
    
    func popUpAlert(popUp: PopUpType) {
        showPopUp(type: popUp, Okbutton: .dismissCurrent)
    }
}


