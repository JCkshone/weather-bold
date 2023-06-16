//
//  BaseViewController.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 14/06/23.
//

import UIKit

class BaseViewController: UIViewController, LoadingView {
    private(set) lazy var loadingView = setupLoadingView()
    private(set) lazy var alertView = setupAlertView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoading() {
        self.present(loadingView, animated: true)
    }
    
    func hiddeLoading() {
        self.dismiss(animated: true)
    }
    
    func showAlert(
        with title: String,
        and message: String
    )  {
        alertView.title = title
        alertView.message = message
        present(self.alertView, animated: true)
    }
    
    func dismissAndShowAlert(
        with title: String,
        and message: String
    )  {
        self.dismiss(animated: true) {
            self.alertView.title = title
            self.alertView.message = message
            self.present(self.alertView, animated: true)
        }
    }
}
