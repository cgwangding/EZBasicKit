//
//  UIColor+Hex.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/24.
//

import Foundation

extension UIColor {

    public convenience init(_ hex: Int, alpha: CGFloat = 1.0) {

        let r = CGFloat((0xFF0000 & hex) >> 16) / 255.0
        let g = CGFloat((0xFF00 & hex) >> 8) / 255.0
        let b = CGFloat(0xFF & hex) / 255.0

        self.init(red: r, green: g, blue: b, alpha: alpha)
    }

    public convenience init?(_ hex: String, alpha: CGFloat = 1.0) {
        var hexString = hex
        guard !hexString.isEmpty else {
            return nil
        }

        if hexString.hasPrefix("#") {
            hexString.replaceSubrange(hexString.startIndex...hexString.startIndex, with: "0x")
        }

        let scanner = Scanner(string: hexString)

        var value: UInt32 = 0

        if scanner.scanHexInt32(&value) {
            self.init(Int(value), alpha: alpha)
        } else {
            return nil
        }
    }
}

extension UIColor {

    public static var random: UIColor {
        return UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)
    }
}

// MARK: - create a color image
extension UIColor {

    // Don't create the same image, reuse it!!!
    func createImage(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(self.cgColor)
        ctx?.fill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
