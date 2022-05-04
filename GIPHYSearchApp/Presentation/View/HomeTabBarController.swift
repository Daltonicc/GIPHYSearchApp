//
//  HomeTabBarController.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

class HomeTabBarController: UITabBarController {

    let searchView = SearchViewController()
    let favoriteView = FavoriteViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.viewModel = SearchViewModel(useCase: SearchUseCase(repository: GIPHYRepository()))
        favoriteView.viewModel = FavoriteViewModel()
        
        self.viewControllers = [
            tabBarConfig(rootViewController: searchView, tabBarImage: UIImage(systemName: "magnifyingglass")!),
            tabBarConfig(rootViewController: favoriteView, tabBarImage: UIImage(systemName: "person")!)
        ]
        tabBar.barTintColor = .clear
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = .green
    }

    private func tabBarConfig(rootViewController: UIViewController, tabBarImage: UIImage) -> UINavigationController {
        let rootViewController = rootViewController
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = tabBarImage
        navigationController.navigationBar.barTintColor = .black
        return navigationController
    }
}
