//
//  TextFieldHelperDemo.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/6/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class TextFieldHelperView: UIView, UITextFieldDelegate {

    lazy var textField: UITextField = {
        let field = UITextField(frame: self.bounds)
        field.delegate = self
        return field
    }()
    
    var inputValueItem: String? {
        didSet {
            self.updateCellWithCurrentItem()
        }
    }
    
    let chinaPhoneNumberHelper = PhoneNumberTextFieldHelper(lengthLimit: 11, decorators: nil, tolerancePrefix: "86")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //add editing selector to textField in the init method of textField's superview or drag an action from xib or storybard
        textField.addTarget(self, action: #selector(textFieldValueDidChange(sender:)), for: .editingChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textField.addTarget(self, action: #selector(textFieldValueDidChange(sender:)), for: .editingChanged)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.addTarget(self, action: #selector(textFieldValueDidChange(sender:)), for: .editingChanged)
    }
    
    func updateCellWithCurrentItem() {
        if let item = self.inputValueItem {
            self.textField.text = item
        } else {
            self.textField.text = nil
        }
    }
    
    @objc func textFieldValueDidChange(sender: UITextField) {
        self.inputValueItem = self.chinaPhoneNumberHelper.adjustedTextFromTextField(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.chinaPhoneNumberHelper.textField(textField, shouldChangeCharactersIn: range, replacementString: string) 
    }
}
