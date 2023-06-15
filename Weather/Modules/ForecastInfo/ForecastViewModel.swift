//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 14/06/23.
//

import Foundation
import Combine
import Resolver

struct ForecastToday {
    let time: String
    let temp: String
    let icon: String
}

struct AirConditionToday {
    let temp: String
    let windSpeed: String
}

struct ForecastDayWithIcon {
    let day: String
    let icon: String
    let weatherName: String
    let temp: String
    let realTemp: String
}

struct ForecastInfo {
    let weatherInfo: HomeModel
    let temp: String
    let icon: String
    let forecastToday: [ForecastToday]
    let forecastDays: [ForecastDayWithIcon]
    let airCondition: ForecastCurrent?
}

enum ForecastViewState {
    // MARK: UI States
    
    case initial
    case loading
    case loaded(ForecastInfo)
    
    // MARK: Error States
    
    case showGenericError(Error)
}

protocol ForecastViewModelProtocol {
    var statePublisher: Published<ForecastViewState>.Publisher { get }
    var coordinator: MainCoordinator? { get set }
    
    func onTapShowAirCondition()
    func onViewDidLoad()
    func onViewDidDisappear()
}


class ForecastViewModel  {
    var statePublisher: Published<ForecastViewState>.Publisher { $viewState }
    var coordinator: MainCoordinator?
    
    @Published private var viewState: ForecastViewState = .initial
    @Injected private var store: Store<ForecastState, ForecastAction>
    @Injected(name: .userDefaults) private var userPreferences: StorageProviderProtocol
    
    private var cancellables = Set<AnyCancellable>()
    private var currentLocation: ActiveLocation {
        guard let location = userPreferences.agent.object(
            type: ActiveLocation.self,
            forKey: String(describing: ActiveLocation.self)
        ) else {
            return ActiveLocation(lat: .zero, lon: .zero)
        }
        return location
    }
    
    func onViewDidLoad() {
        if case .loading = viewState { return }
        setupEvents()
        viewState = .loading
        store.dispatch(
            .getCityWeatherWithActive(
                lat: currentLocation.lat,
                lon: currentLocation.lon
            )
        )
    }
    
    func onViewDidDisappear() {
        cancellables.removeAll()
        viewState = .initial
    }
}

extension ForecastViewModel: ForecastViewModelProtocol {
    func onTapShowAirCondition() {
        coordinator?.goToAirCondition()
    }
}

extension ForecastViewModel {
    func setupEvents() {
        store.$state.sink { [weak self] state in
            guard let self = self else { return }
            
            if case let .loadedWeatherInfo(homeModel, forecastModel) = state {
                self.viewState = .loaded(
                    self.forecastModelInfo(
                        with: homeModel,
                        and: forecastModel
                    )
                )
            }
            
            if case let .withError(error) = state {
                self.viewState = .showGenericError(error)
            }
        }.store(in: &cancellables)
    }
    
    func forecastModelInfo(with info: HomeModel, and forecast: ForecastDayModel) -> ForecastInfo {
        let forecastToday = forecast.hourly.map {
            ForecastToday(
                time: "\($0.dt)".getTime(),
                temp: self.convertToCelsius($0.temp),
                icon: $0.weather.first?.icon.digits ?? "01"
            )
        }
        
        let forecastDays = forecast.daily.map {
            ForecastDayWithIcon(
                day: "\($0.dt)".getDay(),
                icon: $0.weather.first?.icon.digits ?? "01",
                weatherName: $0.weather.first?.main ?? .empty,
                temp: self.convertToCelsius($0.temp.day, addCelsius: false).components(separatedBy: ".").first ?? .empty,
                realTemp: self.convertToCelsius($0.feelsLike.day, addCelsius: false).components(separatedBy: ".").first ?? .empty
            )
        }
        return ForecastInfo(
            weatherInfo: info,
            temp: self.convertToCelsius(info.main.temp),
            icon: info.weather.first?.icon.digits ?? "01",
            forecastToday: forecastToday,
            forecastDays: forecastDays,
            airCondition: forecast.hourly.first
        )
    }
    
    func convertToCelsius(_ value: Double, addCelsius: Bool = true) -> String {
        let t = Measurement(value: value, unit: UnitTemperature.kelvin)
        return "\(round(t.converted(to: UnitTemperature.celsius).value))" + (addCelsius ? "°C" : .empty)
    }
}
