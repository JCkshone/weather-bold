//
//  ForecastHeaderView.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 11/06/23.
//

import UIKit
import SnapKit

class ForecastHeaderView: UIView {
    private lazy var stackView: UIStackView = setupStackView()
    lazy var subTitleLabel: UILabel = setupSubTitleView()
    lazy var iconImageView: UIImageView = setupIconImageView()
    lazy var degreeTitleLabel: UILabel = setupDegreeTitleView()
    
    init() {
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ForecastHeaderView {
    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
}

extension ForecastHeaderView {
    func setupSubviews() {
        addSubview(stackView)
    }
}

extension ForecastHeaderView {
    func setupStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 22
        stackView.layoutMargins = UIEdgeInsets(top: -32, left: 32, bottom: 16, right: 32)
        
        stackView.addArrangedSubviews(
            subTitleLabel,
            iconImageView,
            degreeTitleLabel
        )
        return stackView
    }
    
    func setupIconImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = WeatherResources.Assets._01.image
        imageView.snp.makeConstraints {
            $0.height.equalTo(160)
            $0.width.equalTo(160)
        }
        return imageView
    }
    
    func setupDegreeTitleView() -> UILabel {
        let label = UILabel()
        label.text = "12°C"
        label.font = FontDefinition.largeTitle.font
        label.textColor = WeatherResources.Colors.blueDark.color
        label.textAlignment = .center
        return label
    }
    
    func setupSubTitleView() -> UILabel {
        let label = UILabel()
        label.text = "Chance of rain: 0%"
        label.font = FontDefinition.description.font
        label.textColor = WeatherResources.Colors.gray.color
        return label
    }
}
