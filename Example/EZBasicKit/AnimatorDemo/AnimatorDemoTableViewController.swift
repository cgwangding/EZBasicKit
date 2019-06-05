//
//  AnimatorDemoTableViewController.swift
//  EZBasicKit_Example
//
//  Created by wangding on 2019/6/5.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class AnimatorDemoTableViewController: UITableViewController {

    var presentedAnimator: UIViewControllerAnimatedTransitioning?
    var dismissAnimator: UIViewControllerAnimatedTransitioning?

    var strongTransitionDelegate: UIViewControllerTransitioningDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

       self.title = "Animator"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        let duration = 0.75
        var title: String = ""
        switch indexPath.row {
        case 0:
            // move in
            self.presentedAnimator = TransitionAnimators.makeMoveInAnimator(from: .right)
            self.dismissAnimator = TransitionAnimators.makeMoveOutAnimator(duration, to: .right)
//            self.present(self.testVC, animated: true, completion: nil)
            title = "move in"
        case 1:
            // dissolve
            self.presentedAnimator = TransitionAnimators.makeDissolveAnimator(duration)
            self.dismissAnimator = TransitionAnimators.makeDissolveAnimator(duration).reversed
            title = "dissolve"
        case 2:
            // inner move in
            self.presentedAnimator = TransitionAnimators.makeInnerMoveInAnimator(duration, startRect: CGRect(x: 100, y: 50, width: 300, height: 600))
            self.dismissAnimator = TransitionAnimators.makeInnerMoveOutAnimator(duration, endRect: CGRect(x: 175, y: 175, width: 30, height: 30))
            title = "inner move"
        case 3:
            // pan in
            self.presentedAnimator = TransitionAnimators.makePanInAnimator(duration, from: .top)
            self.dismissAnimator = TransitionAnimators.makePanOutAnimator(duration, to: .bottom)
            title = "pan in"
        case 4:
            // push
            self.presentedAnimator = TransitionAnimators.makePushInAnimator(duration, from: .right)
            self.dismissAnimator = TransitionAnimators.makePushInAnimator(duration, from: .right).reversed
            title = "push"
        case 5:
            // scale
            self.presentedAnimator = TransitionAnimators.makeScaleAndFadeInAnimator()
            self.dismissAnimator = TransitionAnimators.makeScaleAndFadeOutAnimator()
            title = "scale & fade"
        case 6:
            // edge pan
            let vc = AnimatorDemoTableViewController.make(title: "edge pan")
            self.strongTransitionDelegate = EdgePanTransitionDelegate(toViewController: vc)
            vc.transitioningDelegate = self.strongTransitionDelegate
            self.present(vc, animated: true, completion: nil)
        case 7:
            // swipe
            let vc = AnimatorDemoTableViewController.make(title: "swipe")
            self.strongTransitionDelegate = SwipeTransitionDelegate()
            vc.transitioningDelegate = self.strongTransitionDelegate
            self.present(vc, animated: true, completion: nil)
        default: break
        }

        let vc = AnimatorDemoTableViewController.make(title: title)
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
}

extension AnimatorDemoTableViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.presentedAnimator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.dismissAnimator
    }
}
