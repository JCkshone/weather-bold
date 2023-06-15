//
//  Storyboarded.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 8/06/23.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() throws -> Self {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: Bundle.main)
        guard let instance = storyboard.instantiateViewController(
            withIdentifier: NSStringFromClass(self).components(separatedBy: ".")[1]
        ) as? Self else {
            throw WeatherError.Generic.invalidCoordinatorInstance
        }
        return instance
    }
}
