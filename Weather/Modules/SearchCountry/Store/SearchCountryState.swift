//
//  SearchCountryState.swift
//  Weather
//
//  Created by Juan camilo Navarro on 13/06/23.
//

import Foundation

enum SearchCountryState {
    case neverLoaded
    case searching
    case resultOfSearch(FindCityModel)
    case withError(Error)
}
