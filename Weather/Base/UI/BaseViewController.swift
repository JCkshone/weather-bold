//
//  BaseViewController.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 14/06/23.
//

import UIKit

class BaseViewController: UIViewController, LoadingView {
    private(set) lazy var loadingView = setupLoadingView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoading() {
        self.present(loadingView, animated: true)
    }
    
    func hiddeLoading() {
        self.dismiss(animated: true)
    }

}
