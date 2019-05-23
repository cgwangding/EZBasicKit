//
//  InnerMoveAnimator.swift
//  PopoverSimpleDemo
//
//  Created by admin on 2017/8/15.
//  Copyright © 2017年 enjoy. All rights reserved.
//

import UIKit

extension TransitionAnimators {
    
    public static func makeInnerMoveInAnimator(_ duration: TimeInterval = 0.3, startRect start: CGRect = CGRect.zero) -> AbstractTransitionAnimator {
        
        return BasicTransitionAnimator(duration: duration).initial { container, from, to in
            
            guard let to = to else { return }
            
            from?.setViewFromStart()
            
            to.view.frame = start
            
            container.bringSubviewToFront(to.view)
            
            }.transit { container, from, to in
                
                guard let to = to else { return }
                to.setViewToEnd()
                
            }.end { container, from, to in
                
                to?.setViewToEnd()
        }
    }
    
    public static func makeInnerMoveOutAnimator(_ duration: TimeInterval, endRect end: CGRect) -> AbstractTransitionAnimator {
        
        return self.makeInnerMoveInAnimator(duration, startRect: end).reversed
    }
}
