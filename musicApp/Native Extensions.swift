//
//  Native Extensions.swift
//  musicApp
//
//  Created by Alexander Kvamme on 27/12/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

// MARK: Images

extension UIImage {
    
    static var plusSymbol: UIImage {
        return UIImage(named: "plusSymbol")!
    }
    
    static var nextItemSymbol: UIImage {
        return UIImage(named: "nextItemSymbol")!
    }
}

extension MPMediaItemCollection {
    func printItems() {
        for item in items {
            Swift.print(" - PRINTING: ", item.title!)
        }
    }
}

// MARK: Method to resize
//extension UIImage {
//
//    func resize(maxWidthHeight : Double)-> UIImage? {
//        let actualHeight = Double(size.height)
//        let actualWidth = Double(size.width)
//        var maxWidth = 0.0
//        var maxHeight = 0.0
//
//        if actualWidth > actualHeight {
//            maxWidth = maxWidthHeight
//            let per = (100.0 * maxWidthHeight / actualWidth)
//            maxHeight = (actualHeight * per) / 100.0
//        } else {
//            maxHeight = maxWidthHeight
//            let per = (100.0 * maxWidthHeight / actualHeight)
//            maxWidth = (actualWidth * per) / 100.0
//        }
//
//        let hasAlpha = true
//        let scale: CGFloat = 0.0
//
//        UIGraphicsBeginImageContextWithOptions(CGSize(width: maxWidth, height: maxHeight), !hasAlpha, scale)
//        self.draw(in: CGRect(origin: .zero, size: CGSize(width: maxWidth, height: maxHeight)))
//
//        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
//        return scaledImage
//    }
//}

