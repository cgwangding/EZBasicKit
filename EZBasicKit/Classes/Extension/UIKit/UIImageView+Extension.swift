//
//  UIImageView+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/27.
//

import Foundation

extension UIImageView {

    public func ez_addTarget(_ target: Any?, action: Selector?) {

        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tap)
    }
}
