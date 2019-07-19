//
//  EZGradientView.swift
//  ezbuy
//
//  Created by wangding on 2019/1/25.
//  Copyright © 2019 com.ezbuy. All rights reserved.
//

import UIKit

public class EZGradientView: UIView {

    public var gradientColors: [UIColor] = [] {
        didSet {
            self.gradientLayer.colors = self.gradientColors.map({ $0.cgColor })
        }
    }

    public lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        return layer
    }()
    
    public var startPoint: CGPoint? {
        didSet {
            gradientLayer.startPoint = self.startPoint ?? CGPoint(x: 0.5, y: 0)
        }
    }
    
    public var endPoint: CGPoint? {
        didSet {
            gradientLayer.endPoint = self.endPoint ?? CGPoint(x: 0.5, y: 1)
        }
    }
    
    public var locations: [NSNumber]? {
        didSet {
            gradientLayer.locations = self.locations
        }
    }
    
    public var type: CAGradientLayerType = .axial {
        didSet {
            gradientLayer.type = self.type
        }
    }


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
