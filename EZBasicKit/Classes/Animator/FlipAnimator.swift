//
//  FlipAnimator.swift
//  ezbuy
//
//  Created by 王玎 on 4/27/16.
//  Copyright © 2016 com.ezbuy. All rights reserved.
//

import Foundation

extension TransitionAnimators {

    /**
     暂未实现，请稍后使用

     - parameter duration:    <#duration description#>
     - parameter fromEdge:    <#fromEdge description#>
     - parameter ensureViews: <#ensureViews description#>

     - returns: <#return value description#>
     */

    public static func makeFlipAnimationWith(_ duration: TimeInterval = 2, fromEdge: UIRectEdge = .right, ensureViews: Bool = true) -> UIViewControllerAnimatedTransitioning {

        let backgroundView = UIView(frame: CGRect.zero)
        backgroundView.backgroundColor = UIColor.black

        return BasicTransitionAnimator(duration: duration).enusreViews(ensureViews).initial { containerView, from, to in

            guard let to = to, let from = from else { return }

            var angle: CGFloat = CGFloat(M_PI)
            let _: CGVector = {
                switch fromEdge {
                case UIRectEdge.top:
                    return CGVector(dx: 0.0, dy: 1.0)
                case UIRectEdge.bottom:
                    angle = angle * -1.0
                    return CGVector(dx: 0.0, dy: -1.0)
                case UIRectEdge.left:
                    return CGVector(dx: 1.0, dy: 0.0)
                case UIRectEdge.right:
                    angle = angle * -1.0
                    return CGVector(dx: -1.0, dy: 0.0)
                default:
                    fatalError("No other edges suppported")
                }
            }()
            to.viewAsEnd()
            from.viewAsStart()

            //Add a perspective transform
            var transform = CATransform3DIdentity
            transform.m34 = -0.002
            containerView.layer.sublayerTransform = transform

            //change anchor point 
//            from.view.layer.anchorPoint = 



            }.transit { (containerView, from, to) in

                guard let to = to, let from = from else { return }

                //                from.view.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                //                to.view.transform = CGAffineTransformIdentity
                from.view.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0.0, 1.0, 0.0)
                to.view.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0.0, 1.0, 0.0)
                to.view.layer.anchorPointZ = 3


                to.view.layer.transform = CATransform3DIdentity
                
            }.end { (containerView, from, to) in
                backgroundView.removeFromSuperview()
        }
    }
}
