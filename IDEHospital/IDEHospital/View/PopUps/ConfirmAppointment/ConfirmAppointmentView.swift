//
//  ConfirmAppointmentView.swift
//  IDEHospital
//
//  Created by Kamal on 1/3/21.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

class ConfirmAppointmentView: UIView {
    //MARK:- Outlets
    @IBOutlet weak var PopUpView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var detailsLabel: UILabel!
    
    //MARK:- Public Methods
    func setupView(dateAndTime: String, doctorName: String) {
        setupCancelButton(button: cancelButton)
        PopUpView.layer.cornerRadius = PopUpView.frame.height / 19
        setupConfrimLabel(label: confirmLabel)
        setupConfirmButton(button: confirmButton)
        setupDateAndTimeLabel(dateAndTime, doctorName)
        self.backgroundColor = ColorName.brownishGrey.color.withAlphaComponent(0.8)
    }
    
    //MARK:- Private Methods
    private func setupCancelButton(button: UIButton) {
        button.setImage(Asset.component341.image, for: .normal)
        button.tintColor = ColorName.darkRoyalBlue.color
    }
    
    private func setupConfrimLabel(label: UILabel) {
        label.textAlignment = .center
        label.text = L10n.confirmYourAppointment
        label.textColor = ColorName.darkRoyalBlue.color
        label.font = FontFamily.PTSans.bold.font(size: 15)
        label.adjustsFontSizeToFitWidth = true
    }
    
    private func setupConfirmButton(button: UIButton) {
        button.backgroundColor = ColorName.darkRoyalBlue.color
        button.layer.cornerRadius = button.frame.height / 2.5
        button.layer.borderWidth = 0
        button.setTitle(L10n.confirm, for: .normal)
        button.titleLabel?.font = FontFamily.PTSans.bold.font(size: 15)
        button.setTitleColor(ColorName.white.color, for:UIControl.State.normal)
    }
    
    private func setupDateAndTimeLabel(_ dateAndTime: String, _ doctorName: String) {
        let attributedString = NSMutableAttributedString(string: "You are about to book an appointment on \(dateAndTime) with Doctor \(doctorName)", attributes: [
            .font: FontFamily.PTSans.regular.font(size: 15),
            .foregroundColor: ColorName.black.color
        ])
        attributedString.addAttribute(.font, value: FontFamily.PTSans.bold.font(size: 15), range: NSRange(location: 40, length: dateAndTime.count))
        attributedString.addAttribute(.font, value: FontFamily.PTSans.bold.font(size: 15), range: NSRange(location: 46 + dateAndTime.count, length: 7 + doctorName.count))
        detailsLabel.attributedText = attributedString
        detailsLabel.numberOfLines = 0
        detailsLabel.sizeToFit()
        detailsLabel.textAlignment = .center
    }

}
