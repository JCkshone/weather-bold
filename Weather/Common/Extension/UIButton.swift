//
//  UIswift
//  Weather
//
//  Created by Juan Camilo Navarro on 11/06/23.
//

import Foundation
import UIKit

extension UIButton {
    func setRadiusAndShadow(with radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 2)
        layer.shadowColor = WeatherColor.gray.color.cgColor
        layer.masksToBounds = false
    }
}
