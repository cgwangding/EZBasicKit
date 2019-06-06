//
//  RoundLabel.swift
//  EZBasicKit
//
//  Created by wangding on 2019/6/5.
//

import UIKit

@IBDesignable
public class RoundLabel: UILabel {

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBInspectable
    public var cornerRadius: CGFloat = 2 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            self.layer.masksToBounds = true
        }
    }

    @IBInspectable
    public var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = self.borderColor?.cgColor
        }
    }

    @IBInspectable
    public var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
}
