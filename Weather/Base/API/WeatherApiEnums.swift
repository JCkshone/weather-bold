//
//  WeatherApiEnums.swift
//  Weather
//
//  Created by Juan camilo Navarro on 13/06/23.
//

import Foundation

public enum HttpMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

enum WeatherError {
    enum Api: Error {
        case invalidUrl(url: String)
        case undefined
        case noInternet
        case invalidResponse
        case timeOut
        case invalidDecodableModel
        case invalidObject
    }
    enum CoreData: Error {
        case objectNotFound
    }
    enum Generic: Error {
        case invalidCoordinatorInstance
    }
}
