//
//  CancelAppointmentVC.swift
//  IDEHospital
//
//  Created by Kamal on 1/3/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit
protocol yesDelegate: class{
    func yesButton()
}

protocol noDelegate: class{
    func noButton()
}

class CancelAppointmentVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var popUpView: CancelAppointmentView!
    weak var yesdelegate: yesDelegate?
    weak var nodelegate: noDelegate?
    private var label: String!
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.setupView(label: label)
    }
    
    //MARK:- Public Methods
    class func create(yesDelegate: yesDelegate? = nil, noDelegate: noDelegate? = nil, label: String) -> CancelAppointmentVC {
        let cancel: CancelAppointmentVC = UIViewController.create(storyboardName: Storyboards.PopUps, identifier: ViewControllers.cancelAppointmentVC)
        cancel.label = label
        cancel.yesdelegate = yesDelegate
         cancel.nodelegate = noDelegate
        return cancel
    }
    
    @IBAction func noButton(_ sender: UIButton) {
        dismissCurrent()
        nodelegate?.noButton()
    }
    
    @IBAction func yesButton(_ sender: UIButton) {
        dismissCurrent()
        yesdelegate?.yesButton()
    }
    
    
}
