//
//  EZGradientView.swift
//  ezbuy
//
//  Created by wangding on 2019/1/25.
//  Copyright © 2019 com.ezbuy. All rights reserved.
//

import UIKit

class EZGradientView: UIView {

    var gradientColors: [UIColor] = [] {
        didSet {
            self.gradientLayer.colors = self.gradientColors.map({ $0.cgColor })
        }
    }

    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        return layer
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        if !(self.layer.sublayers?.contains(self.gradientLayer) ?? false) {
            self.layer.addSublayer(self.gradientLayer)
        }
        self.backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if !(self.layer.sublayers?.contains(self.gradientLayer) ?? false) {
            self.layer.addSublayer(self.gradientLayer)
        }
        self.backgroundColor = UIColor.clear
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = self.bounds
    }

}
