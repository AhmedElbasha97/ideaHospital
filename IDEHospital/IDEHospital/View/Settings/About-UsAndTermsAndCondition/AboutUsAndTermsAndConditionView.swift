//
//  AboutUsView.swift
//  IDEHospital
//
//  Created by bido elbasha on 27/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

class AboutUsAndTermsAndConditionView: UIView {
    
    @IBOutlet weak var aboutUsAndTermsAndConditonTextView: UITextView!
    //MARK:- Public Methods
    func setUp(view: UIView){
        self.setupBackground()
        self.setUpTextView()
       }
    //setup text view
    private func setUpTextView(){
        aboutUsAndTermsAndConditonTextView.backgroundColor = .clear
    }

}
