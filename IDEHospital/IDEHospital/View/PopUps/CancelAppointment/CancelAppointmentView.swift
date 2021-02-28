//
//  CancelAppointmentView.swift
//  IDEHospital
//
//  Created by Kamal on 1/3/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

class CancelAppointmentView: UIView {
    //MARK:- Outlets
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    //MARK:- Public Method
    func setupView(label: String) {
        setupLabel(label: mainLabel, text: label)
        setupButton(button: yesButton, color: ColorName.darkRoyalBlue.color, title: L10n.yes)
        setupButton(button: noButton, color: ColorName.richPurple.color, title: L10n.no)
        popUpView.layer.cornerRadius = popUpView.frame.height / 19
        self.backgroundColor = ColorName.brownishGrey.color.withAlphaComponent(0.8)
    }
    
    //MARK:- Private Methods
    private func setupLabel(label: UILabel, text: String) {
        label.textAlignment = .center
            label.text = text
            label.textColor = ColorName.darkRoyalBlue.color
            label.font = FontFamily.PTSans.bold.font(size: 15)
            label.adjustsFontSizeToFitWidth = true
    }
    

    private func heightForView(text:String, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }

 
    private func setupButton(button: UIButton, color: UIColor, title: String) {
        button.backgroundColor = color
        button.layer.cornerRadius = button.frame.height / 2.5
            button.layer.borderWidth = 0
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = FontFamily.PTSans.regular.font(size: 15)
            button.setTitleColor(ColorName.white.color, for:UIControl.State.normal)
    }
    
    
    
    
    
    
    
    
    
    
}
