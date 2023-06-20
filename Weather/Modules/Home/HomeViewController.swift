//
//  HomeViewController.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 10/06/23.
//

import UIKit

class HomeViewController: UITabBarController {
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: .none, bundle: .none)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let vc = ForecastInfoViewController(viewModel: viewModel)
        vc.coordinator = self.coordinator
        return vc
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
