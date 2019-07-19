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
    
    @IBInspectable
    public var startPoint: CGPoint = CGPoint(x: 0.5, y: 0) {
        didSet {
            gradientLayer.startPoint = self.startPoint
        }
    }
    
    @IBInspectable
    public var endPoint: CGPoint = CGPoint(x: 0.5, y: 1) {
        didSet {
            gradientLayer.endPoint = self.endPoint
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

    override public func awakeFromNib() {
        super.awakeFromNib()
        if !(self.layer.sublayers?.contains(self.gradientLayer) ?? false) {
            self.layer.addSublayer(self.gradientLayer)
        }
        self.backgroundColor = UIColor.clear
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if !(self.layer.sublayers?.contains(self.gradientLayer) ?? false) {
            self.layer.addSublayer(self.gradientLayer)
        }
        self.backgroundColor = UIColor.clear
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = self.bounds
    }

}
