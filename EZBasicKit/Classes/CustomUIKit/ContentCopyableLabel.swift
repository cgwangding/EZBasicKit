//
//  ContentCopyableLabel.swift
//  ezbuy
//
//  Created by wangding on 2016/12/8.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import UIKit

public class ContentCopyableLabel: UILabel {

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
            menu.setTargetRect(self.bounds, in: self.superview ?? self)
            menu.setMenuVisible(true, animated: false)
        }
    }

    public override func copy(_ sender: Any?) {
        UIPasteboard.general.string = self.text
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
