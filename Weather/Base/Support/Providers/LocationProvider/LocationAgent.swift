//
//  LocationAgent.swift
//  Weather
//
//  Created by Juan camilo Navarro on 13/06/23.
//

import Foundation
import CoreLocation
import Combine

public protocol LocationAgent: AnyObject {
    var location: Published<CLLocation?>.Publisher { get }
    
    func requestAccess()
    func loadLocation()
}
