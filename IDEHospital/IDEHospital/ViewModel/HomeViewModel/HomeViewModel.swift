//
//  File.swift
//  IDEHospital
//
//  Created by bido elbasha on 08/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//
import  Foundation

//MARK:- protcol of vm
protocol HomeViewModelProtocol {
    func getAllHomeData()
    func getHomeViewCount() -> Int
    func goToOtherScreens(id: Int)
    func setUpCategoryView(index: Int) -> MainCategorie
    
}

class HomeViewModel{
    
    //MARK:- Variables
    private weak var view: HomeVCProtcol?
    private var categories = [MainCategorie]()
    private var id: Int = 0

    // MARK:- Life Cycle Methods
    init(view: HomeVCProtcol) {
        self.view = view
    }

}
    //MARK:-API
extension HomeViewModel{
     //MARK:- getDataOfhomeviewcontroller
     private func geHomesData(){
        self.view?.showloader()
        APIManager.getHomeData { (response) in
            switch response{
            case .failure(let error):
                print("\(error.localizedDescription)")
                self.view?.showingAlerts(errorMassage: "\(error.localizedDescription)")
            case.success(let result):
                let data = result.data
                self.categories = data
                print(result.data)
                self.view?.reloadData()
            }
        }
        self.view?.hideLoader()
        }
  
}
//MARK:- CONFORM PROTCOLS
extension HomeViewModel: HomeViewModelProtocol{
   
    
     //MARK:- SHAPE THE DATA FOR EVERY VIEW
    func setUpCategoryView(index: Int) -> MainCategorie {
      
        return categories[index]
    }
    
    //MARK:- decide which screen to go
    func goToOtherScreens(id: Int) {
        let idOfScreens = categories[id].id
        print("\(id)")
        switch idOfScreens {
        case 4:
            view?.goToNurseScreen()
        default:
            view?.goToSearchScreen(id: idOfScreens)
        }
    }
    //MARK:- GET DATA TO SHAPE CATEGORIE
    func getAllHomeData() {
        geHomesData()
    }

    //MARK:- GET NUMBER OF VIEWS
    func getHomeViewCount() -> Int {
        print(categories.count)
        return categories.count
    }

}
