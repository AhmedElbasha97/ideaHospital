//
//  SearchServicesView.swift
//  IDEHospital
//
//  Created by Kamal on 12/9/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation
import UIKit

class SearchServicesView: UIView {
    //MARK:- IBOutlets
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var chooseSpecialityTxtField: PaddedTextField!
    @IBOutlet weak var chooseCityTxtField: PaddedTextField!
    @IBOutlet weak var chooseRegionTextField: PaddedTextField!
    @IBOutlet weak var doctorNameTxtField: UITextField!
    @IBOutlet weak var findDoctorBtnPressed: CommonUIButton!
    @IBOutlet weak var chooseCompanyTxtField: PaddedTextField!
    
    //MARK:- Properties
    let pickerView = UIPickerView()
    
    //MARK:- Public Methods
    func setupView() {
        setupLabel(mainLabel, L10n.ideaEgHospital, FontFamily.PTSans.bold.font(size: 40))
        setupLabel(secondaryLabel, L10n.ideaEgHospitalTheBestChoice, FontFamily.PTSans.regular.font(size: 20))
        self.findDoctorBtnPressed.setUPUIButton(backGroundColor:ColorName.darkRoyalBlue.color, titleOfTheButton: L10n.findADoctor, sizeOfTheFont: 20)
        setupTextFields()
        setupBackground()
    }
}

//MARK:- Private Methods
extension SearchServicesView {
    private func setupLabel(_ label: UILabel, _ labelText: String, _ font: UIFont) {
        label.text = labelText
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = ColorName.white.color
        label.font = font
    }
    

    
    private func setupTextField(_ textField: UITextField, tag: Int, placeholder: String, leftIcon: UIImage) {
        textField.backgroundColor = ColorName.white.color
        textField.tag = tag
        textField.font = FontFamily.PTSans.regular.font(size: 20)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes:[NSAttributedString.Key.foregroundColor: ColorName.blackTwo.color, NSAttributedString.Key.font: FontFamily.PTSans.regular.font(size: 20)])
        textField.leftPadding(image: leftIcon)
        if textField.tag != 5 {
            textField.rightPadding()
        }
    }
    
    private func setupTextFields() {
        setupTextField(chooseSpecialityTxtField, tag: 1, placeholder: L10n.chooseSpecialists, leftIcon: Asset.doubleHeart.image)
        setupTextFieldPicker(chooseSpecialityTxtField)
        setupTextField(chooseCityTxtField, tag: 2, placeholder:L10n.chooseCity, leftIcon: Asset.pin.image)
        setupTextFieldPicker(chooseCityTxtField)
        setupTextField(chooseRegionTextField, tag: 3, placeholder: L10n.chooseRegion, leftIcon: Asset.pin.image)
        setupTextFieldPicker(chooseRegionTextField)
        setupTextField(chooseCompanyTxtField, tag: 4, placeholder: L10n.chooseCompanies, leftIcon: Asset.life.image)
        setupTextFieldPicker(chooseCompanyTxtField)
        setupTextField(doctorNameTxtField, tag: 5, placeholder: L10n.doctorName, leftIcon: Asset.doctor.image)
    }
    
    private func setupTextFieldPicker(_ textField: UITextField) {
        textField.inputView = pickerView
    }
}
