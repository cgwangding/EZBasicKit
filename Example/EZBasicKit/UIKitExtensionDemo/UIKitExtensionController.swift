//
//  UIKitExtensionController.swift
//  EZBasicKit_Example
//
//  Created by qiuming on 2019/6/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class UIKitExtensionController: UIViewController {
    
    @IBOutlet weak var hexColorLabel: UILabel!
    
    @IBOutlet weak var randomLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var versionLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

       self.setupColor()
        self.setupDevice()
    }
    
    fileprivate func setupDevice() {
        self.versionLabel.text = "systemVersion" + "  " + UIDevice.ez_systemVersion
    }
    
    fileprivate func setupColor() {
        self.hexColorLabel.textColor = UIColor(0x949494)
        self.randomLabel.textColor = UIColor.random
        self.imageView.image = UIColor.green.createImage(self.imageView.bounds.size)
    }
}
