//
//  ForecastUseCase.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 14/06/23.
//

import Foundation
import Combine
import Resolver

final class GetWeatherInfoUseCase: GetWeatherInfoUseCaseProtocol {
    @Injected var network: NetworkProviderProtocol
    
    func execute(lat: Double, long: Double) -> AnyPublisher<ApiResponse<HomeModel>, WeatherError.Api> {
        network.agent.run(
            ForecastRouter(
                route: .getWeatherInfo(lat: lat, long: long)
            )
        )
    }
}

final class GetForecastInfoUseCase: GetForecastInfoUseCaseProtocol {
    @Injected var network: NetworkProviderProtocol
    
    func execute(lat: Double, long: Double) -> AnyPublisher<ApiResponse<ForecastDayModel>, WeatherError.Api> {
        network.agent.run(
            ForecastRouter(
                route: .getForecastInfo(lat: lat, long: long)
            )
        )
    }
}



enum ForecastRoute {
    case getWeatherInfo(lat: Double, long: Double)
    case getForecastInfo(lat: Double, long: Double)
}

protocol ForecastRouteable: WeatherRoutable {
    var route: ForecastRoute { get set }
}

extension ForecastRouteable {
    
    var queryParams: HttpQueryParams {
        var params = ["appid": "050bfe64cd43a9d0d9f4dd747100ddd4"]
        
        switch route {
        case let .getWeatherInfo(lat, long):
            params["lat"] = "\(lat)"
            params["lon"] = "\(long)"
        case let .getForecastInfo(lat, long):
            params["lat"] = "\(lat)"
            params["lon"] = "\(long)"
        }
        
        return params
    }
    
    var path: String {
        switch route {
        case .getWeatherInfo:
            return "/data/2.5/weather"
        case .getForecastInfo:
            return "/data/3.0/onecall"
        }
    }
    
    var method: HttpMethod {
        switch route {
        case .getWeatherInfo, .getForecastInfo:
            return .get
        }
    }
}

struct ForecastRouter: ForecastRouteable {
    var route: ForecastRoute
}
