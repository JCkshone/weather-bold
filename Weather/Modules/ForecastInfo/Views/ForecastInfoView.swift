//
//  ForecastHeaderView.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 10/06/23.
//

import UIKit
import SnapKit
import Combine

class ForecastInfoView: UIView {
    private lazy var contentView: UIView = setupContentView()
    private lazy var stackView: UIStackView = setupStackView()
    private lazy var headerStackView = ForecastHeaderView()
    private lazy var forecastTodayView = ForecastTodayView()
    private lazy var forecastAirConditionView = ForecastAirConditionView()
    private lazy var forecastLastDayView = ForecastLastDayView()
    private var cancellables = Set<AnyCancellable>()
    var actionSubject = PassthroughSubject<Void, Never>()
    
    init() {
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
        setupContent()
        setupEvents()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ForecastInfoView {
    
    func setupInfo(with info: ForecastInfo) {
        headerStackView.subTitleLabel.text = "Chance of rain: \(info.airCondition?.humidity ?? .zero)%"
        headerStackView.iconImageView.image = UIImage(named: info.icon)
        headerStackView.degreeTitleLabel.text = info.temp
        forecastTodayView.setupInfo(with: info.forecastToday)
        forecastLastDayView.setupInfo(with: info.forecastDays)
        if let airCondition = info.airCondition {
            forecastAirConditionView.setupInfo(with: airCondition)
        }
    }
    
    func setupSubviews() {
        addSubview(contentView)
    }
    
    func setupContent() {
        stackView.addArrangedSubviews(
            headerStackView,
            forecastTodayView,
            forecastAirConditionView,
            forecastLastDayView
        )
    }
}

extension ForecastInfoView {
    func setupContentView() -> UIView {
        let contentView = UIView()
        let scrollView = UIScrollView()
        
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { $0.edges.equalTo(contentView) }
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.left.equalTo(scrollView.snp.left)
            $0.right.equalTo(scrollView.snp.right)
            $0.bottom.equalTo(scrollView.snp.bottom).priority(.low)
            $0.centerX.equalTo(scrollView.snp.centerX)
            $0.centerY.equalTo(scrollView.snp.centerY).priority(.low)
        }
        
        return contentView
    }
    
    func setupStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 22
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }
}

extension ForecastInfoView {
    func setupConstraints() {
        contentView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func setupEvents() {
        forecastAirConditionView
            .showMoreButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.actionSubject.send(())
            }.store(in: &cancellables)
    }
}
