//
//  ForecastTodayItemCollectionViewCell.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 11/06/23.
//

import UIKit
import SnapKit

class ForecastTodayItemCollectionViewCell: UICollectionViewCell {
    private lazy var stackView: UIStackView  = setupStackView()
    private lazy var timeLabel: UILabel = setupTimeLabel()
    private lazy var degreeLabel: UILabel = setupDegreeLabel()
    private lazy var iconImage: UIImageView = setupIconImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        timeLabel.text = .empty
        degreeLabel.text = .empty
        iconImage.image = UIImage()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        setupConstraints()
    }
    
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ForecastTodayItemCollectionViewCell {
    
    func setupSubViews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setupInfo(with info: ForecastToday) {
        timeLabel.text = info.time
        degreeLabel.text = info.temp
        iconImage.image = UIImage(named: info.icon)
    }
}


extension ForecastTodayItemCollectionViewCell {
    func setupStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .zero
        stackView.distribution = .equalCentering
        stackView.layoutMargins = UIEdgeInsets(top: .zero, left: 16, bottom: 16, right: 16)
        stackView.addArrangedSubviews(
            timeLabel,
            iconImage,
            degreeLabel
        )
        return stackView
    }
    
    func setupIconImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = WeatherResources.Assets._01.image
        imageView.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        return imageView
    }
    
    func setupDegreeLabel() -> UILabel {
        let label = UILabel()
        label.text = "12°C"
        label.font = FontDefinition.title.font
        label.textColor = WeatherResources.Colors.blueDark.color
        label.textAlignment = .center
        return label
    }
    
    func setupTimeLabel() -> UILabel {
        let label = UILabel()
        label.text = "7:00 am"
        label.font = FontDefinition.title.font
        label.textColor = WeatherResources.Colors.gray.color
        label.textAlignment = .center
        return label
    }
}
