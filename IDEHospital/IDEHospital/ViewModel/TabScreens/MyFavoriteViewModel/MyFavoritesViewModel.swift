//
//  MyFavoritesViewModel.swift
//  IDEHospital
//
//  Created by bido elbasha on 15/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//


import SDWebImage
import UIKit
//MARK:- protcols
protocol FavoriteViewModelProtcol: class {
    func getDataToFavoriteTable()
    func numberOfCells() -> Int
    func getDataOdTheCell(index: Int) -> DoctorModel
    func removeFromFavorite(id: Int, index: Int)
    func detectLastItem(index: Int)
    func setUPNavBar()
    func navugateFromWhere(comeFromSettings: Bool)
}

//MARK:- class
class FavoriteViewModel{
    //MARK:- Variables
    private weak var view: MyFavoriteVCProtcol?
    private var cellsData = [DoctorModel]()
    private var totalpages: Int!
    private var page: Int = 1
    private var comeFromSeetings: Bool!
    
    // MARK:- Life Cycle Methods
    init(view: MyFavoriteVCProtcol) {
        self.view = view
    }
}

//MARK:- Private Func
extension FavoriteViewModel{
    //MARK:-API
    //get data for favorite
    private func getFavoriteData(page: Int) {
        self.view?.showloader()
        APIManager.getFavoriteData(page: page) { (result) in
            switch result{
            case .failure(let error):
                print(error)
                if UserDefaultsManager.shared().token == ""{
                    print("true")
                    self.view?.showingAlerts(errorMassage: error.localizedDescription)
                }
            case .success(let data):
                if data.reault == true && data.code == 200{
                if self.page == 1{
                    self.cellsData = data.data.items
                    self.totalpages = data.data.totalPages
                }else{
                    for cell in data.data.items{
                        self.cellsData.append(cell)
                    }
                }
                }else{
                    self.view?.showingAlerts(errorMassage: data.message ?? "")
                }
                
            }
            print(self.cellsData)
            self.view?.reloadData()
            self.view?.hideLoader()
        }
    }
    
    //remove from favorite
    private func removeFromFavorites(id: Int, index: Int){
        APIManager.removeOrAddToFavorite(id: id) { (response) in
            switch response {
            case .success(let result):
                self.cellsData.remove(at: index)
                print(result.result ?? true)
                
                self.view?.reloadData()
            case .failure(let error):
                self.view?.showingAlerts(errorMassage: "\(error.localizedDescription)")
            }
        }
    }
    
    //get another page data at last index
    private func getDataForAnothePage(index: Int){
        if index == (cellsData.count - 1){
            if totalpages > page{
                print("\(index)")
                print("has Been Ahiced")
                page += 1
                self.getFavoriteData(page: page)
                
            }
        }
    }
    private func comeFromWhere(){
        if comeFromSeetings{
            self.view?.setUPNavBarComeFromSettings(haveSettingBTN: false)
        }else{
            self.view?.setUPNavBarComeFromHome(haveSettingBTN: true)
            self.view?.setUpTabBar()
        }
    }
    
}
// conform protcols
extension FavoriteViewModel: FavoriteViewModelProtcol{
    
    func removeFromFavorite(id: Int, index: Int)  {
        removeFromFavorites(id: id, index: index)
    }
    
    func getDataOdTheCell(index: Int) -> DoctorModel {
        return cellsData[index]
    }
    
    func numberOfCells() -> Int {
        
        if cellsData.count == 0 {
            return cellsData.count
        } else {
            self.view?.showNoData(label1: "")
            return cellsData.count
        }
    }
    
    func getDataToFavoriteTable() {
        getFavoriteData(page: page)
    }
    
    func detectLastItem(index: Int) {
        getDataForAnothePage(index: index)
    }
    
    func setUPNavBar(){
        self.comeFromWhere()
    }
    func navugateFromWhere(comeFromSettings: Bool) {
        self.comeFromSeetings = comeFromSettings
    }
}



