//
//  SearchCountryView.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 13/06/23.
//

import UIKit
import SnapKit
import Combine

class SearchCountryView: UIView {
    private lazy var contentView: UIView = setupContentView()
    private lazy var searchContent: UIView = setupSearchContent()
    private lazy var tableView: UITableView = setupTableView()
    private var items: [WeatherResult] = []
    
    lazy var textField: UITextField = setupTextField()
    lazy var searchButton: UIButton = setupSearchButton()
    let subjectActiveLocation = PassthroughSubject<ActiveLocation, Never>()
    
    init() {
        super.init(frame: .zero)
        setupSubViews()
        setupConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchCountryView {
    func setupSubViews() {
        addSubview(contentView)
    }
    
    func setupConstraint() {
        contentView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(70)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(searchButton.snp.leading)
            $0.bottom.equalToSuperview()
        }
    }
}

extension SearchCountryView {
    
    func setupContentView() -> UIView {
        let contentView = UIView()
        let scrollView = UIScrollView()
        
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { $0.edges.equalTo(contentView) }
        scrollView.keyboardDismissMode = .interactive
        
        searchContent.addSubview(textField)
        searchContent.addSubview(searchButton)
        scrollView.addSubview(searchContent)
        scrollView.addSubview(tableView)
        scrollView.showsVerticalScrollIndicator = false
        
        searchContent.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.left.equalTo(scrollView.snp.left).offset(16)
            $0.right.equalTo(scrollView.snp.right).offset(-16)
            $0.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchContent.snp.bottom).offset(28)
            $0.left.equalTo(scrollView.snp.left)
            $0.right.equalTo(scrollView.snp.right)
            $0.bottom.equalTo(scrollView.snp.bottom).priority(.low)
            $0.centerX.equalTo(scrollView.snp.centerX)
            $0.centerY.equalTo(scrollView.snp.centerY).priority(.low)
        }
        
        return contentView
    }
    
    func setupTableView() -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(SearchCountryItemTableViewCell.self,
                           forCellReuseIdentifier: SearchCountryItemTableViewCell.identifier)
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }
    
    func setupSearchContent() -> UIView {
        let view = UIView()
        view.backgroundColor = WeatherColor.section.color
        view.layer.cornerRadius = 16
        return view
    }
    
    func setupTextField() -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search cities",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        textField.font = FontDefinition.description.font
        textField.textColor = .black
        textField.tintColor = .black
        let paddingView = UIView(frame: .init(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }
    
    func setupSearchButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = FontDefinition.descriptionMedium.font
        button.setTitleColor(WeatherColor.blue.color, for: .normal)
        return button
    }
}

extension SearchCountryView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchCountryItemTableViewCell.identifier,
            for: indexPath
        ) as? SearchCountryItemTableViewCell, let info = items.at(indexPath.row) else {
            fatalError("Cell is not registered")
        }
        cell.setupData(with: info)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let info = items.at(indexPath.row) else { return }
        subjectActiveLocation.send(
            ActiveLocation(
                lat: info.coord.lat,
                lon: info.coord.lon
            )
        )
    }
}

extension SearchCountryView {
    func updateDataSource(with items: [WeatherResult]) {
        self.items = items
        tableView.reloadData()
    }
}
