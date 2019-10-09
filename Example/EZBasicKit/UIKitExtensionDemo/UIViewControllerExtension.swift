//
//  UIViewControllerExtensionController.swift
//  EZBasicKit_Example
//
//  Created by qiuming on 2019/6/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

enum alertStyle: Int {
    case defalut = 2001
    case alert   = 2002
    case autoDismiss = 2003
}


class UIViewControllerExtension: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    /// UIViewController + Extension
    @IBAction func alertStyleButtonTapped(_ sender: UIButton) {
        
//        let title = "topMostViewController" + "\(self.topMostViewController)"
//        
//        switch sender.tag {
//            
//        case alertStyle.defalut.rawValue:
//            self.presentAlert(title: title, message: "default") { (alert) in
//                let ignoreAction = UIAlertAction(title: "Ignore", style: .default, handler: nil)
//                alert.addAction(ignoreAction)
//                
//                let viewAction = UIAlertAction(title: "View", style: .default, handler: nil)
//                alert.addAction(viewAction)
//            }
//            
//        case alertStyle.alert.rawValue:
//            self.presentAlert(title: title, message: "alert", buttontitle: "OK")
//            
//        case alertStyle.autoDismiss.rawValue:
//            self.presentAutoDismissAlert(message: "autoDissmiss", delay: 2, finished: nil)
//            
//        default: break
//        }
    }
    

}
