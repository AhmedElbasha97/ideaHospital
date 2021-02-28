//
//  MyFavoriteView.swift
//  IDEHospital
//
//  Created by bido elbasha on 15/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

class MyFavoriteView: UIView {

    @IBOutlet weak var noDataLabe: UILabel!
    @IBOutlet weak var favoriteTableView: UITableView!
    func setUp(view: UIView){
        self.setupBackground()
        setUpTableView()
        setUpTheLBL(label: noDataLabe)
    }
    //MARK:- set Up Table View
    private func setUpTableView(){
        favoriteTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        favoriteTableView.backgroundColor = .clear
        favoriteTableView.allowsSelection = false

    }
    private func setUpTheLBL(label: UILabel){
        label.textColor = ColorName.white.color
        label.font = FontFamily.PTSans.bold.font(size: 35)
    }
}
