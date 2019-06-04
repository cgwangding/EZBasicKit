//
//  InnerMovePresentationController.swift
//  PopoverSimpleDemo
//
//  Created by admin on 2017/8/15.
//  Copyright © 2017年 enjoy. All rights reserved.
// 

import UIKit

public typealias InnerFrameHandler = (CGSize, CGSize) -> CGRect

public class InnerPopoverPresentationController: UIPresentationController {
    
    let dimmingView = UIView()
    let clarityView = UIView()
    
    @objc func dimmingViewTapped(_ recognizer: UITapGestureRecognizer) {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    @objc func clarityViewTapped(_ recognizer: UITapGestureRecognizer) {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    override public func presentationTransitionWillBegin() {
        guard let containerView = self.containerView else { return }
        
        dimmingView.frame = containerView.bounds
        dimmingView.backgroundColor = .black
        dimmingView.isOpaque = false
        dimmingView.alpha = 0.0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(InnerPopoverPresentationController.dimmingViewTapped(_:)))
        dimmingView.addGestureRecognizer(tap)
        
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(dimmingView)
        
        clarityView.frame = containerView.bounds
        clarityView.backgroundColor = .clear
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(InnerPopoverPresentationController.clarityViewTapped(_:)))
        clarityView.addGestureRecognizer(tap1)

        clarityView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(clarityView)

        self.presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            
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
    
    private static let defaultFrameHandler: InnerFrameHandler = { (containerViewSize, _) -> CGRect in
        
        var rect = CGRect.zero
        
        rect.size = containerViewSize
        
        return rect
    }
    
    private var frameHandler: InnerFrameHandler = InnerPopoverPresentationController.defaultFrameHandler
    
    public func handleFrame(_ handler: @escaping InnerFrameHandler) -> Self {
        
        self.frameHandler = handler
        
        return self
    }
    
    override public var frameOfPresentedViewInContainerView: CGRect {
        
        let containerViewBounds = self.containerView?.bounds ?? .zero
        
        let presentedViewContentSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerViewBounds.size)
        
        let rect  = self.frameHandler(containerViewBounds.size, presentedViewContentSize)
        
        return rect
    }
    
    override public func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        guard let containerView = self.containerView else { return }
        
        let rect = self.frameOfPresentedViewInContainerView
        self.presentedView?.frame = rect
        
        self.dimmingView.frame = CGRect(x: 0, y: rect.minY, width: containerView.frame.width, height: containerView.frame.height - rect.minY)
        self.clarityView.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: rect.minY)
    }
}
