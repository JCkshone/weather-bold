//
//  ForecastReducer.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 14/06/23.
//

import Foundation

enum ForecastReducer {
    static func reduce(state: inout ForecastState, action: ForecastAction) {
        switch action {
        case .getCityWeather, .getCityWeatherWithActive:
            state = .loadingWeatherInfo
        
        case let .getCityWeatherSuccess(info, forecast):
            state = .loadedWeatherInfo(info, forecast)
            
        case let .getCityWeatherFailure(error):
            state = .withError(error)
        }
    }
}
