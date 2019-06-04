//
//  StrokeBorderView.swift
//  ezbuy
//
//  Created by wangding on 16/5/26.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import UIKit

@IBDesignable
open class StrokeBorderView: UIView {

    @IBInspectable
    open var lineWidth: CGFloat = 1.0

    @IBInspectable
    open var lineColor: UIColor?

    lazy var borderLayer: CAShapeLayer = {

        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = self.lineColor?.cgColor
        shapeLayer.fillColor = nil
        shapeLayer.lineWidth = self.lineWidth
        shapeLayer.lineDashPattern = [6, 2]

        self.layer.addSublayer(shapeLayer)
        return shapeLayer

    }()

    override open func layoutSubviews() {
        super.layoutSubviews()

        let layer = self.layer
        let bounds = self.bounds

        let path: UIBezierPath = {

            let p = UIBezierPath()

            let halfWidth: CGFloat = self.lineWidth / 2.0

            p.move(to: CGPoint(x: bounds.origin.x, y: bounds.origin.y + halfWidth))
            p.addLine(to: CGPoint(x: bounds.size.width - halfWidth, y: bounds.origin.y + halfWidth))
            p.addLine(to: CGPoint(x: bounds.size.width - halfWidth, y: bounds.size.height - halfWidth))
            p.addLine(to: CGPoint(x: bounds.origin.x, y: bounds.size.height - halfWidth))

            return p
        }()

        let borderLayer = self.borderLayer
        borderLayer.frame = layer.bounds
        borderLayer.path = path.cgPath

    }
}

@IBDesignable
open class DottedLineView: UIView {
    
    @IBInspectable
    open var lineWidth: CGFloat = 1.0
    
    @IBInspectable
    open var lineColor: UIColor = UIColor.black
    
    lazy var borderLayer: CAShapeLayer = {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = self.lineColor.cgColor
        shapeLayer.fillColor = nil
        shapeLayer.lineWidth = self.lineWidth
        shapeLayer.lineDashPattern = [6, 2]
        
        self.layer.addSublayer(shapeLayer)
        return shapeLayer
        
    }()
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        let bounds = self.bounds
        
        let path: UIBezierPath = {
            
            let p = UIBezierPath()
            
            let halfWidth: CGFloat = self.lineWidth / 2.0
            
            p.move(to: CGPoint(x: bounds.origin.x, y: bounds.height - halfWidth))
            p.addLine(to: CGPoint(x: bounds.width, y: bounds.height - halfWidth))
            
            return p
        }()
        
        let borderLayer = self.borderLayer
        borderLayer.frame = layer.bounds
        borderLayer.path = path.cgPath
    }
}
