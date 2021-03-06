//
//  Font.swift
//  musicApp
//
//  Created by Alexander Kvamme on 26/12/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static func custom(style: CustomFont, ofSize: FontSize) -> UIFont {
        return UIFont(name: style.rawValue, size: ofSize.rawValue)!
    }
}

// MARK: - Fonts

enum CustomFont: String {
    case bold = "Futura-Bold"
    case medium = "Futura-Medium"
    
    func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}

// MARK: - Sizes

enum FontSize: CGFloat {
    case small = 8
    case medium = 16
    case big = 24
    case bigger = 32
    case biggest = 40
    case extreme = 72
}
