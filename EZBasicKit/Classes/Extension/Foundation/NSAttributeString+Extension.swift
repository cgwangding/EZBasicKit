//
//  NSAttributeString+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/24.
//

import Foundation

extension NSMutableAttributedString {

    public func setAttributes(_ attributes: [NSAttributedString.Key: Any]?, regexPattern: String, options: NSRegularExpression.Options = []) {

        guard let regex = try? NSRegularExpression(pattern: regexPattern, options: options) else { return }

        let str = self.string
        let results = regex.matches(in: str, options: [], range: NSRange(location: 0, length: str.utf16.count))

        for r in results {
            self.setAttributes(attributes, range: r.range)
        }
    }

    public func addAttribute(_ name: String, value: Any, regexPattern: String, options: NSRegularExpression.Options = []) {

        guard let regex = try? NSRegularExpression(pattern: regexPattern, options: options) else { return }

        let str = self.string
        let results = regex.matches(in: str, options: [], range: NSRange(location: 0, length: str.utf16.count))

        for r in results {
            self.addAttribute(NSAttributedString.Key(rawValue: name), value: value, range: r.range)
        }
    }
}

extension NSAttributedString {

    var mutableAttributedString: NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self)
    }

    public func setFont(_ font: UIFont) -> NSAttributedString {

        let muAttr = self.mutableAttributedString
        muAttr.addAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: self.length))
        return muAttr
    }

    public func setColor(_ color: UIColor) -> NSAttributedString {

        let muAttr = self.mutableAttributedString
        muAttr.addAttributes([NSAttributedString.Key.foregroundColor: color], range: NSRange(location: 0, length: self.length))
        return muAttr
    }

    public func asALink(_ linkColor: UIColor) -> NSAttributedString {

        let muAttr = self.mutableAttributedString
        muAttr.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 0, length: self.length))
        muAttr.addAttributes([NSAttributedString.Key.underlineColor: linkColor], range: NSRange(location: 0, length: self.length))
        return muAttr
    }

    public func insert(_ object: NSAttributedString, index: Int) -> NSAttributedString {
        let muAttr = self.mutableAttributedString
        muAttr.insert(object, at: index)
        return muAttr
    }

    public static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {

        let result = lhs.mutableAttributedString
        result.append(rhs)
        return result
    }
}
