//
//  UITableView+Cell.swift
//  IDEHospital
//
//  Created by bido elbasha on 21/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

extension UITableViewCell{
    
    // MARK:- Public Methods
    func setUpViewCell(cell: UITableViewCell){
        cell.layoutIfNeeded()
        let viewSeparatorLine = UIView(frame:CGRect(x:  0, y: cell.frame.size.height - 1, width: bounds.size.width, height: 1))
             viewSeparatorLine.backgroundColor = ColorName.white.color
             cell.contentView.addSubview(viewSeparatorLine)
             cell.backgroundColor = .clear
             cell.isOpaque = false
    }
    
}
