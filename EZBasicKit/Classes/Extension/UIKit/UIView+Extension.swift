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

    public func snapShot() -> UIImage? {

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

extension UIView {

    public func setCornerRadius(_ value: CGFloat) {
        self.layer.cornerRadius = value
        self.layer.masksToBounds = true
    }
}

// MARK: - blur effect
extension UIView {

    public convenience init(frame: CGRect, blurEffectStyle: UIBlurEffect.Style) {
        self.init(frame: frame)

        let blurView = UIVisualEffectView(frame: self.bounds)
        blurView.effect = UIBlurEffect(style: blurEffectStyle)
        self.addSubview(blurView)
    }
}

// MARK: - frame related
extension UIView {

    public var ezX: CGFloat {
        get {
            return self.frame.minX
        }
        set {
            self.frame.origin.x = newValue
        }
    }

    public var ezY: CGFloat {
        get {
            return self.frame.minY
        }
        set {
            self.frame.origin.y = newValue
        }
    }

    public var ezWidth: CGFloat {
        get {
            return self.frame.width
        }

        set {
            self.frame.size.width = newValue
        }
    }

    public var ezHeight: CGFloat {
        get {
            return self.frame.height
        }
        set {
            self.frame.size.height = newValue
        }
    }

    public var ezOrigin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.frame.origin = newValue
        }
    }

    public var ezSize: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame.size = newValue
        }
    }
}
