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
        let t = Measurement(value: value, unit: UnitTemperature.celsius)
        return "\(round(t.converted(to: UnitTemperature.celsius).value))°C"
    }
    
    func addBorder(
        onSide side: UIRectEdge,
        withWidth width: CGFloat = 1,
        color: ColorAsset = WeatherColor.gray
    ) {
        let borderLayer = CALayer()
        borderLayer.backgroundColor = color.color.cgColor
        
        switch side {
        case .top:
            borderLayer.frame = CGRect(
                x: 0, y: 0,
                width: self.frame.size.width,
                height: width
            )
        case .bottom:
            borderLayer.frame = CGRect(
                x: 0, y: self.frame.size.height - width,
                width: self.frame.size.width,
                height: width
            )
        case .left:
            borderLayer.frame = CGRect(
                x: 0, y: 0,
                width: width,
                height: self.frame.size.height
            )
        case .right:
            borderLayer.frame = CGRect(
                x: self.frame.size.width - width, y: 0,
                width: width,
                height: self.frame.size.height
            )
        default:
            break
        }
        
        self.layer.addSublayer(borderLayer)
    }
}
