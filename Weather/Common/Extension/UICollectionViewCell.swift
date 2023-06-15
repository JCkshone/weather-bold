//
//  UICollectionViewCell.swift
//  Weather
//
//  Created by Juan Camilo Navarro on 11/06/23.
//

import Foundation
import UIKit

public protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

// MARK: - ReusableView

/// ReusableView default resuse identifier
public extension ReusableView where Self: UIView {
    /// default indentifier reuse
    static var defaultReuseIdentifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell {
    static var nib: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableViewCell {

    static var nib: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        String(describing: self)
    }
}
