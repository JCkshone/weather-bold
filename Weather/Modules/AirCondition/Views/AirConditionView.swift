//
//  AirConditionView.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 17/06/23.
//

import UIKit
import SnapKit

class AirConditionView: UIView {
    private lazy var contentView: UIView = setupContentView()
    private lazy var stackView: UIStackView = setupStackView()
    private lazy var titleLabel: UILabel = setupTitleLabel()
    private lazy var headerStackView = ForecastHeaderView()
    lazy var backButton: UIButton = setupButton()

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

extension AirConditionView {
    func setupView() {
        self.backgroundColor = WeatherColor.background.color
    }
    
    func setupSubviews() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(contentView)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(13)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(22)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    func setupContent() {
        stackView.addArrangedSubviews(
            headerStackView
        )
    }
}

extension AirConditionView {
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
        let stack = UIStackView()
        return stack
    }
}

extension AirConditionView {
    func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Air Conditions"
        label.textColor = WeatherColor.gray.color
        label.font = FontDefinition.title.font
        label.textAlignment = .center
        return label
    }
    
    func setupButton() -> UIButton {
        let button = UIButton()
        button.setImage(with: WeatherImages.Sf.chevronLeft)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = WeatherColor.gray.color
        return button
    }
}
