//
//  UIView+Badge.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/28.
//

import Foundation

extension UIView {

    public var isBadgeShown: Bool {
        get {
            return self.badgeView?.isHidden ?? false
        }
        set {

            if let badgeView = self.badgeView {
                badgeView.isShown = newValue
            } else {
                if newValue == true {
                    let v = BadgeView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
                    v.tag = self.badgeTag
                    v.backgroundColor = UIColor(red: 255.0 / 255.0, green: 90.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
                    v.center = CGPoint(x: self.bounds.size.width, y: 0)
                    self.addSubview(v)
                }
            }
        }
    }

    fileprivate var badgeTag: Int { return 999 }

    fileprivate var badgeView: UIView? {
        return self.viewWithTag(self.badgeTag)
    }
}

class BadgeView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()

        let layer = self.layer
        layer.cornerRadius = min(self.bounds.size.width, self.bounds.size.height) / 2.0
        layer.masksToBounds = true
    }
}

/************Text Badge**************/
extension UIView {

    /*
     * hidden when text is empty
     */
    public var badgeText: String {

        get {
            return self.textBadgeLabel?.text ?? ""
        }

        set {

            if let label = self.textBadgeLabel {
                label.text = newValue
            } else {
                let label = UILabel()
                label.text = newValue
                label.textAlignment = .center
                label.textColor = UIColor.white
                label.font = UIFont.systemFont(ofSize: 16.0)
                label.backgroundColor = UIColor(red: 255.0 / 255.0, green: 90.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
                label.tag = self.textBadgeTag
                self.addSubview(label)
            }
            self.textBadgeLabel?.font = UIFont.systemFont(ofSize: 16.0)
            let size = self.textBadgeLabel?.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)) ?? CGSize.zero
            self.textBadgeLabel?.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: size.width > 14 ? size.width + 8 : 14, height: 14))
            self.textBadgeLabel?.center = CGPoint(x: self.bounds.width + 8, y: 0)
            self.textBadgeLabel?.isHidden = newValue.isEmpty
            self.textBadgeLabel?.font = UIFont.systemFont(ofSize: 13.0)
            self.textBadgeLabel?.layer.cornerRadius = 7
            self.textBadgeLabel?.layer.masksToBounds = true
        }
    }

    private var textBadgeTag: Int { return 199 }

    private var textBadgeLabel: UILabel? {
        return self.viewWithTag(self.textBadgeTag) as? UILabel
    }
    
    public var cartQTYbadgeText: String {
        
        get {
            return self.cartQTYbadgeLabel?.text ?? ""
        }
        
        set {
            
            if let label = self.cartQTYbadgeLabel {
                label.text = newValue
            } else {
                let label = EZBadgeLabel()
                label.text = newValue
                label.tag = self.cartQTYbadgeTag
                self.addSubview(label)
            }
            let size = self.cartQTYbadgeLabel?.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)) ?? CGSize.zero
            let horizontalMargin = (self.cartQTYbadgeLabel?.leftPadding ?? 0.0) + (self.cartQTYbadgeLabel?.rightPadding ?? 0.0)
            let verticalMargin = (self.cartQTYbadgeLabel?.topPadding ?? 0.0) + (self.cartQTYbadgeLabel?.bottomPadding ?? 0.0)
            let labelWidth = size.width + horizontalMargin
            let labelHeight = size.height + verticalMargin
            self.cartQTYbadgeLabel?.frame = CGRect(origin: CGPoint(x: self.bounds.width - 10, y: 8 - labelHeight), size: CGSize(width: labelWidth > labelHeight ? labelWidth :  labelHeight, height: labelHeight))
            self.cartQTYbadgeLabel?.isHidden = newValue.isEmpty
        }
    }
    
    private var cartQTYbadgeTag: Int { return 999 }
    
    private var cartQTYbadgeLabel: EZBadgeLabel? {
        return self.viewWithTag(self.cartQTYbadgeTag) as? EZBadgeLabel
    }
}

public class EZBadgeLabel: RoundedBorderLabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        self.topPadding = 2
        self.bottomPadding = 2
        self.leftPadding = 3
        self.rightPadding = 3
        self.layer.borderColor = UIColor.white.cgColor
        
        self.textAlignment = .center
        self.textColor = .white
        self.font = UIFont.systemFont(ofSize: 9.0)
        self.backgroundColor = UIColor(red: 255.0 / 255.0, green: 90.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
}
