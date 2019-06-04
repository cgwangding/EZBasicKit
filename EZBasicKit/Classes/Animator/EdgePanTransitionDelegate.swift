//
//  PresentAnimator.swift
//  ETNavBarTransparentDemo
//
//  Created by admin on 2017/11/24.
//  Copyright © 2017年 EnderTan. All rights reserved.
//

import Foundation
import UIKit

class EdgePanInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    fileprivate(set) var isInteracting : Bool = false
    fileprivate let viewController: UIViewController
    
    init(with toViewController : UIViewController) {
        self.viewController = toViewController
        
        super.init()
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handle(_:)))
        edgePan.edges = [.left]
        viewController.view.addGestureRecognizer(edgePan)
    }
    
    @objc private func handle(_ edgePanRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        switch edgePanRecognizer.state {
        case .began:
            self.isInteracting = true
            viewController.dismiss(animated: true, completion: nil)
            
        case .changed:
            var fraction = edgePanRecognizer.translation(in: viewController.view).x / viewController.view.bounds.width
            fraction = min(1.0, max(0.0, fraction))
            update(fraction)
            
        case .ended:
            self.isInteracting = false

            let velocity = edgePanRecognizer.velocity(in: viewController.view)
            let magnitude = sqrt(velocity.x * velocity.x + velocity.y * velocity.y)
            
            let slideMult = magnitude / 200
            let slideFactor = 0.1 * slideMult;
            
            let translationPoint = edgePanRecognizer.translation(in: viewController.view)
            
            var finalPoint = CGPoint(x: translationPoint.x + (velocity.x * slideFactor),
                                     y: translationPoint.y + (velocity.y * slideFactor))

            finalPoint.x = min(max(finalPoint.x, 0), viewController.view.bounds.width)
            let fraction = finalPoint.x / viewController.view.bounds.width
            
            if fraction > 0.5 {
                finish()
            } else {
                cancel()
            }
            
        case .cancelled:
            self.isInteracting = false
            cancel()
            
        default: break
        }
    }
}


public class EdgePanTransitionDelegate : NSObject, UIViewControllerTransitioningDelegate {
    
    private let interactiveTransition:EdgePanInteractiveTransition

    public init(toViewController: UIViewController) {
        interactiveTransition = EdgePanInteractiveTransition(with: toViewController)
        super.init()
        
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimators.makePushInAnimator()
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimators.makePopInAnimator()
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactiveTransition.isInteracting ? self.interactiveTransition : nil
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactiveTransition.isInteracting ? self.interactiveTransition : nil
    }
    
}

