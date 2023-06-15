//
//  SelectCountryViewController.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 10/06/23.
//

import UIKit

class SelectCountryViewController: UIViewController {
    private(set) lazy var innerView = SelectCountryView()

    init() {
        super.init(nibName: .none, bundle: .none)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = innerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
