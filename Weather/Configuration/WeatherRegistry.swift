//
//  WeatherRegistry.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 14/06/23.
//

import Foundation

class WeatherRegistry: NSObject, AppLifecycleProtocol {
    override init() {
        super.init()
        WeatherDependencies.bindComponents()
    }
}

struct AppRegistry {
    var registry: [AppLifecycleProtocol]
    
    init() {
        self.registry = [
            WeatherRegistry()
        ]
    }
    
    func getRegistry() -> [AppLifecycleProtocol] { registry }
}
