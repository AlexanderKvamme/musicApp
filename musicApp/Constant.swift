//
//  Constant.swift
//  musicApp
//
//  Created by Alexander Kvamme on 27/12/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Fileprivate Properties

let screenWidth: CGFloat = UIScreen.main.bounds.width
let screenHeight: CGFloat = UIScreen.main.bounds.width

let mediumTextHeight: CGFloat = {
   let lbl = UILabel()
    lbl.text = "STRING"
    lbl.font = UIFont.custom(style: .bold, ofSize: .medium)
    lbl.sizeToFit()
    print("BAM: height was /(lbl.frame.height)")
    return lbl.frame.height
}()

// MARK: - Globals

enum Constant {
    enum triangleView {
        static let shrinkBy: CGFloat = 50
    }
}

