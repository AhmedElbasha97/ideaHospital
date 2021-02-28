//
//  HomeCollectionViewCell.swift
//  IDEHospital
//
//  Created by bido elbasha on 10/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//
import SDWebImage
import UIKit
protocol HomeCollectionViewCellProtocol: class{
    func configurefunc (categoryLabel: String, cotegoryImage: UIImage, colorOfBackGround: Color)
}
class HomeCollectionViewCell: UICollectionViewCell {
    //MARK:- properties
    @IBOutlet weak var categorieNameLabel: CommonUILabel!
    @IBOutlet weak var categorieImageView: UIImageView!
    private var viewModel: HomeCollectionViewCellViewModelProtocol?
    // MARK:- Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.categorieNameLabel.setUpUILabael(size: 15, isBold: true, Textolor: ColorName.white.color)
        self.viewModel = HomeCollectionViewCellViewModel(view: self)
        setUpUI()
    }
    
    func configure(data: MainCategorie) {
        self.viewModel?.fetchData(data: data)
     }
    


}

extension HomeCollectionViewCell{
    
    //set up ui for the views
    private func setUpUI(){
        self.layer.cornerRadius = 10
    }
    
}
extension HomeCollectionViewCell: HomeCollectionViewCellProtocol{
    func configurefunc(categoryLabel: String, cotegoryImage: UIImage, colorOfBackGround: Color) {
         self.backgroundColor = colorOfBackGround
        categorieNameLabel.text = categoryLabel
               categorieImageView.image = cotegoryImage
    }
    
    
}
