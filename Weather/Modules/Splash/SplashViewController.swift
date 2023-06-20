//
//  SplashViewController.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 9/06/23.
//

import UIKit
import Combine

class SplashViewController: UIViewController {
    private(set) lazy var innerView = SplashView()
    private(set) var viewModel: SplashViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: SplashViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewDidLoad()
        setupActions()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cancellables.removeAll()
    }
    
    override func loadView() {
        view = innerView
    }
}

extension SplashViewController {
    func setupActions() {
        innerView.nextButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.onTapLoadLocation()
            }.store(in: &cancellables)
    }
}
