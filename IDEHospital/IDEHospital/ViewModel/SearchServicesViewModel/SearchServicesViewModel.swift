//
//  SearchServicesViewModel.swift
//  IDEHospital
//
//  Created by Kamal on 12/9/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

protocol SearchServicesViewModelProtocol {
    func prepareCategories(with categoryID: Int)
    func preparePickerItems(with tag: Int)
    func itemSelected(tag: Int, row: Int)
    func itemsCount() -> Int
    func getItem(row: Int)-> String
    func findDoctorTapped(doctorName: String?)
}

class SearchServicesViewModel {
    //MARK:- Properties
    private var view: SearchServicesProtocol!
    var categoryData: CategoryData!
    var items: [String] = []
    var doctorFilter: DoctorsFilter!
    
    //MARK:- Init
    init(view: SearchServicesProtocol) {
        self.view = view
    }
}

// MARK:- Private Methods
extension SearchServicesViewModel {
    private func getCategories(with categoriesID: Int) {
        APIManager.getCategoryData(with: categoriesID) { [weak self] (response) in
            switch response {
            case .failure(let error):
                self?.view.showAlert(message: error.localizedDescription)
            case .success(let categoryResponse):
                self?.categoryData = categoryResponse.data

            }
        }
    }
}

//MARK:-  Search Services ViewModel Protocol
extension SearchServicesViewModel: SearchServicesViewModelProtocol {
    func findDoctorTapped(doctorName: String?) {
        doctorFilter.doctorName = doctorName
        view.goToSearchResultVC(doctorFilter: doctorFilter)
        
    }
    
    func prepareCategories(with categoryID: Int) {
        getCategories(with: categoryID)
        self.doctorFilter = DoctorsFilter(categoryId: categoryID, page: 1)
    }
    
    func preparePickerItems(with tag: Int) {
        guard categoryData != nil else { return }
        switch tag {
        case 1:
            items = categoryData.specialties.map{$0.name}
        case 2:
            items = categoryData.cities.map{$0.name}
        case 3:
            if let city = categoryData.cities.first(where: {$0.id == doctorFilter.cityId}) {
                items = city.regions.map{$0.name}
                view.doneButtonEnabled(true, for: tag)
            } else {
                items = [L10n.pleaseChooseYourCityFirst]
                view.doneButtonEnabled(false, for: tag)
            }
        case 4:
            items = categoryData.companies.map{$0.name}
        default: break
        }
        view?.showItems()
    }
    
    func itemSelected(tag: Int, row: Int) {
        guard items.indices.contains(row) else { return }
        switch tag {
        case 1:
            let specialty = categoryData.specialties[row]
            view?.addSelectedItem(tag, specialty.name)
            doctorFilter.specialtyId = specialty.id
        case 2:
            let city = categoryData.cities[row]
            view?.addSelectedItem(tag, city.name)
            if city.id == doctorFilter.cityId {
                break
            }
            doctorFilter.cityId = city.id
            view?.clearTextField(with: 3)
        case 3:
            if let city = categoryData.cities.first(where: {$0.id == doctorFilter.cityId}) {
                let region = city.regions[row]
                view?.addSelectedItem(tag, region.name)
                doctorFilter.regionId = region.id
            }
            view?.addSelectedItem(tag, items[row])
        case 4:
            let company = categoryData.companies[row]
            view?.addSelectedItem(tag, company.name)
            doctorFilter.companyId = company.id
        default: break
        }
    }
    
    func itemsCount() -> Int {
        return  items.count
    }
    
    func getItem(row: Int)-> String {
        return items[row]
    }
}
