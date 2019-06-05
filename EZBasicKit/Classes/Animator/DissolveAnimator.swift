//
//  DissolveAnimator.swift
//  ezbuy
//
//  Created by 王玎 on 4/27/16.
//  Copyright © 2016 com.ezbuy. All rights reserved.
//

import Foundation

extension TransitionAnimators {

    public static func makeDissolveAnimator(_ duration: TimeInterval = 0.3) -> AbstractTransitionAnimator {

        return BasicTransitionAnimator(duration: duration).initial { container, from, to in

            guard let to = to else { return }

            from?.setViewFromStart()
            to.setViewToEnd()
            to.view.alpha = 0.0
            
            container.bringSubviewToFront(to.view)
            
        }.transit { container, from, to in
                
            guard let to = to else { return }
            
            to.view.alpha = 1.0
                
        }.end { container, from, to in
                
            guard let to = to else { return }
            
            to.view.alpha = 1.0
        }
    }
}
