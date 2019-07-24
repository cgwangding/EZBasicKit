//
//  UIViewController+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/28.
//

import Foundation

extension UIViewController {

    @objc public var topMostViewController: UIViewController {

        if let presented = self.presentedViewController {
            return presented.topMostViewController
        } else {
            return self
        }
    }
}

extension UIViewController {

    @objc public func presentAlert(title: String?, message: String?, buttontitle: String, action: ((UIAlertAction) -> Void)? = nil) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: buttontitle, style: .default, handler: action))

        self.topMostViewController.present(alertController, animated: true, completion: nil)
    }

    @objc public func presentAlert(title: String?, message: String?, config: (UIAlertController) -> Void) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        config(alertController)

        self.topMostViewController.present(alertController, animated: true, completion: nil)
    }

    @objc(presentAutoDismissAlert:delay:finished:)
    public func presentAutoDismissAlert(message: String, delay: Double, finished: (() -> Void)?) {

        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        self.topMostViewController.present(alertController, animated: true) { () -> Void in

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in

                alertController.dismiss(animated: true, completion: finished)
            }
        }
    }
}

extension UIAlertController {
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        fixupLayout()
    }

    private func fixupLayout() {

        guard let superview = view.superview, let window = view.window else {
            return
        }

        let myRect = view.bounds
        let windowRect = view.convert(myRect, to: nil)

        guard !(window.bounds.contains(windowRect)) || windowRect.origin.equalTo(CGPoint.zero) else {
            return
        }

        if preferredStyle == .alert {
            let myCenter = superview.convert(window.center, from: nil)
            view.center = myCenter

        } else if preferredStyle == .actionSheet && self.traitCollection.userInterfaceIdiom == .phone {

            let screen = window.screen
            let borderPadding = ((screen.nativeBounds.width / screen.nativeScale) - myRect.size.width) / 2.0
            var myFrame = view.frame
            let superBounds = superview.bounds
            myFrame.origin.x = superBounds.maxX - myFrame.width / 2
            myFrame.origin.y = superBounds.height - myFrame.height - borderPadding
            self.view.frame = myFrame
        }
    }
}
