//
//  SearchServicesView.swift
//  IDEHospital
//
//  Created by bido elbasha on 09/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    //MARK:- properties
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeLbl: CommonUILabel!
    
    //MARK:- life cycle maethod
    func setUp(view: UIView){
        setUpTheLBL(label: homeLbl , LabelData: L10n.ideaEgHospitalTheBestChoice)
        setUpImage(image: homeImage)
        self.setupBackground()
        setupCollectionView()
        
    }
    
    //MARK:- setUPTheLabel
    private func setUpTheLBL(label: CommonUILabel, LabelData: String){
        label.text = LabelData
        label.setUpUILabael(size: 20, isBold: true, Textolor: ColorName.white.color)
    }
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.frame.size.width/2.5, height: self.frame.size.width/2.5)
        homeCollectionView.collectionViewLayout = layout
        homeCollectionView.backgroundColor = .clear
    }
    
    //MARK:- SET UP IMAGES
    private func setUpImage(image: UIImageView){
        image.image = Asset.logo.image
    }
    
}



