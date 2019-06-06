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

    public enum RectEdge: Int {
        case left = 0
        case right
        case bottom
        case top
        case all
    }

    @IBInspectable
    open var lineWidth: CGFloat = 1.0

    @IBInspectable
    open var lineColor: UIColor?

    open var rectEdge: Set<RectEdge> = [.all]

    open var lineDashPattern: [NSNumber] = [6, 2]

    lazy var borderLayer: CAShapeLayer = {

        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = self.lineColor?.cgColor
        shapeLayer.fillColor = nil
        shapeLayer.lineWidth = self.lineWidth
        shapeLayer.lineDashPattern = self.lineDashPattern
        self.layer.addSublayer(shapeLayer)
        return shapeLayer

    }()

    var strokePath: UIBezierPath {

        let p = UIBezierPath()

        let halfWidth: CGFloat = self.lineWidth / 2.0

        if self.rectEdge.contains(.all) {
            p.move(to: CGPoint(x: bounds.origin.x, y: bounds.origin.y + halfWidth))
            p.addLine(to: CGPoint(x: bounds.size.width - halfWidth, y: bounds.origin.y + halfWidth))
            p.addLine(to: CGPoint(x: bounds.size.width - halfWidth, y: bounds.size.height - halfWidth))
            p.addLine(to: CGPoint(x: bounds.origin.x + halfWidth, y: bounds.size.height - halfWidth))
            p.addLine(to: CGPoint(x: bounds.origin.x + halfWidth, y: bounds.origin.y))
        }

        if self.rectEdge.contains(.left) {
            p.move(to: CGPoint(x: bounds.origin.x, y: bounds.origin.y + halfWidth))
            p.addLine(to: CGPoint(x: bounds.origin.x, y: bounds.size.height))
        }

        if self.rectEdge.contains(.top) {
            p.move(to: CGPoint(x: bounds.origin.x, y: bounds.origin.y + halfWidth))
            p.addLine(to: CGPoint(x: bounds.size.width - halfWidth, y: bounds.origin.y + halfWidth))
        }

        if self.rectEdge.contains(.right) {
            p.move(to: CGPoint(x: bounds.size.width - halfWidth, y: bounds.origin.y + halfWidth))
            p.addLine(to: CGPoint(x: bounds.size.width - halfWidth, y: bounds.size.height - halfWidth))
        }

        if self.rectEdge.contains(.bottom) {
            p.move(to: CGPoint(x: bounds.origin.x, y: bounds.size.height - halfWidth))
            p.addLine(to: CGPoint(x: bounds.size.width - halfWidth, y: bounds.size.height - halfWidth))
        }

        return p
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        let layer = self.layer
        let bounds = self.bounds

        let borderLayer = self.borderLayer
        borderLayer.frame = layer.bounds
        borderLayer.path = self.strokePath.cgPath

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
