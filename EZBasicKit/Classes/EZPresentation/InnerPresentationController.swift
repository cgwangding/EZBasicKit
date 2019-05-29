//
//  InnerPresentationController.swift
//  ezbuy
//
//  Created by Arror on 2017/5/2.
//  Copyright © 2017年 com.ezbuy. All rights reserved.
//

import UIKit

public typealias FrameHandler = (CGSize, CGSize) -> CGRect

public class InnerPresentationController: UIPresentationController {
    
    let dimmingView = UIView()
    
    @objc func dimmingViewTapped(_ recognizer: UITapGestureRecognizer) {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }

    @objc func dimmingViewPanAction(_ recognizer: UIPanGestureRecognizer) {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    override public func presentationTransitionWillBegin() {
        
        guard let containerView = self.containerView else { return }
        
        dimmingView.frame = containerView.bounds
        dimmingView.backgroundColor = .black
        dimmingView.isOpaque = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(InnerPresentationController.dimmingViewTapped(_:)))
        dimmingView.addGestureRecognizer(tap)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(dimmingViewPanAction(_:)))
        dimmingView.addGestureRecognizer(pan)
        
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(dimmingView)
        
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        
        dimmingView.alpha = 0.0
        
        transitionCoordinator?.animate(alongsideTransition: { _ in
            
            self.dimmingView.alpha = 0.5
            
        }, completion: nil)
    }
    
    override public func dismissalTransitionWillBegin() {
        
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        
        transitionCoordinator?.animate(alongsideTransition: { _ in
            
            self.dimmingView.alpha = 0.0
            
        }, completion: nil)
        
    }
    
    override public func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        
        if container === self.presentedViewController {
            
            self.containerView?.setNeedsLayout()
        }
    }
    
    override public func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        
        if container === self.presentedViewController {
            
            return container.preferredContentSize
        } else {
            
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
    }
    
    private static let defaultFrameHandler: FrameHandler = { (containerViewSize, _) -> CGRect in
        
        var rect = CGRect.zero
        
        rect.size = containerViewSize
        
        return rect
    }
    
    private var frameHandler: FrameHandler = InnerPresentationController.defaultFrameHandler
    
    public func handleFrame(_ handler: @escaping FrameHandler) -> Self {
        
        self.frameHandler = handler
        
        return self
    }
    
    override public var frameOfPresentedViewInContainerView: CGRect {
        
        let containerViewBounds = self.containerView?.bounds ?? .zero
        
        let presentedViewContentSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerViewBounds.size)
        
        return self.frameHandler(containerViewBounds.size, presentedViewContentSize)
    }
    
    override public func containerViewWillLayoutSubviews() {
        
        super.containerViewWillLayoutSubviews()
        
        let containerView = self.containerView
        
        self.dimmingView.frame = containerView?.bounds ?? .zero
        
        self.presentedView?.frame = self.frameOfPresentedViewInContainerView
    }
}

public class InnerClearBackgroundPresentationController: InnerPresentationController {

    override public func presentationTransitionWillBegin() {

        guard let containerView = self.containerView else { return }

        dimmingView.frame = containerView.bounds
        dimmingView.backgroundColor = .red
        dimmingView.isOpaque = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(InnerPresentationController.dimmingViewTapped(_:)))
        dimmingView.addGestureRecognizer(tap)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(dimmingViewPanAction(_:)))
        dimmingView.addGestureRecognizer(pan)

        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(dimmingView)

        dimmingView.alpha = 0.1
    }

}
