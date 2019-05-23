//
//  ZoomOutAnimator.swift
//  ezbuy
//
//  Created by 王玎 on 4/28/16.
//  Copyright © 2016 com.ezbuy. All rights reserved.
//

import Foundation

extension TransitionAnimators {

    /**
     放大效果，适用于dismiss 和 pop 动画

     - parameter duration:    动画持续时间
     - parameter sx:          宽度缩放比例，默认0.1
     - parameter sy:          高度缩放比例，默认0.1
     - parameter ensureViews: 请务必传入true

     - returns: 实现UIViewControllerAnimatedTransitioning的实例
     */
    public static func makeZoomOutAnimationWithDuration(_ duration: TimeInterval, _ sx: CGFloat = 0.1, _ sy: CGFloat = 0.1, ensureViews: Bool = true) -> UIViewControllerAnimatedTransitioning {
        //由于动画效果一样，直接调用ScaleUp动画的实现
        return TransitionAnimators.makeScaleUpAnimationWithDuration(duration, sx, sy, ensureViews: ensureViews)

    }
}
