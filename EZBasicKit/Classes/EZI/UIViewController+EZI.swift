//
//  UIViewController+EZI.swift
//  ezbuy
//
//  Created by Rocke on 16/8/29.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import UIKit

extension UIViewController: EZINode {
    
    open var eziHandleable: EZIHandleable? {
        return !self.ignoreEZI ? (self as? EZIHandleable) : nil
    }
    
    @objc open var ignoreEZI: Bool { return self.presentedViewController != nil }
    
    open var firstEZINode: EZINode {
    
        if let presented = self.presentedViewController {
            return presented.firstEZINode
        } else {
            return self.currentChildViewController?.firstEZINode ?? self
        }
    }
    
    @objc open var currentChildViewController: UIViewController? {
        return nil
    }
}

extension UINavigationController {
    
    @objc open override var currentChildViewController: UIViewController? {
        return self.topViewController
    }
}

extension UITabBarController {
    
    @objc open override var currentChildViewController: UIViewController? {
        return self.selectedViewController
    }
}

extension UIPageViewController {

    @objc open override var currentChildViewController: UIViewController? {
        return self.viewControllers?.first ?? self
    }
}
