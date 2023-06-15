//
//  ForecastInfoViewController.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 10/06/23.
//

import UIKit
import Combine

class ForecastInfoViewController: BaseViewController {
    private(set) lazy var innerView = ForecastInfoView()
    private(set) var viewModel: ForecastViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: ForecastViewModelProtocol) {
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
        viewModel.onViewDidLoad()
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

extension ForecastInfoViewController {
    func setupActions() {
//        innerView.searchButton
//            .publisher(for: .touchUpInside)
//            .sink { [weak self] _ in
//                guard let self = self else { return }
//
//                self.viewModel.onTapSearchButton(
//                    with: self.innerView.textField.text ?? .empty
//                )
//            }
//            .store(in: &cancellables)
//
//        innerView.subjectActiveLocation
//            .sink { [weak self] activeLocation in
//                guard let self = self else { return }
//
//                self.viewModel.onTapGoForecastInfo(with: activeLocation)
//            }
//            .store(in: &cancellables)
    }
    
    func setupEvents() {
        viewModel.statePublisher.sink { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.showLoading()
            case let .loaded(info):
                self.hiddeLoading()
                self.innerView.setupInfo(with: info)
            case let .showGenericError(error):
                print(error.localizedDescription)
            default:
                break
            }
        }
        .store(in: &cancellables)
    }
}
