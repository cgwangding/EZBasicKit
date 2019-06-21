//
//  UIControlExtensionController.swift
//  EZBasicKit_Example
//
//  Created by qiuming on 2019/6/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class UIControlExtensionController: UIViewController {
    
    @IBOutlet weak var intervalButton: UIButton!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var enlargeInsetBtn: UIButton!

    fileprivate var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTimeIntervalButton()
        setupEnlargeInsetBtn()
    }
    
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
