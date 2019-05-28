//
//  EZNavigationController.swift
//  ezbuyUIKit
//
//  Created by 张鹏 on 2018/2/6.
//  Copyright © 2018年 com.ezbuy. All rights reserved.
//

import UIKit

class EZNavigationControllerAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    var operation: UINavigationController.Operation?
    weak var navigationController: EZNavigationController?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVc = transitionContext.viewController(forKey: .from),
            let toVc = transitionContext.viewController(forKey: .to),
            let toView = transitionContext.view(forKey: .to),
            let operation = self.operation,
            let navigationController = self.navigationController else {
                return
        }
        
        let fromVcImageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        let image = navigationController.screenSnapshot()
        fromVcImageView.image = image
        
        fromVcImageView.layer.shadowColor = UIColor.black.cgColor
        fromVcImageView.layer.shadowOffset = CGSize(width: 0.8, height: 0)
        fromVcImageView.layer.shadowOpacity = 0.6
        
        var fromViewEndFrame = transitionContext.finalFrame(for: fromVc)
        fromViewEndFrame.origin.x = UIScreen.main.bounds.width
        
        var fromViewStartFrame = fromViewEndFrame
        
        let toViewEndFrame = transitionContext.finalFrame(for: toVc)
        let toViewStartFrame = toViewEndFrame
        
        switch operation {
        case .push:
            
            transitionContext.containerView.addSubview(toView)
            toView.frame = toViewStartFrame
            
            navigationController.view.window?.addSubview(fromVcImageView)
            
            navigationController.view.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                
                navigationController.view.transform = CGAffineTransform.identity
                fromVcImageView.center = CGPoint(x: -UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.5)
                
            }, completion: { (finished) in

                fromVcImageView.removeFromSuperview()
                transitionContext.completeTransition(finished)
            })
            
        case .pop:
            
            fromViewStartFrame.origin.x = 0
            transitionContext.containerView.addSubview(toView)
            toView.frame = toViewStartFrame
            
            let toVcImageView = UIImageView(frame: CGRect(x: -UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            toVcImageView.image = navigationController.mapping[toVc.hashValue]
            
            navigationController.view.window?.addSubview(toVcImageView)
            navigationController.view.window?.addSubview(fromVcImageView)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                
                fromVcImageView.center = CGPoint(x: UIScreen.main.bounds.width * 3 * 0.5, y: UIScreen.main.bounds.height * 0.5)
                toVcImageView.center = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.5)
                
            }, completion: { (finished) in
                
                toVcImageView.removeFromSuperview()
                fromVcImageView.removeFromSuperview()
                transitionContext.completeTransition(finished)
                navigationController.mapping.removeValue(forKey: toVc.hashValue)
            })
            
        default:
            break
        }
    }
}

