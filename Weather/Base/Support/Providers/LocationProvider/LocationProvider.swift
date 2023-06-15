//
//  LocationProvider.swift
//  Weather
//
//  Created by Juan camilo Navarro on 13/06/23.
//

import Foundation

public protocol LocationProviderProtocol {
    var agent: LocationAgent { get }
}

public enum LocationStrategy {
    case coreLocation
}

public final class LocationProvider: LocationProviderProtocol {
    public let agent: LocationAgent

    public init(strategy: LocationStrategy) {
        switch strategy {
        case .coreLocation:
            agent = CLLocationAgent()
        }
    }
}
