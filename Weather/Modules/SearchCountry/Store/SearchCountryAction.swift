//
//  SearchCountryAction.swift
//  Weather
//
//  Created by Juan camilo Navarro on 13/06/23.
//

import Foundation

enum SearchCountryAction {
    case search(String)
    case searchCitySuccess(_ findResponse: FindCityModel)
    case searchCityFailure(_ error: Error)
}
