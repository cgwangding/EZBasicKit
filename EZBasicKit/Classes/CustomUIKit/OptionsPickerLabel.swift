//
//  OptionsPickerLabel.swift
//  ezbuy
//
//  Created by Arror on 2017/3/10.
//  Copyright © 2017年 com.ezbuy. All rights reserved.
//

import UIKit

public final class OptionsPickerLabel: UILabel {
    
    public let textField = OptionsPickerTextField(frame: .zero)
    
    public var confirm: ((String) -> Void)? {
        set {
            self.textField.confirm = newValue
        }
        get {
            return self.textField.confirm
        }
    }
    public var cancel: (() -> Void)? {
        set {
            self.textField.cancel = newValue
        }
        get {
            return self.textField.cancel
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }


    public override func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    public override var text: String? {
        didSet {
            self.textField.text = self.text
        }
    }
    
    private func initialize() {
        self.isUserInteractionEnabled = true
        self.textField.isHidden = true
        self.textField.addTarget(self, action: #selector(OptionsPickerLabel.textFieldEditingChanged(_:)), for: .editingChanged)
        self.addSubview(self.textField)
        self.text = self.textField.text
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(OptionsPickerLabel.labelTapped(_:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc func labelTapped(_ tap: UITapGestureRecognizer) {
        self.showOptionsPicker()
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        self.text = textField.text
    }
    
    public func showOptionsPicker() {
        guard !options.isEmpty else { return }
        self.textField.becomeFirstResponder()
    }
    
    public func resignOptionsPicker() {
        self.textField.resignFirstResponder()
    }
    
    public var options: [String] {
        get {
            return self.textField.options
        }
        set {
            self.textField.options = newValue
        }
    }
}


public class OptionsPickerTextField: UITextField, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let toolBar = UIToolbar()
    let pickView = UIPickerView()
    
    public var confirm: ((String) -> Void)?
    public var cancel: (() -> Void)?
    
    public var options: [String] = [] {
        didSet {
            self.pickView.reloadAllComponents()
            self.updateSelection()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        
        self.toolBar.frame = CGRect(x: 0, y: 0, width: 0, height: 44)
        self.toolBar.items = {
            
            let leftBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(OptionsPickerTextField.cancelButtonTapped(_:)))
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let rightBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(OptionsPickerTextField.doneButtonTapped(_:)))
            return [leftBtn, space, rightBtn]
        }()

        toolBar.backgroundColor = UIColor(red: 237, green: 237, blue: 237, alpha: 1)
        
        self.pickView.backgroundColor = UIColor.white
        self.pickView.delegate = self
        self.pickView.dataSource = self
        
        self.inputAccessoryView = self.toolBar
        self.inputView = self.pickView
        self.delegate = self
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.options.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.options[row]
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.updateSelection()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = self.text else { return }
        if !self.options.contains(text) { self.text = nil; return }
    }
    
    @objc func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.resignFirstResponder()
        self.cancel?()
    }
    
    @objc func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.resignFirstResponder()
        let index = self.pickView.selectedRow(inComponent: 0)
        self.text = self.options.object(at: index)
        self.confirm?(text ?? "")
        self.sendActions(for: .editingChanged)
    }
    
    private func updateSelection() {
        
        guard !self.options.isEmpty else { return }
        
        let index: Int = {
            if let text = self.text, let index = self.options.firstIndex(of: text) {
                return index
            } else {
                return 0
            }
        }()
        
        self.pickView.selectRow(index, inComponent: 0, animated: false)
    }
}
