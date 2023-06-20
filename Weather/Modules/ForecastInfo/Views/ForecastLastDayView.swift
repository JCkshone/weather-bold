//
//  ForecastLastDayView.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 12/06/23.
//

import UIKit
import SnapKit

class ForecastLastDayView: UIView {
    
    private lazy var titleLabel: UILabel = setupTitleLabel()
    private lazy var stackView: UIStackView = setupStackView()
    private var forecastDays: [ForecastDayWithIcon] = []
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupSubviews()
        setupConstraints()
        setupContent()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ForecastLastDayView {
    func setupView() {
        backgroundColor = WeatherColor.section.color
        layer.cornerRadius = 16
    }
    
    func setupSubviews() {
        addSubview(titleLabel)
        addSubview(stackView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(16)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func setupContent() {
        forecastDays.forEach { item in
            let content = stackContentItemView()
            content.addArrangedSubviews(
                setupDayLabel(item.day),
                setupIconImageView(UIImage(named: item.icon) ?? WeatherImages._01.image),
                setupTypeLabel(item.weatherName),
                setupDegreeLabel(convertToCelsius(Double(item.realTemp) ?? .zero), convertToCelsius(Double(item.temp) ?? .zero))
            )
            stackView.addArrangedSubview(content)
        }
    }
}

extension ForecastLastDayView {
    func setupInfo(with forecastDays: [ForecastDayWithIcon]) {
        self.forecastDays = forecastDays
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        setupContent()
    }
}

extension ForecastLastDayView {
    func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "8-day forecast".uppercased()
        label.font = FontDefinition.titleSection.font
        label.textColor = WeatherColor.gray.color
        return label
    }
    
    func setupStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }
    
    func stackContentItemView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.addBorder(onSide: .bottom)
        return stackView
    }
}

extension ForecastLastDayView {
    func setupIconImageView(_ icon: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = icon
        imageView.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        imageView.tintColor = WeatherColor.gray.color
        return imageView
    }
    
    func setupDayLabel(_ day: String) -> UILabel {
        let label = PaddingLabel()
        label.text = day
        label.font = FontDefinition.description.font
        label.textColor = WeatherColor.gray.color
        label.leftInset = 18
        return label
    }
    
    func setupTypeLabel(_ forecastType: String) -> UILabel {
        let label = UILabel()
        label.text = forecastType
        label.font = FontDefinition.title.font
        label.textColor = .black
        return label
    }
    
    func setupDegreeLabel(_ currentDegree: String, _ averageDegree: String) -> UILabel {
        let label = UILabel()
        label.font = FontDefinition.description.font
        label.textColor = WeatherResources.Colors.gray.color
        
        let attributedString = NSMutableAttributedString(
            string: "\(currentDegree) ",
            attributes: [.font: FontDefinition.title.font ?? .boldSystemFont(ofSize: 14),
                         .foregroundColor: WeatherColor.blueDark.color]
        )

        attributedString.append(NSMutableAttributedString(string: "/\(averageDegree)"))
        label.attributedText = attributedString
        return label
    }
}
