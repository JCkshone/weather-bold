//
//  UI.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 10/06/23.
//

import Foundation
import UIKit

typealias WeatherColor = WeatherResources.Colors
typealias WeatherImages = WeatherResources.Assets


extension UIButton {
    func setBackgroundColor(with color: ColorAsset) {
        self.backgroundColor = color.color
    }
    
    func setImage(with image: ImageAsset) {
        self.setImage(image.image, for: .normal)
    }
}
