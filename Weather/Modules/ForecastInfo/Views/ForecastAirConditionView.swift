//
//  ForecastAirConditionView.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 11/06/23.
//

import UIKit
import SnapKit

internal typealias ItemDefinition = (icon: ImageAsset, title: String, degree: String)

class ForecastAirConditionView: UIView {
    private lazy var stackView: UIStackView = setupStackView()
    private lazy var showMoreButton: UIButton = setupShowMoreButton()
    private lazy var titleLabel: UILabel = setupTitleLabel()
    private var forecastAirCondition: ForecastCurrent?
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupSubViews()
        setupConstraints()
        setupContent()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ForecastAirConditionView {
    func setupInfo(with forecastAirCondition: ForecastCurrent) {
        self.forecastAirCondition = forecastAirCondition
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        setupContent()
    }
}

extension ForecastAirConditionView {
    func setupView() {
        backgroundColor = WeatherColor.section.color
        layer.cornerRadius = 16
    }
    
    func setupSubViews() {
        addSubview(titleLabel)
        addSubview(stackView)
        addSubview(showMoreButton)
    }
    
    func setupContent() {
        stackView.addArrangedSubviews(
            setupContentConditionStackView(
                first: (
                    icon: WeatherImages.Sf.thermometerLow,
                    title: "Real Feel",
                    degree: self.convertToCelsius(forecastAirCondition?.feelsLike ?? .zero)
                ),
                second: (
                    icon: WeatherImages.Sf.wind,
                    title: "Wind",
                    degree: "\(forecastAirCondition?.windSpeed ?? .zero) km/h"
                )
            ),
            setupContentConditionStackView(
                first: (
                    icon: WeatherImages.Sf.humidityFill,
                    title: "Chance of rain",
                    degree: "\(forecastAirCondition?.humidity ?? .zero) %"
                ),
                second: (
                    icon: WeatherImages.Sf.sunMaxFill,
                    title: "UV Index",
                    degree: "\(forecastAirCondition?.uvi ?? .zero)"
                )
            )
        )
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(16)
        }
        showMoreButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(11)
            $0.right.equalToSuperview().offset(-11)
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension ForecastAirConditionView {
    func setupStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }
}

extension ForecastAirConditionView {
    func setupContentConditionStackView(first: ItemDefinition, second: ItemDefinition) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.addArrangedSubviews(
            setupConditionItemsStackView(with: first),
            setupConditionItemsStackView(with: second)
        )
        return stackView
    }
    
    func setupConditionItemsStackView(with item: (icon: ImageAsset, title: String, degree: String)) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.isLayoutMarginsRelativeArrangement = true
        
        let hStackView = UIStackView()
        hStackView.axis = .horizontal
        hStackView.spacing = 8
        hStackView.distribution = .fillProportionally
        hStackView.isLayoutMarginsRelativeArrangement = true
        
        hStackView.addArrangedSubviews(
            setupIconImageView(item.icon),
            setupTitleConditionLabel(item.title)
        )
        
        stackView.addArrangedSubviews(
            hStackView,
            setupDegreeLabel(item.degree)
        )
        return stackView
    }
    
    func setupIconImageView(_ icon: ImageAsset) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = icon.image
        imageView.snp.makeConstraints {
            $0.height.equalTo(16)
        }
        imageView.tintColor = WeatherColor.gray.color
        return imageView
    }
    
    func setupDegreeLabel(_ degree: String) -> UILabel {
        let label = PaddingLabel()
        label.text = degree
        label.font = FontDefinition.title.font
        label.textColor = .black
        label.leftInset = 18
        return label
    }
    
    func setupTitleConditionLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = FontDefinition.description.font
        label.textColor = WeatherResources.Colors.gray.color
        return label
    }
}

extension ForecastAirConditionView {
    func setupFirstStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 22
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.addArrangedSubviews(titleLabel, showMoreButton)
        return stackView
    }
    
    func setupShowMoreButton() -> UIButton {
        let button = UIButton()
        button.setRadiusAndShadow(with:15)
        button.setTitle("See more", for: .normal)
        button.titleLabel?.font = FontDefinition.descriptionMedium.font
        button.setBackgroundColor(with: WeatherColor.blue)
        return button
    }
    
    func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "air conditions".uppercased()
        label.font = FontDefinition.titleSection.font
        label.textColor = WeatherColor.gray.color
        return label
    }
}
