//
//  TextFieldHelperDemo.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/6/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class TextFieldHelperViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    var inputValueItem: String?
    
    let chinaPhoneNumberHelper = PhoneNumberTextFieldHelper(lengthLimit: 11, decorators: nil, tolerancePrefix: "+86")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.addTarget(self, action: #selector(textFieldValueDidChange(sender:)), for: .editingChanged)
        textField.delegate = chinaPhoneNumberHelper
    }
    
    @objc func textFieldValueDidChange(sender: UITextField) {
        self.inputValueItem = self.chinaPhoneNumberHelper.adjustedTextFromTextField(sender)
        print(self.inputValueItem ?? "")
    }
}
