//
//  ForecastState.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 14/06/23.
//

import Foundation

enum ForecastState {
    case neverLoaded
    case loadingWeatherInfo
    case loadedWeatherInfo(HomeModel, ForecastDayModel)
    case withError(Error)
}
