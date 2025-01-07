//
//  UIColor.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 05/01/25.
//

import UIKit

extension UIColor {
    static let background = UIColor(hex: "1F3B4D")
    static let selectedBackground = UIColor(hex: "2F4B5D")

    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
