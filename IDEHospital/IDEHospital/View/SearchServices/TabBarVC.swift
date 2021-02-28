//
//  TabBarVC.swift
//  IDEHospital
//
//  Created by Kamal on 12/10/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    // MARK:- LifeCycle Methods
        override func viewDidLoad() {
            super.viewDidLoad()
            setupTabBar()
        }
        
        // MARK:- Public Methods
        class func create(with categoryID: Int) -> TabBarVC {
            let mainTabBar = TabBarVC()
            let searchNavigation = mainTabBar.createServiceSearchVC(with: categoryID)
            let favoriteNavigation = mainTabBar.createFavoriteVC()
            let appointmentsNavigation = mainTabBar.createAppointmentsVC()
            mainTabBar.viewControllers = [searchNavigation, favoriteNavigation, appointmentsNavigation]
            return mainTabBar
        }
    }

    // MARK:- Private Methods
    extension TabBarVC {
        private func setupTabBar() {
            self.tabBar.backgroundColor = ColorName.whiteTwo.color
            self.tabBar.tintColor = ColorName.blackTwo.color
        }
        
        private func createServiceSearchVC(with categoryID: Int) -> UINavigationController {
            let serviceSearchVC = SearchServicesVC.create(categoryID: categoryID)
            serviceSearchVC.tabBarItem = UITabBarItem(title: L10n.search, image: Asset.search.image, tag: 1)
            let searchNavigation = UINavigationController()
            searchNavigation.viewControllers = [serviceSearchVC]
            return searchNavigation
        }
        
        private func createFavoriteVC() -> UINavigationController {
            let favoriteVC = MyFavoriteVC.create(comeFromSettings: false)
            favoriteVC.tabBarItem = UITabBarItem(title: L10n.favorite, image: Asset.heart.image, tag: 2)
            let favoriteNavigation = UINavigationController()
            favoriteNavigation.viewControllers = [favoriteVC]
            return favoriteNavigation
        }
        
        private func createAppointmentsVC() -> UINavigationController {
            let appointmentsVC = MyAppointmentsVC.create(comeFromSettings: false)
            appointmentsVC.tabBarItem = UITabBarItem(title: L10n.schedule, image: Asset.calendar.image, tag: 3)
            let appointmentsNavigation = UINavigationController()
            appointmentsNavigation.viewControllers = [appointmentsVC]
            return appointmentsNavigation
        }
}





