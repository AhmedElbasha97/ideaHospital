//
//  SearchResultView.swift
//  IDEHospital
//
//  Created by Kamal on 12/20/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation
import UIKit

class SearchResultView: UIView {
    //MARK:- Outlets
    @IBOutlet weak var sortByTextField: UITextField!
    @IBOutlet weak var noSearchResult: UILabel!
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    //MARK:- Properties
    let pickerView = UIPickerView()
    
    //MARK:- Public Methods
    func setUp(view: UIView){
        self.setupBackground()
        arrowImageView.image = Asset.back2.image
        setUpTableView()
        setupTextField(textField: sortByTextField)
        setUpTheLBL(label: noSearchResult)
    }
    
    
    //MARK:- set Up Table View
    private func setUpTableView(){
        searchResultsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        searchResultsTableView.backgroundColor = .clear
        searchResultsTableView.separatorStyle = .none
        searchResultsTableView.allowsSelection = false
    }
    
    //MARK:- Private Methods
    private func setupTextField(textField: UITextField) {
        textField.textColor = ColorName.white.color
        textField.inputView = pickerView
        textField.backgroundColor = ColorName.darkRoyalBlue.color
        textField.font = FontFamily.PTSans.regular.font(size: 12)
        textField.attributedPlaceholder = NSAttributedString(string: "   Sort By", attributes:[NSAttributedString.Key.foregroundColor: ColorName.white.color, NSAttributedString.Key.font: FontFamily.PTSans.regular.font(size: 12)])
        textField.borderStyle = .none
        textField.tintColor = .clear
        
    }
    
    private func setUpTheLBL(label: UILabel){
           label.textColor = ColorName.white.color
           label.font = FontFamily.PTSans.bold.font(size: 35)
        label.textAlignment = .center
           label.text = "no search result"
       
}

}
