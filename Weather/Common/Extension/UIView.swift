//
//  UIView.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 15/06/23.
//

import Foundation
import UIKit

extension UIView {
    func convertToCelsius(_ value: Double) -> String {
        let t = Measurement(value: value, unit: UnitTemperature.kelvin)
        return "\(round(t.converted(to: UnitTemperature.celsius).value))°C"
    }
}
