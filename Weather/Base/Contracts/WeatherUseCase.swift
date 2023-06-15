//
//  WeatherUseCase.swift
//  Weather
//
//  Created by Juan camilo Navarro on 13/06/23.
//

import Combine

// MARK: - Home Use Cases

protocol GetWeatherInfoUseCaseProtocol: AnyObject {
    func execute(lat: Double, long: Double) -> AnyPublisher<ApiResponse<HomeModel>, WeatherError.Api>
}

protocol GetForecastInfoUseCaseProtocol: AnyObject {
    func execute(lat: Double, long: Double) -> AnyPublisher<ApiResponse<ForecastDayModel>, WeatherError.Api>
}


// MARK: - Find City Use Cases
protocol SearchCityUseCaseProtocol: AnyObject {
    func execute(for search: String) -> AnyPublisher<ApiResponse<FindCityModel>, WeatherError.Api>
}
