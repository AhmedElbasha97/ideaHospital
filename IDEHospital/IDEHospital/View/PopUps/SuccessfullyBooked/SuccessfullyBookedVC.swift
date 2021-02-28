//
//  SuccessfullyBookedVC.swift
//  IDEHospital
//
//  Created by Kamal on 1/3/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

protocol SuccessDelegate: class {
    func okPressed()
}
protocol reloadData: class {
    func reload()
}
protocol reloadDataForTimeView: class{
    func SetUpTimeAgain()
}
enum PopUpType {
    case success(_ title: String)
    case failure(_ title: String)
}

enum OkButtonAction: String {
    case dismissCurrent
    case goToHome
    case doctorProfileView
    case delegation
}

class SuccessfullyBookedVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var popUpView: SuccessfullyBookedView!
    
    //MARK:- Properties
    private var viewModel: SuccessBookedViewModelProtocl!
    weak var delegate: SuccessDelegate?
    weak var relaodDelegat: reloadData?
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.setupView(image: viewModel.getImageAndTilte().0, title: viewModel.getImageAndTilte().1)
    }
    
    //MARK:- IBActions
    @IBAction func okButtonPressed(_ sender: UIButton) {
        popUpView.okButton.addTarget(self, action: Selector(viewModel.okButtonAction()), for: .touchUpInside)
    }
    
    //MARK:- Public Methods
    class func create(popUpType: PopUpType, okButton: OkButtonAction, delegate: SuccessDelegate? = nil, relaodDelegate: reloadData? = nil) -> SuccessfullyBookedVC {
        let confirm: SuccessfullyBookedVC = UIViewController.create(storyboardName: Storyboards.PopUps, identifier: ViewControllers.successfullyBookedVC)
        confirm.delegate = delegate
        confirm.relaodDelegat = relaodDelegate
        confirm.viewModel = SuccessBookedViewModel(popUptype: popUpType, okbuttonAction: okButton)
        return confirm
    }
    
    @objc func delegation() {
        dismissCurrent()
        delegate?.okPressed()
    }
    @objc func doctorProfileView(){
        dismissCurrent()
        relaodDelegat?.reload()
    }
}


