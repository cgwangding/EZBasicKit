//
//  InnerMoveTransition.swift
//  ezbuy
//
//  Created by admin on 2017/8/16.
//  Copyright © 2017年 com.ezbuy. All rights reserved.
//

import UIKit

public class InnerPopoverTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    public var sourceView: UIView?
    
    /// Note: if the presented display Not fullScreenWidth, set preferredContentWidth
    public var preferredContentSize: CGSize?
    
    public init(sourceView: UIView) {
        self.sourceView = sourceView
        super.init()
    }
    
    private var sourceViewOriginRectToKeyWindow: CGRect {
        
        guard  let sourceView = self.sourceView, let superView = sourceView.superview else {
            return CGRect.zero
        }
        return superView.convert(sourceView.frame, to: UIApplication.shared.keyWindow)
    }
    
    private func animationOriginRect(forPresented presented: UIViewController) -> CGRect {
        var rect = presentedRect(forPresented: presented)
        rect.size.height = 0.0
        return rect
    }
    
    internal func presentedRect(forPresented presented: UIViewController) -> CGRect {
        let rect = sourceViewOriginRectToKeyWindow
        let screenSize =  UIScreen.main.bounds.size
        
        var preferredContentSize = self.preferredContentSize ?? presented.preferredContentSize
        if preferredContentSize == .zero {
            preferredContentSize = screenSize
        }
        
        preferredContentSize.width = min(preferredContentSize.width,
                                         screenSize.width)
        preferredContentSize.height = min(preferredContentSize.height,
                                          screenSize.height * 0.5,
                                          screenSize.height - rect.maxY)
        
        var originPoint: CGPoint = CGPoint(x: rect.midX - preferredContentSize.width * 0.5, y: rect.maxY)
        var endPoint: CGPoint = CGPoint(x: rect.midX + preferredContentSize.width * 0.5, y: rect.maxY)
        
        if originPoint.x < 0 || endPoint.x > screenSize.width {
            var offset: CGFloat = 0.0
            
            if originPoint.x < 0 {
                offset = abs(originPoint.x)
            }
            
            if endPoint.x > screenSize.width {
                offset = screenSize.width - endPoint.x
            }
            
            originPoint.x += offset
            endPoint.x += offset
        }
        return CGRect(origin: originPoint, size: preferredContentSize)
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let rect = animationOriginRect(forPresented: presented)
        return TransitionAnimators.makeInnerMoveInAnimator(0.3, startRect: rect)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let rect = animationOriginRect(forPresented: dismissed)
        
        return TransitionAnimators.makeInnerMoveOutAnimator(0.3, endRect: rect)
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return InnerPopoverPresentationController(presentedViewController: presented, presenting: presenting).handleFrame({ (_, _) -> CGRect in
            return self.presentedRect(forPresented: presented)
        })
    }
}

public class InnerPopoverClearBackgroundTransition: InnerPopoverTransition {
    
    public override func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return InnerPopoverClearBackgroundPresentationController(presentedViewController: presented, presenting: presenting).handleFrame({ (_, _) -> CGRect in
            return self.presentedRect(forPresented: presented)
        })
    }
}
