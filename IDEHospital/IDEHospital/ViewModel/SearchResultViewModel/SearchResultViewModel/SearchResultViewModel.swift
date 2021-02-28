//
//  SearchResultViewModel.swift
//  IDEHospital
//
//  Created by Kamal on 12/21/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

protocol SearchResultsViewModelProtocol {
    func searchForDoctors()
    func getSortTypes() -> [String]
    func sortTypeSelected(row: Int)
    func getItemsCount() -> Int
    func getItem(for row: Int) -> Item
    func willDisplay(_ row: Int)
    func removeFromFavorites(with row: Int)

}

class SearchResultViewModel {
    
    // MARK:- Properties
    private weak var view: SearchResultProtocol?
    var doctorsFilter: DoctorsFilter!
    private var data: SearchResults!
    
    // MARK:- Init
    init(view: SearchResultProtocol, doctorsFilter: DoctorsFilter) {
        self.view = view
        self.doctorsFilter = doctorsFilter
    }
}

// MARK:- Private Methods
extension SearchResultViewModel {
    private func getDoctors() {
        self.view?.showloader()
        APIManager.findDoctor(with: doctorsFilter) { [weak self] (response) in
            switch response {
            case .success(let response):
                guard response.code == 200 else { break }
                if self?.doctorsFilter.page == 1 {
                    self?.data = response.data
                    

                } else {
                    self?.data.items += response.data.items
                }
                self?.view?.reloadData()
                guard response.data.items.count == 0 else { break }
            case .failure(let error):
                print(error)
                self?.view?.showAlert(message: error.localizedDescription )
            }
            self?.view?.hideLoader()
        }
    }
    
     func removeFromFavorites(with row: Int){
        APIManager.removeOrAddToFavorite(id: data.items[row].id) { (response) in
            switch response {
            case .success(let result):
                print(result.result ?? true)
                self.getDoctors()
            case .failure(let error):
                self.view?.showAlert(message: error.localizedDescription)
            }
        }
    }
}

// MARK:- ViewModel Protocol
extension SearchResultViewModel: SearchResultsViewModelProtocol {
    func searchForDoctors() {
        getDoctors()
    }
    
    func getSortTypes() -> [String] {
        return [DoctorsFilter.SortType.rating.rawValue, DoctorsFilter.SortType.fees.rawValue]
    }
    
    func sortTypeSelected(row: Int) {
        let sortType = getSortTypes()[row]
        view?.showSortType(sortType: sortType)
        doctorsFilter.orderBy = sortType
        doctorsFilter.page = 1
        getDoctors()
    }
    
    func getItemsCount() -> Int {
        
        if let count = data?.items.count  {
            if count != 0{
                self.view?.showNoData(label1: "ahmed")
            }
            return count
        } else {
            return 0
        }
    }
    
    func getItem(for row: Int) -> Item {
        return data.items[row]
    }
    
    func willDisplay(_ row: Int) {
        if row == self.data.items.count - 1, doctorsFilter.page < data.totalPages {
            doctorsFilter.page += 1
            getDoctors()
        }
    }
}
