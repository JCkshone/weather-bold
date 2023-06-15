//
//  SelectCountryView.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 13/06/23.
//

import UIKit
import SnapKit

class SelectCountryView: UIView {
    private lazy var contentView: UIView = setupContentView()
    private lazy var textField: UITextField = setupTextField()
    private lazy var searchContent: UIView = setupSearchContent()
    private lazy var tableView: UITableView = setupTableView()
    
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

extension SelectCountryView {
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
        
        textField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension SelectCountryView {
    
    func setupContentView() -> UIView {
        let contentView = UIView()
        let scrollView = UIScrollView()
        
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { $0.edges.equalTo(contentView) }
        
        searchContent.addSubview(textField)
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
}

extension SelectCountryView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected item:")
    }
}
