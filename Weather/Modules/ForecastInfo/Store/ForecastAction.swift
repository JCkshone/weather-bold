//
//  ForecastAction.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 14/06/23.
//

import Foundation

enum ForecastAction {
    case getCityWeather(lat: Double, lon: Double)
    case getCityWeatherWithActive(lat: Double, lon: Double)
    case getCityWeatherSuccess(_ result: HomeModel, _ foreCast: ForecastDayModel)
    case getCityWeatherFailure(_ error: Error)
}
