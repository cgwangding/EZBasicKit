//
//  UIScrollView+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/28.
//

import Foundation

extension UIView {

    fileprivate func preventSlibings() {
        guard let superview = self.superview else { return }

        for subview in superview.subviews {
            guard subview !== self else { continue }

            subview.preventDescedants()
        }

        superview.preventSlibings()
    }

    fileprivate func preventDescedants() {
        if let scrollView = self as? UIScrollView {
            scrollView.scrollsToTop = false
        }

        for subview in self.subviews {
            subview.preventDescedants()
        }
    }
}

extension UIScrollView {

    public func requireScrollsToTop() {
        self.preventDescedants()
        self.preventSlibings()
        self.scrollsToTop = true
    }
}
