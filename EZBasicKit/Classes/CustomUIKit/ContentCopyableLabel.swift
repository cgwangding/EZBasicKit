//
//  ContentCopyableLabel.swift
//  ezbuy
//
//  Created by wangding on 2016/12/8.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import UIKit

public typealias Target = UIView

public class ContentCopyableLabel: UILabel {

    public var customMenuTargetRect: (() -> (CGRect, Target))?

    public var customCopyAction: ((String) -> Void)?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.attachLongPressHandler()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        self.attachLongPressHandler()
    }

    func attachLongPressHandler() {
        self.isUserInteractionEnabled = true
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(makeCustomCopyMenu))
        self.addGestureRecognizer(longPress)
    }

    @objc func makeCustomCopyMenu() {

        let menu = UIMenuController.shared

        if menu.isMenuVisible {
            return
        } else {
            becomeFirstResponder()
            if let (rect, target) = self.customMenuTargetRect?() {
                menu.setTargetRect(rect, in: target)
            } else {
                menu.setTargetRect(self.bounds, in: self)
            }
            menu.setMenuVisible(true, animated: false)
        }
    }

    public override func copy(_ sender: Any?) {
        if let action = self.customCopyAction {
            action(self.text ?? "")
        } else {
            UIPasteboard.general.string = self.text
        }
    }

    public override var canBecomeFirstResponder: Bool {
        return true
    }

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) {
            return true
        } else {
            return super.canPerformAction(action, withSender: sender)
        }
    }
}
