//
//  PresentationViewController.swift
//  EZBasicKit_Example
//
//  Created by qiuming on 2019/7/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

enum PresentStyle: Int {
    
    case clearBackground     = 30001
    case popoverPresentation = 30002
    case popoverTransition   = 30003
    case presentation        = 30004
    case normal
}

class PresentationViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var presentStyle: PresentStyle = .normal
    
    @IBAction func presentViewController(_ sender: UIButton) {
        
        self.presentStyle = PresentStyle(rawValue: sender.tag) ?? PresentStyle.normal
        
        switch sender.tag {
        case PresentStyle.clearBackground.rawValue:
            self.popoverClearBackgroundPresentationController(sender)
            
        case PresentStyle.popoverPresentation.rawValue:
            self.popoverPresentationController(sender)
            
        case PresentStyle.popoverTransition.rawValue:
            self.popoverTransition(sender)
            
        case PresentStyle.presentation.rawValue:
            self.presentationController()
            
        default:
            break
        }
    }
}

extension PresentationViewController {
    
    fileprivate func presentationController() {
        let vc = PresentationDemoViewController.make()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        
        self.present(vc, animated: true)
    }
    
    fileprivate func popoverTransition(_ sender: UIButton) {
        
        let vc = PresentationDemoViewController.make()
        vc.modalPresentationStyle = .custom
        let transition = InnerPopoverTransition(sourceView: sender)
        vc.transitioningDelegate = transition
        
        self.present(vc, animated: true)
    }
    
    fileprivate func popoverPresentationController(_ sender: UIButton) {
        let vc = PresentationDemoViewController.make()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        
        self.present(vc, animated: true)
    }
    
    fileprivate func popoverClearBackgroundPresentationController(_ sender: UIButton) {
        
        let vc = PresentationDemoViewController.make()
        vc.modalPresentationStyle = .custom
        let transition = InnerPopoverClearBackgroundTransition(sourceView: sender)
        transition.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 352)
        vc.transitioningDelegate = transition
        
        self.present(vc, animated: true)
    }
}

extension PresentationViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let screenWidth = UIScreen.main.bounds.width
        let width = 300 * screenWidth / 375
        
        switch presentStyle {
        case .presentation:
            return InnerPresentationController(presentedViewController: presented, presenting: presenting).handleFrame({ (_, _) -> CGRect in
                return  CGRect(x: screenWidth - width, y: 0, width: width, height: UIScreen.main.bounds.height)
            })
        default:
            return InnerPopoverPresentationController(presentedViewController: presented, presenting: presenting).handleFrame({ (_, _) -> CGRect in
                return CGRect(x: 120, y: 100, width: width, height: 230)
            })
        }
        
       
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch presentStyle {
        case .presentation:
            return TransitionAnimators.makeInnerMoveInAnimator(0.3, startRect: CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        default:
            return TransitionAnimators.makeInnerMoveInAnimator(0.3, startRect: CGRect(x: UIScreen.main.bounds.width, y: 5, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        }
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch presentStyle {
        case .presentation:
            return TransitionAnimators.makeInnerMoveOutAnimator(0.3, endRect: CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            
        default:
            return TransitionAnimators.makeInnerMoveOutAnimator(0.3, endRect: CGRect(x: UIScreen.main.bounds.width, y: 5, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        }
    }
}

extension UIStoryboard {
    static let presentation = UIStoryboard(name: "Presentation", bundle: nil)
}
