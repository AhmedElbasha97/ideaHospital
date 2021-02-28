//
//  TimeCollectionViewCell.swift
//  IDEHospital
//
//  Created by bido elbasha on 07/01/2021.
//  Copyright © 2021 ahmedElbasha. All rights reserved.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    //MARK:- properties
    //outlets
    @IBOutlet weak var timeLabel: UILabel!
    //MARK:- life Cycle Func
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUiOfView()
    }
    func configure(viewData: TimeModel, selected: Bool){
        setUpUILabel(label: timeLabel, indexOfTheTime: viewData.time)
        setUpViewBackGround(available: viewData.booked, Selected: selected)
    }
}
extension TimeCollectionViewCell{
    //set up label
    private func setUpUILabel(label:UILabel, indexOfTheTime:Int){
        label.font = FontFamily.PTSans.bold.font(size: 12)
        label.textColor = ColorName.white.color
        label.text = setUpTime(time: indexOfTheTime)
    }
     //set up time
     private func setUpTime(time: Int) -> String{
         let timeInterval = TimeInterval(time)
         let date = Date(timeIntervalSince1970: timeInterval)
         let formatter = DateFormatter()
         formatter.timeStyle = .short
         return formatter.string(from: date)
     }
    //set up back ground
    private func setUpViewBackGround(available: Bool, Selected: Bool){
        if !available{
            if !Selected{
            self.backgroundColor = ColorName.darkRoyalBlue.color
            }else{
              self.backgroundColor = ColorName.niceBlue.color
            }
        
        }else{
             self.backgroundColor = ColorName.veryLightPink.color
        }
    }
    // set up corners of the view
    private func setUpUiOfView(){
        self.layer.cornerRadius = 10

    }
}
