//
//  String.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 14/06/23.
//

import Foundation

extension String {
    static let empty = ""
    
    var digits: String {
        return components(
            separatedBy: CharacterSet.decimalDigits.inverted
        ).joined()
    }
    func getTime() -> String {
        guard let unix = Double(self) else {
            return.empty
        }

        let date = Date(timeIntervalSince1970: unix)
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"
        
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm a"
        
        return dateFormatter.string(from: date)
    }
    
    func getDay() -> String {
        guard let unix = Double(self) else {
            return.empty
        }

        let date = Date(timeIntervalSince1970: unix)
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"
        
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: date)
    }
    
}
