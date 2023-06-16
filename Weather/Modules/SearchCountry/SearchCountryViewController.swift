//
//  SearchCountryViewController.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 10/06/23.
//

import UIKit
import Combine

class SearchCountryViewController: BaseViewController {
    private(set) lazy var innerView = SearchCountryView()
    private(set) var viewModel: SearchCountryViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: SearchCountryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = innerView
        setupActions()
        setupEvents()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.onViewDidDisappear()
    }
}

extension SearchCountryViewController {
    func setupActions() {
        innerView.searchButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.viewModel.onTapSearchButton(
                    with: self.innerView.textField.text ?? .empty
                )
            }
            .store(in: &cancellables)
        
        innerView.subjectActiveLocation
            .sink { [weak self] activeLocation in
                guard let self = self else { return }
                self.showAlert(with: "Alert", and: "Your select city was saved")
                self.viewModel.onTapGoForecastInfo(with: activeLocation)
            }
            .store(in: &cancellables)
    }
    
    func setupEvents() {
        viewModel.statePublisher.sink { [weak self] state in
            guard let self = self else { return }
            switch state {
            case let .searched(response):
                self.hiddeLoading()
                self.innerView.updateDataSource(with: response.list)
            case .searching:
                self.showLoading()
            case let .showGenericError(error):
                self.dismissAndShowAlert(with: "Error", and: error.localizedDescription)
            default:
                break
            }
        }
        .store(in: &cancellables)
    }
}
