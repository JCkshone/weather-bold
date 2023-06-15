//
//  SplashView.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 8/06/23.
//

import UIKit
import SnapKit

class SplashView: UIView {
    private lazy var iconImageView: UIImageView = setupIconImageView()
    private lazy var titleView: UILabel = setupTitleView()
    private lazy var subTitleView: UILabel = setupSubTitleView()
    lazy var nextButton: UIButton = setupNextButton()

    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupSubviews()
        setupConstraints()
    }
}

extension SplashView {
    func setupView() {
        self.backgroundColor = .white
    }
    
    func setupSubviews() {
        addSubview(iconImageView)
        addSubview(titleView)
        addSubview(subTitleView)
        addSubview(nextButton)
    }
}

extension SplashView {
    func setupConstraints() {
        iconImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-80)
            $0.height.equalTo(150)
        }
        titleView.snp.makeConstraints {
            $0.topMargin.equalTo(iconImageView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        subTitleView.snp.makeConstraints {
            $0.topMargin.equalTo(titleView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.topMargin.equalTo(subTitleView.snp.bottom).offset(64)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
    }
}
extension SplashView {
    func setupIconImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = WeatherResources.Assets._01.image
        return imageView
    }
    
    func setupTitleView() -> UILabel {
        let label = UILabel()
        label.text = "Weather"
        label.font = FontDefinition.largeTitle.font
        label.textColor = WeatherResources.Colors.blueDark.color
        return label
    }
    
    func setupSubTitleView() -> UILabel {
        let label = UILabel()
        label.text = "App"
        label.font = FontDefinition.mediumLightTitle.font
        label.textColor = WeatherResources.Colors.gray.color
        return label
    }
    
    func setupNextButton() -> UIButton {
        let button = UIButton()
        button.setImage(with: WeatherImages.Sf.arrowRight)
        button.setBackgroundColor(with: WeatherColor.blue)
        button.setRadiusAndShadow(with: 25)
        button.tintColor = .white
        return button
    }
}
