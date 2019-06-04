//
//  InnerPopoverClearBackgroundPresentationController.swift
//  ezbuyUIKit
//
//  Created by Enjoy on 2018/12/6.
//  Copyright © 2018 com.ezbuy. All rights reserved.
//

import UIKit

public class InnerPopoverClearBackgroundPresentationController: InnerPopoverPresentationController {
    
    override public func presentationTransitionWillBegin() {
        guard let containerView = self.containerView else { return }
        
        dimmingView.frame = containerView.bounds
        dimmingView.backgroundColor = .black
        dimmingView.isOpaque = false
        dimmingView.alpha = 0.0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(InnerPopoverClearBackgroundPresentationController.dimmingViewTapped(_:)))
        dimmingView.addGestureRecognizer(tap)
        
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(dimmingView)
        
        clarityView.frame = containerView.bounds
        clarityView.backgroundColor = .clear
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(InnerPopoverClearBackgroundPresentationController.clarityViewTapped(_:)))
        clarityView.addGestureRecognizer(tap1)
        
        clarityView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(clarityView)
        
        self.presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            
            self.dimmingView.alpha = 0.02
            
        }, completion: nil)
    }

}
