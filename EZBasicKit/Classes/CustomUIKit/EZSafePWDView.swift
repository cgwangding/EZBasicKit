//
//  EZSafePWDView.swift
//  ezbuy
//
//  Created by wangding on 2019/6/13.
//  Copyright © 2019 com.ezbuy. All rights reserved.
//

import UIKit

fileprivate class DotView: UIView {

    let dotWH: CGFloat

    init(frame: CGRect, dotWH: CGFloat) {
        self.dotWH = dotWH
        super.init(frame: frame)
        self.frame = frame
        self.addSubview(self.dotLabel)
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor.white
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        self.dotWH = 0
        super.init(coder: aDecoder)
    }

    var text: String? {
        didSet {
            self.dotLabel.text = self.text
        }
    }

    var isSecureText: Bool = true {
        didSet {

            let w = self.frame.width
            let h = self.frame.height
            if self.isSecureText {
                self.dotLabel.layer.cornerRadius = self.dotWH / 2
                self.dotLabel.layer.masksToBounds = true
                self.dotLabel.backgroundColor = Colors.c333333
                self.dotLabel.frame = CGRect(x: (w - self.dotWH) / 2, y: (h - self.dotWH) / 2, width: self.dotWH, height: self.dotWH)
            } else {
                self.dotLabel.layer.cornerRadius = 0
                self.dotLabel.layer.masksToBounds = false
                self.dotLabel.backgroundColor = UIColor.clear
                self.dotLabel.frame = self.bounds
            }
        }
    }

    var isDotHidden: Bool = true {
        didSet {
            self.dotLabel.isHidden = self.isDotHidden
        }
    }

    lazy var dotLabel: UILabel = {
        let label = UILabel()

        let w = self.frame.width
        let h = self.frame.height
        label.frame = CGRect(x: (w - self.dotWH) / 2, y: (h - self.dotWH) / 2, width: self.dotWH, height: self.dotWH)
        label.text = self.text
        label.layer.cornerRadius = self.dotWH / 2
        label.layer.masksToBounds = true
        label.backgroundColor = Colors.c333333
        label.isHidden = self.isDotHidden
        label.isUserInteractionEnabled = false
        label.textAlignment = .center
        return label
    }()
}

public class NoneActionTextField: UITextField {

    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {

        return false
    }

    public override var canBecomeFirstResponder: Bool {
        return true
    }
}

public class EZSafePWDView: UIView {

    @IBInspectable
    public var pwdCount: Int = 6

    @IBInspectable
    public var borderColor: UIColor = Colors.ccecece {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }

    @IBInspectable
    public var isSecureText: Bool = true {
        didSet {
            self.dotViews.forEach({ $0.isSecureText = self.isSecureText })
        }
    }

    @IBInspectable
    public var shouldShowKeyboard: Bool = true

    public var didPasswordComplete: ((String) -> Void)?
    public var passwordDidChanged: ((String) -> Void)?

    @available(*, unavailable)
    public init(frame: CGRect, pwdCount: Int) {
        self.pwdCount = pwdCount
        super.init(frame: frame)
        self.frame = frame
        self.setupUI()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    lazy var textField: NoneActionTextField = {
        let tf = NoneActionTextField()
        tf.borderStyle = .none
        tf.keyboardType = .numberPad
        tf.clearsOnBeginEditing = false
        tf.delegate = self
        return tf
    }()

    private var dotViews: [DotView] = []

    public override var frame: CGRect {
        didSet {
            self.setupUI()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.setupUI()
    }

    public override func awakeFromNib() {
        super.awakeFromNib()

        self.textField.frame = self.bounds
        self.addSubview(self.textField)

        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChangedNotification(_:)), name: UITextField.textDidChangeNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupUI() {

        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = 1

        self.subviews.filter({ !$0.isMember(of: NoneActionTextField.self) }).forEach({ $0.removeFromSuperview() })
        self.dotViews.removeAll()

        let h = self.frame.height

        for i in 0..<self.pwdCount {
            let dotView = DotView(frame: CGRect(x: h * CGFloat(i) + CGFloat(i), y: 0, width: h, height: h), dotWH: 8)
            self.dotViews.append(dotView)
            self.addSubview(dotView)

            self.bringSubviewToFront(dotView)

            let lineView = UIView()
            lineView.backgroundColor = Colors.ceeeeee
            lineView.frame = CGRect(x: dotView.frame.maxX, y: 3, width: 1, height: h - 6)
            self.addSubview(lineView)
        }
    }

    @objc func textFieldDidChangedNotification(_ notifi: Notification) {
        guard let textField = notifi.object as? NoneActionTextField, textField == self.textField else { return }
        self.passwordDidChanged?(textField.text ?? "")
        if let password = textField.text, password.count == 6 {
            self.didPasswordComplete?(password)
        }
    }
}

extension EZSafePWDView: UITextFieldDelegate {

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard Int(string) != nil || string.isEmpty else {
            return false
        }

        let text = textField.text ?? ""
        

        let start = text.index(text.startIndex, offsetBy: range.lowerBound)
        let end = text.index(text.startIndex, offsetBy: range.upperBound)

        debugPrint(range.lowerBound, range.upperBound)

        let currentText = text.replacingCharacters(in: start..<end, with: string)

        debugPrint(string, currentText)

        guard currentText.count <= self.pwdCount else {

            return false
        }

        debugPrint(currentText)

        for (index, v) in self.dotViews.enumerated() {
            v.isDotHidden = index >= currentText.count
            v.isSecureText = self.isSecureText
        }

        for (text, v) in zip(currentText, self.dotViews) {
            v.text = String(text)
        }

        return true
    }
}
