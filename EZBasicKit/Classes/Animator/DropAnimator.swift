//
//  DropAnimator.swift
//  ezbuy
//
//  Created by 王玎 on 4/28/16.
//  Copyright © 2016 com.ezbuy. All rights reserved.
//

import Foundation

extension TransitionAnimators {

    public static func makeDropAnimationWith(_ duration: TimeInterval = 3, ensureViews: Bool = true) -> UIViewControllerAnimatedTransitioning {


        return BasicTransitionAnimator(duration: duration).enusreViews(ensureViews).initial { containerView, from, to in

            guard let to = to else { return }

            from?.viewAsEnd()
            to.viewAsEnd()
            to.view.frame = CGRect(x: 0, y: -to.toFrame.height, width: to.toFrame.width, height: to.toFrame.height)

            containerView.bringSubview(toFront: to.view)

            }.transit { (containerView, from, to) in
                guard let to = to, let from = from else { return }
                from.viewAsEnd()
                UIView.animate(
                    withDuration: duration,
                    delay: 0.5,
                    usingSpringWithDamping: 0.3,
                    initialSpringVelocity: 0,
                    options: UIViewAnimationOptions(),
                    animations: {
                        to.viewAsEnd()
                    },
                    completion: nil)

            }.end { (containerView, from, to) in
                to?.viewAsEnd()
                from?.viewAsEnd()
                
        }
    }
}
