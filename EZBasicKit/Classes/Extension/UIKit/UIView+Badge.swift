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
                badgeView.isHidden = !newValue
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
            self.textBadgeLabel?.center = CGPoint(x: self.bounds.width, y: 0)
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
}
