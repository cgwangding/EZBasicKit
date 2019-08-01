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
    
    @IBInspectable
    public var cornerRadius: CGFloat = 2 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            self.layer.masksToBounds = true
        }
    }

    @IBInspectable
    public var borderColor: UIColor? = UIColor.clear  {
        didSet {
             self.layer.borderColor = self.borderColor?.cgColor
        }
    }

    @IBInspectable
    public var borderWidth: CGFloat = 1.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.cornerRadius
        self.layer.masksToBounds = true
        self.layer.borderColor = self.borderColor?.cgColor
        self.layer.borderWidth = self.borderWidth
    }
}
