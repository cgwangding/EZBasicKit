//
//  UIImageView+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/27.
//

import Foundation

// MARK: - add action for image view
extension UIImageView {

    public func ez_addTarget(_ target: Any?, action: Selector?) {

        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tap)
    }
}

// MARK: - create a circle image view
extension UIImageView {

    public convenience init?(circle frame: CGRect) {

        guard frame.width == frame.height else {
            return nil
        }

        self.init(frame: frame)
        self.layer.cornerRadius = frame.height / 2
        self.layer.masksToBounds = true
    }
}
