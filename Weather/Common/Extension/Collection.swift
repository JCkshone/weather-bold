//
//  Collection.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 14/06/23.
//

import Foundation

extension Collection {
    func at(_ index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
