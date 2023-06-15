//
//  Coodinator.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 8/06/23.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
