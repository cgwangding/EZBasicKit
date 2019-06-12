//
//  UIKitExtensionDemoViewController.swift
//  EZBasicKit_Example
//
//  Created by qiuming on 2019/6/12.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class UIKitExtensionDemoViewController: UIViewController {
    
    @IBOutlet weak var intervalButton: UIButton!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var enlargeInsetBtn: UIButton!
    
    @IBOutlet weak var hexColorLabel: UILabel!
    
    @IBOutlet weak var randomLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    
    fileprivate var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTimeIntervalButton()
        self.setupEnlargeInsetBtn()
        self.setupColor()
        self.setupImage()
    }
}

extension UIKitExtensionDemoViewController {
    fileprivate func setupImage() {
        
    }
}

// UIColor+Hex
extension UIKitExtensionDemoViewController {
    
    fileprivate func setupColor() {
        self.hexColorLabel.textColor = UIColor(0x949494)
        self.randomLabel.textColor = UIColor().random
        self.imageView.image = UIColor.green.createImage(self.imageView.bounds.size)
    }
}

// UIButton+Extension
extension UIKitExtensionDemoViewController {
    
    // 扩大点击区域
    fileprivate func setupEnlargeInsetBtn() {
        enlargeInsetBtn.ez_enlargeInst = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    // 防重复多次点击
    fileprivate func setupTimeIntervalButton() {
        intervalButton.ez_acceptEventInterval = 2.0
        intervalButton.addTarget(self, action: #selector(timeIntervalBtnTapped), for: .touchUpInside)
    }
    
    @objc func timeIntervalBtnTapped() {
        currentIndex += 1
        self.countLabel.text = "当前点击\(currentIndex)次"
    }
}
