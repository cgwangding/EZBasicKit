//
//  UIView+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/24.
//

import Foundation

// MARK: - UIView Extension

extension UIView {

    public func ancestor(ofType t: AnyClass) -> UIView? {

        if self.isKind(of: t) {
            return self
        } else {
            return self.superview?.ancestor(ofType: t)
        }
    }
}

extension UIView {

    func snapShot() -> UIImage? {

        UIGraphicsBeginImageContext(self.bounds.size)
        if let ctx = UIGraphicsGetCurrentContext() {
            self.layer.render(in: ctx)
            let snapShot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return snapShot
        } else {
            UIGraphicsEndImageContext()
            return nil
        }
    }
}
