//
//  MainCoordinator.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 8/06/23.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SplashViewModel()
        let vc = SplashViewController(viewModel: viewModel)
        viewModel.coordinator = self
        navigationController.view.layer.add(
            Transitions.fade,
            forKey: nil
        )
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToHome() {
        let vc = HomeViewController(coordinator: self)
        navigationController.view.layer.add(
            Transitions.fade,
            forKey: nil
        )
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToAirCondition() {
        let vc = AirConditionViewController()
        vc.coordinator = self
        navigationController.view.layer.add(
            Transitions.fade,
            forKey: nil
        )
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
