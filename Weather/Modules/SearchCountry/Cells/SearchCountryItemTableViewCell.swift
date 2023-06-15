//
//  SearchCountryItemTableViewCell.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 13/06/23.
//

import UIKit
import SnapKit

class SearchCountryItemTableViewCell: UITableViewCell, ReusableView {
    private lazy var iconImageView: UIImageView = setupIconImageView()
    private lazy var degreeLabel: UILabel = setupDegreeLabel()
    private lazy var countryLabel: UILabel = setupCountryLabel()
    private lazy var timeLabel: UILabel = setupTimeLabel()
    private lazy var stackInfo: UIStackView = setupStackInfoView()
    private lazy var cellContentView: UIView = setupCellContentView()
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = UIImage()
        degreeLabel.text = .empty
        countryLabel.text = .empty
        timeLabel.text = .empty
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchCountryItemTableViewCell {
    func setupData(with info: WeatherResult) {
        iconImageView.image = UIImage(named: info.weather.first?.icon.digits ?? "01")
        countryLabel.text = "\(info.name), \(info.sys.country)"
        timeLabel.text = "\(info.dt)".getTime()
        degreeLabel.text = self.convertToCelsius(info.main.temp)
    }
}

extension SearchCountryItemTableViewCell {
    func setupSubviews() {
        contentView.addSubview(cellContentView)
        cellContentView.addSubview(iconImageView)
        cellContentView.addSubview(stackInfo)
        cellContentView.addSubview(degreeLabel)
    }
    
    func setupConstraints() {
        cellContentView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        iconImageView.snp.makeConstraints {
            $0.centerY.equalTo(cellContentView.snp.centerY)
            $0.leading.equalTo(cellContentView.snp.leading).offset(16)
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
        stackInfo.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(degreeLabel.snp.leading)
            $0.centerY.equalTo(cellContentView.snp.centerY)
        }
        
        degreeLabel.snp.makeConstraints {
            $0.trailing.equalTo(cellContentView.snp.trailing).offset(-16)
            $0.centerY.equalTo(cellContentView.snp.centerY)
            $0.width.lessThanOrEqualTo(80)
        }
    }
}

extension SearchCountryItemTableViewCell {
    func setupCellContentView() -> UIView {
        let view = UIView()
        view.backgroundColor = WeatherColor.section.color
        view.layer.cornerRadius = 16
        return view
    }
    
    func setupStackInfoView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .zero
        stackView.distribution = .fillProportionally
        
        stackView.addArrangedSubviews(
            countryLabel,
            timeLabel
        )
        return stackView
    }
    
    func setupIconImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = WeatherResources.Assets._01.image
        return imageView
    }
    
    func setupDegreeLabel() -> UILabel {
        let label = UILabel()
        label.text = "12°C"
        label.font = FontDefinition.mediumLightTitle.font
        label.textColor = WeatherResources.Colors.gray.color
        label.textAlignment = .center
        return label
    }
    func setupCountryLabel() -> UILabel {
        let label = UILabel()
        label.text = "Bogota, CO"
        label.font = FontDefinition.title.font
        label.textColor = WeatherResources.Colors.blueDark.color
        label.textAlignment = .left
        return label
    }
    
    func setupTimeLabel() -> UILabel {
        let label = UILabel()
        label.text = "19:17 pm"
        label.font = FontDefinition.titleSection.font
        label.textColor = WeatherResources.Colors.gray.color
        label.textAlignment = .left
        return label
    }
}

