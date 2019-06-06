//
//  TextField.swift
//  ezbuy
//
//  Created by admin on 2017/10/26.
//  Copyright © 2017年 com.ezbuy. All rights reserved.
//

import UIKit

@IBDesignable
public class EZTextField : UITextField {

    @IBInspectable public var borderColor : UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable public var borderWidth : CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable public var left : CGFloat = 0

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: left, dy: 0)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: left, dy: 0)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: left, dy: 0)
    }
}
