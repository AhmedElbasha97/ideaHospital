//
//  MyAppointmentsView.swift
//  IDEHospital
//
//  Created by bido elbasha on 15/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

class MyAppointmentsView: UIView {
    
    @IBOutlet weak var nodataLabel: UILabel!
    @IBOutlet weak var appiontmentTableView: UITableView!
    
    func setUp(view: UIView){
         self.setupBackground()
        setUpTableView()
        setUpTheLBL(label: nodataLabel)
     }
    
    //MARK:- set Up Table View
    private func setUpTableView(){
        appiontmentTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        appiontmentTableView.backgroundColor = .clear
        appiontmentTableView.allowsSelection = false
        
        
        appiontmentTableView.estimatedRowHeight = UITableView.automaticDimension

    }
    private func setUpTheLBL(label: UILabel){
           label.textColor = ColorName.white.color
           label.font = FontFamily.PTSans.bold.font(size: 35)
           label.text = "no appointment"
       }
}
