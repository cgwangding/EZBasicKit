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
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.cornerRadius
        self.layer.masksToBounds = true
        self.layer.borderColor = self.borderColor?.cgColor
        self.layer.borderWidth = self.borderWidth
    }
}
