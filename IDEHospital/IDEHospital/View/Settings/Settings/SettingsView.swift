//
//  SettingsView.swift
//  IDEHospital
//
//  Created by bido elbasha on 26/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    //MARK:- Properties
    //Outlets
    @IBOutlet weak var settingsTableView: UITableView!
    //MARK:- Public Methods
    func setUp(){
    setUpTableView()
    }
    //MARK:- set Up Table View
    private func setUpTableView(){
        settingsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        settingsTableView.backgroundColor = ColorName.veryLightPink.color
    }

}


