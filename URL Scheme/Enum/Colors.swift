//
//  Colors.swift
//  URL Scheme
//
//  Created by Hugo Francisco Rivera Quevedo on 17/12/23.
//

import UIKit

/// Enum que define los colores que se van a usar
public enum Colors: String {
    case green = "green"
    case yellow = "yellow"
    case blue = "blue"
    
    ///Regresa el color seleccionado
    ///   - Returns: UIColor
    public func setBackgroundColor() -> UIColor {
        switch self {
        case .green:
            return .green
        case .yellow:
            return .yellow
        case .blue:
            return .blue
        }
    }
}
