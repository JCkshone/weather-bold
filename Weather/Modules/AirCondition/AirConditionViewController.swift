//
//  AirConditionViewController.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 17/06/23.
//

import UIKit
import Combine

class AirConditionViewController: BaseViewController {
    private(set) lazy var innerView = AirConditionView()
    private var cancellables = Set<AnyCancellable>()
    weak var coordinator: MainCoordinator?
    
    init() {
        super.init(nibName: .none, bundle: .none)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = innerView
        setupActions()
    }
}

extension AirConditionViewController {
    func setupActions() {
        innerView.backButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.coordinator?.goBack()
            }
            .store(in: &cancellables)
    }
}
