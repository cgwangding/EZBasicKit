//
//  EZSafePWDViewDemo.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class EZSafePWDViewDemo: UIViewController {

    @IBOutlet weak var safePWDView: EZSafePWDView!
    
    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safePWDView.textField.becomeFirstResponder()
        
        safePWDView.didPasswordComplete = { (password) in
            self.password = password
            print(self.password)
        }
        
        safePWDView.passwordDidChanged = { (password) in
            //do something
        }
    }
}