public class EZNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    lazy var overlayImageView: UIImageView = UIImageView()
    lazy var overlayView: UIView = UIView()
    
    var mapping: [Int: UIImage] = [:]
    
    var edgePan: UIScreenEdgePanGestureRecognizer?
    
    let transitioning = EZNavigationControllerAnimatedTransitioning()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: -0.8, height: 0)
        view.layer.shadowOpacity = 0.6
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(EZNavigationController.edgePanGestureRecognizer(edgePan:)))
        edgePan.edges = .left
        self.edgePan = edgePan
        
        view.addGestureRecognizer(edgePan)
        
        overlayImageView.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        overlayView.frame = overlayImageView.frame
        overlayView.backgroundColor = UIColor.black
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.transitioning.navigationController = self
        self.transitioning.operation = operation
        
        return self.transitioning
    }

    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
    
    @objc func edgePanGestureRecognizer(edgePan: UIScreenEdgePanGestureRecognizer) {
        
        let count = self.viewControllers.count
        
        guard let fromVc = self.viewControllers.object(at: count - 1),
            let toVc = self.viewControllers.object(at: count - 2),
            self.visibleViewController != self.viewControllers.first else { return }

        switch edgePan.state {
        case .began:
            begin(to: toVc)
            
        case .cancelled, .failed, .ended, .possible:
            end(with: edgePan, from: fromVc, to: toVc)
            
        case .changed:
            changed(edgePan: edgePan)
        }
    }
    
    fileprivate func begin(to viewController: UIViewController) {
        
        self.view.window?.insertSubview(self.overlayImageView, at: 0)
        self.view.window?.insertSubview(self.overlayView, aboveSubview: overlayImageView)
        
        overlayImageView.image = mapping[viewController.hashValue]
    }
    
    fileprivate func changed(edgePan: UIScreenEdgePanGestureRecognizer) {
        
        let offsetX = edgePan.translation(in: self.view).x
        
        if offsetX > 0 {
            self.view.transform = CGAffineTransform(translationX: offsetX, y: 0)
        }
        
        let currentTranslateScaleX = offsetX / self.view.frame.width
        
        if offsetX < UIScreen.main.bounds.width {
            let x = (offsetX - UIScreen.main.bounds.width) * 0.6
            overlayImageView.transform = CGAffineTransform.init(translationX: x, y: 0)
        }
        
        let alpha = 0.6 - (currentTranslateScaleX / 0.75) * 0.6
        overlayView.alpha = alpha
    }
    
    fileprivate func end(with edgePan: UIScreenEdgePanGestureRecognizer, from fromViewController: UIViewController, to toViewController: UIViewController) {
        
        let width = self.view.frame.size.width
        let velocity = edgePan.velocity(in: fromViewController.view)
        let magnitude = sqrt(velocity.x * velocity.x + velocity.y * velocity.y)
        
        let slideMult = magnitude / 200
        let slideFactor = 0.1 * slideMult;
        
        let translationPoint = edgePan.translation(in: fromViewController.view)
        
        var finalPoint = CGPoint(x: translationPoint.x + (velocity.x * slideFactor),
                                 y: translationPoint.y + (velocity.y * slideFactor))
        
        finalPoint.x = min(max(finalPoint.x, 0), fromViewController.view.bounds.width)
        let fraction = finalPoint.x / fromViewController.view.bounds.width
        
        if fraction > 0.5 {
            
            UIView.animate(withDuration: 0.2, animations: {
                
                self.view.transform = CGAffineTransform(translationX: width, y: 0)
                self.overlayImageView.transform = CGAffineTransform.init(translationX: 0, y: 0)
                self.overlayView.alpha = 0
                
            }, completion: { (finished) in
                self.view.transform = CGAffineTransform.identity
                self.overlayImageView.removeFromSuperview()
                self.overlayView.removeFromSuperview()
                
                _ = self.popViewController(animated: false)
                
                self.mapping.removeValue(forKey: toViewController.hashValue)
            })
            
        } else {
            
            UIView.animate(withDuration: 0.1, animations: {
                
                self.view.transform = CGAffineTransform.identity
                self.overlayImageView.transform = CGAffineTransform.init(translationX: -UIScreen.main.bounds.width, y: 0)
                self.overlayView.alpha = 0.6
                
            }, completion: { (finished) in
                
                self.overlayImageView.removeFromSuperview()
                self.overlayView.removeFromSuperview()
            })
        }
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        let count = self.viewControllers.count
        if let image = self.screenSnapshot(), let vc = self.viewControllers.object(at: count - 1) {
            mapping[vc.hashValue] = image
        }
        debugPrint("Push", mapping)
        super.pushViewController(viewController, animated: animated)
    }
    
    override public func popViewController(animated: Bool) -> UIViewController? {
        
        return super.popViewController(animated: animated)
    }
    
    override public func popToRootViewController(animated: Bool) -> [UIViewController]? {
        
        return super.popToRootViewController(animated: animated)
    }
    
    override public func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        
        
        return super.popToViewController(viewController, animated: animated)
    }
    
}

extension EZNavigationController {
    
    fileprivate func screenSnapshot() -> UIImage? {
        
        guard let vc = self.view.window?.rootViewController else { return nil }
        
        let size = vc.view.frame.size
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        let rect = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        if self.tabBarController == vc {
            vc.view.drawHierarchy(in: rect, afterScreenUpdates: false)
        } else {
            self.view.drawHierarchy(in: rect, afterScreenUpdates: false)
        }
        
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return snapshot
    }
}

internal extension String {

    func caculateHeight(withFontSize fontSize: Int, width: CGFloat) -> CGFloat {
        let stringOC: NSString = self as NSString
        if !stringOC.isEqual(to: "") {
            return stringOC.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(fontSize))], context: nil).height
        } else {
            return CGRect.zero.height
        }
    }
}
