//
//  SwipeTransitionDelegate.swift
//  Swipe
//
//  Created by Arror on 16/4/18.
//  Copyright © 2016年 Arror. All rights reserved.
//

import UIKit

public class SwipeTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return TransitionAnimators.makeMoveInAnimator(0.3, from: .left)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return TransitionAnimators.makeMoveOutAnimator(0.3, to: .left)
    }
}
