//
//  ForecastTodayView.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 11/06/23.
//

import UIKit
import SnapKit

class ForecastTodayView: UIView {
    private lazy var titleLabel: UILabel = setupTitleView()
    private lazy var collectionView: UICollectionView = setupCollectionView()
    private var forecastToday: [ForecastToday] = []

    init() {
        super.init(frame: .zero)
        setupView()
        setupSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ForecastTodayView {
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(16)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension ForecastTodayView {
    func setupView() {
        layoutMargins = UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 32)
        backgroundColor = WeatherColor.section.color
        layer.cornerRadius = 16
        snp.makeConstraints { $0.height.equalTo(180) }
    }
    
    func setupSubviews() {
        addSubview(titleLabel)
        addSubview(collectionView)
    }
}

extension ForecastTodayView {
    func setupStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        
        stackView.addArrangedSubviews(
            setupTitleView(),
            setupCollectionView()
        )
        return stackView
    }
    
    func setupTitleView() -> UILabel {
        let label = UILabel()
        label.text = "today's forecast".uppercased()
        label.font = FontDefinition.titleSection.font
        label.textColor = WeatherResources.Colors.gray.color
        return label
    }
    
    func setupCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.register(
            ForecastTodayItemCollectionViewCell.self,
            forCellWithReuseIdentifier: ForecastTodayItemCollectionViewCell.identifier
        )
        
        return collection
    }
    
    func setupInfo(with forecastToday: [ForecastToday]) {
        self.forecastToday = forecastToday
        collectionView.reloadData()
    }
}

extension ForecastTodayView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ForecastTodayItemCollectionViewCell.identifier,
            for: indexPath
        ) as? ForecastTodayItemCollectionViewCell else {
            fatalError("Cell is not registered")
        }
        if let info = forecastToday.at(indexPath.row) {
            cell.setupInfo(with: info)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastToday.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 130)
    }
}
