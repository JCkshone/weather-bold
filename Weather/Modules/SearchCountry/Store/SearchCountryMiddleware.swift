//
//  SearchCountryMiddleware.swift
//  Weather
//
//  Created by Juan camilo Navarro on 13/06/23.
//

import Foundation
import Combine
import Resolver

enum SearchCountryMiddleware {
    @Injected private static var searchCityUseCase: SearchCityUseCaseProtocol
    
    static func executeGetWeatherInfo() -> Middleware<SearchCountryState, SearchCountryAction> {
        { _, action in
            guard case let .search(value) = action else { return Empty().eraseToAnyPublisher() }

            return searchCityUseCase
                .execute(for: value)
                .map { .searchCitySuccess($0.response) }
                .catch { log(error: $0, dispatch: .searchCityFailure($0)) }
                .eraseToAnyPublisher()
        }
    }
}

extension SearchCountryMiddleware {
    private static func log(error: Error, dispatch: SearchCountryAction) -> AnyPublisher<SearchCountryAction, Never> {
        debugPrint("[\(String(describing: self))] Causal: \(error)")
        return Just(dispatch).setFailureType(to: Never.self).eraseToAnyPublisher()
    }
}
