//
//  RoundButton.swift
//  ezbuy
//
//  Created by Rocke on 16/6/7.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import UIKit

@IBDesignable
public class RoundButton: UIButton {

    override public func awakeFromNib() {
        super.awakeFromNib()

        let layer = self.layer

        layer.cornerRadius = self.cornerRadius

        layer.masksToBounds = true
    }

    @IBInspectable
    public var cornerRadius: CGFloat = 2

    @IBInspectable
    public var borderColor: UIColor? {
        get {
            if let color = self.layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }

        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        self.layer.borderWidth = (self.isEnabled ? 1.0 : 0.0)
    }
}
