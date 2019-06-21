//
//  UIButton+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/27.
//

import Foundation

// MARK: - 防重复多次点击
extension UIButton {
    
    private struct AssociatedKeys {
        static var acceptEventInterval = "btn_acceptEventInterval"
        static var waittingTime = "btn_wattingTime"
    }

    public var ez_acceptEventInterval: TimeInterval {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.acceptEventInterval) as? TimeInterval) ?? 0.0
        }
        set {
            assert(newValue > 0, "accpet event interval must greater than zero")
            objc_setAssociatedObject(self, &AssociatedKeys.acceptEventInterval, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var ez_wattingTime: TimeInterval {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.waittingTime) as? TimeInterval) ?? 0.0
        }

        set {
            objc_setAssociatedObject(self, &AssociatedKeys.waittingTime, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public static func methodSwizzling() {
        
        DispatchQueue.once(token: "UIButton") {
            
            guard let before = class_getInstanceMethod(self.classForCoder(), #selector(self.sendAction(_:to:for:))),
                let after = class_getInstanceMethod(self.classForCoder(), #selector(self.ez_sendAction(_:to:for:))) else { return }
            
            let didAddMethod = class_addMethod(self, #selector(UIButton.sendAction(_:to:for:)), method_getImplementation(after), method_getTypeEncoding(after))
            
            if didAddMethod {
                class_replaceMethod(self, #selector(UIButton.ez_sendAction(_:to:for:)), method_getImplementation(before), method_getTypeEncoding(before))
            } else {
                
                method_exchangeImplementations(before, after)
            }
        }
    }

    @objc fileprivate func ez_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        guard Date().timeIntervalSince1970 - ez_wattingTime > ez_acceptEventInterval else {
            return
        }

        ez_wattingTime = Date().timeIntervalSince1970
        ez_sendAction(action, to: target, for: event)
    }
}

extension DispatchQueue {
    
    private static var onceTracker = [String]()
    
    open class func once(token: String, block:() -> ()) {
        
        objc_sync_enter(self)
        defer {
            
            objc_sync_exit(self)
        }
        
        if onceTracker.contains(token) {
            return
        }
        onceTracker.append(token)
        block()
        defer {
            print("block执行完毕")
        }
    }
}

// MARK: - 扩大点击区域
extension UIButton {

    private static var ez_enlargeInset: String = "ez_enlargeInset"

    public var ez_enlargeInst: UIEdgeInsets {
        get {
            return (objc_getAssociatedObject(self, &UIButton.ez_enlargeInset) as? UIEdgeInsets ) ?? UIEdgeInsets.zero
        }
        set {
            objc_setAssociatedObject(self, &UIButton.ez_enlargeInset, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var enlargeRect: CGRect {
        if self.ez_enlargeInst == .zero {
            return self.bounds
        } else {
            return CGRect(x: self.bounds.minX - self.ez_enlargeInst.left, y: self.bounds.minY - self.ez_enlargeInst.top, width: self.bounds.width + self.ez_enlargeInst.left + self.ez_enlargeInst.right, height: self.bounds.height + self.ez_enlargeInst.top + self.ez_enlargeInst.bottom)
        }
    }

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {

        if self.bounds.equalTo(self.enlargeRect) {
            return super.point(inside: point, with: event)
        } else {
            return self.enlargeRect.contains(point)
        }
    }
}
