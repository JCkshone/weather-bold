//
//  SplashViewModel.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 8/06/23.
//

import Combine
import SwiftUI
import Resolver

enum SplashViewState {
    // MARK: UI States
    
    case requesting
    case requested
    case loaded(ForecastInfo)
    
    // MARK: Error States
    
    case showGenericError(Error)
}

protocol SplashViewModelProtocol {
    var statePublisher: Published<SplashViewState>.Publisher { get }
    var coordinator: MainCoordinator? { get set }
    
    func onTapLoadLocation()
    func onViewDidLoad()
}

class SplashViewModel {
    @Published private var viewState: SplashViewState = .requesting
    @Injected var locationProvider: LocationProviderProtocol
    @Injected(name: .userDefaults) private var userPreferences: StorageProviderProtocol
    
    private var cancellables = Set<AnyCancellable>()
    var statePublisher: Published<SplashViewState>.Publisher { $viewState }
    var coordinator: MainCoordinator?

    func onViewDidLoad() {
        setEvents()
        locationProvider.agent.requestAccess()
    }
}

extension SplashViewModel: SplashViewModelProtocol {
    
    func onTapLoadLocation() {
        locationProvider.agent.loadLocation()
    }
    
    func setEvents() {
        locationProvider.agent.location.sink { [weak self] location in
            guard let self = self, let coordinate = location?.coordinate else { return }
            if !self.userPreferences.agent.hasValue(forKey: String(describing: ActiveLocation.self)) {
                self.userPreferences.agent.set(
                    ActiveLocation(
                        lat: coordinate.latitude,
                        lon: coordinate.longitude),
                    forKey: String(describing: ActiveLocation.self)
                )
                return
            }
            self.coordinator?.goToHome()
        }
        .store(in: &cancellables)
    }
}
