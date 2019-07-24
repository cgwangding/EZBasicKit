//
//  AnimatorTestViewController.swift
//  EZBasicKit_Example
//
//  Created by wangding on 2019/6/5.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class AnimatorTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension AnimatorDemoTableViewController {

    class func make(title: String) -> UINavigationController {

        let vc = UIStoryboard(name: "Animator", bundle: nil).instantiateViewController(withIdentifier: "AnimatorTestVC")
        vc.modalPresentationStyle = .custom
        vc.title = title
        return UINavigationController(rootViewController: vc)
    }
}
