//
//  RoundLabel.swift
//  EZBasicKit
//
//  Created by wangding on 2019/6/5.
//

import UIKit

@IBDesignable
class RoundedBorderLabel: UILabel {
    
    @IBInspectable var topPadding: CGFloat = 0
    @IBInspectable var bottomPadding: CGFloat = 0
    @IBInspectable var leftPadding: CGFloat = 6
    @IBInspectable var rightPadding: CGFloat = 6
    
    override var textColor: UIColor! {
        didSet{
            self.layer.borderColor = self.textColor.cgColor
        }
    }
    
    override var font: UIFont!{
        didSet {
            let height = "aa".caculateHeight(withFontSize: Int(self.font?.pointSize ?? 0.0))
            self.layer.cornerRadius = (height + topPadding + bottomPadding) * 0.5
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        self.layer.borderWidth = 1
        self.layer.borderColor = textColor.cgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.height * 0.5
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        
        let size = super.intrinsicContentSize
        let newH = size.height + topPadding + bottomPadding
        let newW = size.width + leftPadding + rightPadding
        
        return CGSize(width: newW, height: newH)
    }
}
