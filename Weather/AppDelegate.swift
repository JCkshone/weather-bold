//
//  AppDelegate.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 8/06/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?
    let appRegistry = AppRegistry()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let navController = UINavigationController()
        navController.navigationBar.isHidden = true
        
        appRegistry.getRegistry().forEach {
            let result = $0.application(
                application,
                didFinishLaunchingWithOptions: launchOptions
            )
            if !result {
                debugPrint("[Error initialized] Registry")
            }
        }
        
        coordinator = MainCoordinator(navigationController: navController)

        coordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
}

