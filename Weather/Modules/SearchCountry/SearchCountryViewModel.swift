//
//  SearchCountryViewModel.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 14/06/23.
//

import Foundation
import Combine
import Resolver

enum SearchCountryViewState {
    // MARK: UI States

    case initial
    case searching
    case searched(FindCityModel)

    // MARK: Error States

    case showGenericError(Error)
}

protocol SearchCountryViewModelProtocol {
    var statePublisher: Published<SearchCountryViewState>.Publisher { get }
    var coordinator: MainCoordinator? { get set }

    func onTapSearchButton(with info: String)
    func onTapGoForecastInfo(with selectLocation: ActiveLocation)
    func onViewDidLoad()
    func onViewDidDisappear()
}

class SearchCountryViewModel {
    var statePublisher: Published<SearchCountryViewState>.Publisher { $viewState }
    var coordinator: MainCoordinator?

    @Published private var viewState: SearchCountryViewState = .initial
    @Injected private var store: Store<SearchCountryState, SearchCountryAction>
    @Injected(name: .userDefaults) private var userPreferences: StorageProviderProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    func onViewDidLoad() {
        setupEvents()
    }
    
    func onViewDidDisappear() {
        cancellables.removeAll()
        viewState = .initial
    }
}

extension SearchCountryViewModel: SearchCountryViewModelProtocol {
    
    func onTapSearchButton(with info: String) {
        viewState = .searching
        store.dispatch(.search(info))
    }
    
    func onTapGoForecastInfo(with selectLocation: ActiveLocation) {
        userPreferences.agent.set(
            ActiveLocation(
                lat: selectLocation.lat,
                lon: selectLocation.lon),
            forKey: String(describing: ActiveLocation.self)
        )
    }
}

extension SearchCountryViewModel {
    func setupEvents() {
        store.$state.sink { [weak self] state in
            guard let self = self else { return }
            
            if case let .resultOfSearch(response) = state {
                self.viewState = .searched(response)
            }
            
            if case let .withError(error) = state {
                self.viewState = .showGenericError(error)
            }
        }.store(in: &cancellables)
    }
}
