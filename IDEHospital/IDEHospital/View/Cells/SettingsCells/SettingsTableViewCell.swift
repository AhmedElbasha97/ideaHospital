//
//  SettingsTableViewCell.swift
//  IDEHospital
//
//  Created by bido elbasha on 26/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLogoImageView: UIImageView!
    @IBOutlet weak var categorieLabel: CommonUILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.categorieLabel.setUpUILabael(size: 20, isBold: false, Textolor: ColorName.darkRoyalBlue.color)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func Configure(image: UIImage, label: String){
        categorieLabel.text = label
        self.categoryLogoImageView.image = image
    }
}


