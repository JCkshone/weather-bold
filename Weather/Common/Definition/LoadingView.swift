//
//  LoadingView.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 14/06/23.
//
import UIKit

protocol LoadingView {}

extension LoadingView {
    func setupLoadingView(with message: String = "Please wait...") -> UIAlertController {
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
//        present(alert, animated: true, completion: nil)
        return alert
    }
}

