//
//  AboutUsVCViewController.swift
//  IDEHospital
//
//  Created by bido elbasha on 27/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit
protocol AboutUsAndTermsAndConditionVCProtcol: class {
    func showloader()
    func hideLoader()
    func showingAlerts(errorMassage: String)
    func showDataInLabel(data: NSAttributedString)
    func setUpLabelOfNavBar(label: String)  
}

class AboutUsAndTermsAndConditionVC: UIViewController {
    //MARK:- properties
    @IBOutlet weak var aboutUsView: AboutUsAndTermsAndConditionView!
        //variables
    var ViewModel: AboutUsViewModelProtocol!
    //MARK:- lifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewModel.getVCData()
        self.aboutUsView.setUp(view: self.aboutUsView)
    }
    
    //MARK:- puolic func
    class func create(goToAboutUs: Bool) -> AboutUsAndTermsAndConditionVC {
        let aboutUsAndTermsAndConditionVC: AboutUsAndTermsAndConditionVC = UIViewController.create(storyboardName: Storyboards.settings, identifier:
            ViewControllers.aboutUsAndConditionVC)
        aboutUsAndTermsAndConditionVC.ViewModel = AboutUsAndTermsAndConditionViewModel(view: aboutUsAndTermsAndConditionVC)
        aboutUsAndTermsAndConditionVC.ViewModel.goToAboutUs(goToAboutUs: goToAboutUs)
        
        return aboutUsAndTermsAndConditionVC
    }
}
//MARK:- protocol using
extension AboutUsAndTermsAndConditionVC: AboutUsAndTermsAndConditionVCProtcol{
    func showDataInLabel(data: NSAttributedString) {
     self.aboutUsView.aboutUsAndTermsAndConditonTextView.attributedText = data
     self.aboutUsView.aboutUsAndTermsAndConditonTextView.textColor = ColorName.white.color
    }
    
    func showloader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func showingAlerts(errorMassage: String) {
        showPopUp(type: .failure(errorMassage))
    }
    
    func setUpLabelOfNavBar(label: String)  {
        self.setupNavController(title: label, settingColor: false)
    }
    
}
