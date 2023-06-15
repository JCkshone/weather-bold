//
//  FindCityReducer.swift
//  Weather
//
//  Created by Juan camilo Navarro on 13/06/23.
//

import Foundation

enum SearchCountryReducer {
    static func reduce(
        state: inout SearchCountryState,
        action: SearchCountryAction
    ) {
        switch action {
        case .search:
            state = .searching
        case let .searchCitySuccess(response):
            state = .resultOfSearch(response)
        case let .searchCityFailure(error):
            state = .withError(error)
        }
    }
}
