//
//  UIStoryboard.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/29.
//

import Foundation

extension UIStoryboard {

    public func instance<T: UIViewController>(for aClass: T.Type) -> T {
        return instantiateViewController(withIdentifier: aClass.name) as! T
    }
}
