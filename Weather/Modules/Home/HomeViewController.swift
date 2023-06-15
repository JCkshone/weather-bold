//
//  HomeViewController.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 10/06/23.
//

import UIKit

class HomeViewController: UITabBarController {
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewControllers()
    }
}

extension HomeViewController {
    func setupView() {
        self.view.backgroundColor = .white
        UITabBar.appearance().barTintColor = .lightText
        tabBar.tintColor = .black
    }
    
    func setupViewControllers() {
        viewControllers = [
            createNavController(
                with: buildSearchCountry(),
                "Search City",
                WeatherImages.Sf.magnifyingglass
            ),
            createNavController(
                with: buildForecastInfo(),
                "Forecast",
                WeatherImages.Sf.cloudSunRainFill
            ),
//            createNavController(
//                with: SelectCountryViewController(),
//                "My Cities",
//                WeatherImages.Sf.mapFill
//            )
        ]
    }
    
    func buildSearchCountry() -> SearchCountryViewController {
        let viewModel = SearchCountryViewModel()
        viewModel.coordinator = self.coordinator
        return SearchCountryViewController(viewModel: viewModel)
    }
    
    func buildForecastInfo() -> ForecastInfoViewController {
        let viewModel = ForecastViewModel()
        return ForecastInfoViewController(viewModel: viewModel)
    }
}

extension HomeViewController {
    func createNavController(
        with vc: UIViewController,
        _ title: String,
        _ icon: ImageAsset
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: vc)

        navController.tabBarItem.title = title
        navController.tabBarItem.image = icon.image
        navController.navigationBar.prefersLargeTitles = true
        vc.navigationItem.title = title
        
        return navController
    }
}
