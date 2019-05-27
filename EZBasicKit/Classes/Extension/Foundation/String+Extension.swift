//
//  String+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/24.
//

import Foundation

// MARK: - to attribte string
extension String {

    public var attributeString: NSAttributedString {
        return NSAttributedString(string: self)
    }

    public var mutableAttributeString: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
}

// MARK: - 剔除空格以及换行
extension String {

    public var trimmingWhitespace: String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }

    public var trimmingWhitespaceAndNewline: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

// MARK: - 计算文字宽高
extension String {

    public func height(_ constraintWidth: CGFloat, font: UIFont = UIFont.systemFont(ofSize: 14)) -> CGFloat {

        return self.size(CGSize(width: constraintWidth, height: CGFloat.infinity), font: font).height
    }

    public func width(_ constraintHeight: CGFloat, font: UIFont = UIFont.systemFont(ofSize: 14)) -> CGFloat {

        return self.size(CGSize(width: CGFloat.infinity, height: constraintHeight), font: font).width
    }

    public func size(_ constraintSize: CGSize, font: UIFont = UIFont.systemFont(ofSize: 14)) -> CGSize {

        return self.size(constraintSize, attributes: [NSAttributedString.Key.font: font])
    }

    public func size(_ constraintSize: CGSize, attributes: [NSAttributedStringKey : Any]) -> CGSize {

        let attr = NSAttributedString(string: self, attributes: attributes)

        let rect = attr.boundingRect(with: constraintSize, options: [.usesFontLeading, .usesLineFragmentOrigin], context: nil)

        return rect.size
    }
}

// MARK: - substring
extension String {

    public subscript(from index: Int) -> String? {

        guard index <= self.count else { return nil }
        let start = self.index(self.startIndex, offsetBy: index)
        return String(self[start...])
    }

    public subscript(to index: Int) -> String? {

        guard index >= 0 else { return nil }
        let end = self.index(self.startIndex, offsetBy: min(index, self.count))
        return String(self[...end])
    }

    public subscript(in range: ClosedRange<Int>) -> String? {
        guard range.lowerBound >= 0, range.upperBound <= self.count else { return nil }
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        return String(self[start...end])
    }

    public subscript(in range: Range<Int>) -> String? {
        guard range.lowerBound >= 0, range.upperBound <= self.count else { return nil }
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        return String(self[start..<end])
    }
}

extension String {

    public func substring(to index: Int) -> String? {
        return self[to: index]
    }

    public func substring(from index: Int) -> String? {
        return self[from: index]
    }

    public func substring(range: ClosedRange<Int>) -> String? {
        return self[in: range]
    }

    public func substring(range: Range<Int>) -> String? {
        return self[in: range]
    }
}

// MARK: - 基础数据类型转换
extension String {

    public func numValue<T>() -> T? where T: LosslessStringConvertible {
        return T(self)
    }

    public var intValue: Int? {
        return self.numValue()
    }

    public var doubleValue: Double? {
        return self.numValue()
    }

    public var int64Value: Int64? {
        return self.numValue()
    }

    public var floatValue: Float? {
        return self.numValue()
    }

    public var cgFloatValue: CGFloat? {
        guard let double = self.doubleValue else { return nil }
        return CGFloat(double)
    }
}

// MARK: - 约等于，只能判断英文字母，忽略大小写
extension String {

    public static func ~=(lhs: String, rhs: String) -> Bool {
        return lhs.lowercased() == rhs.lowercased()
    }
}

// MARK: - whole range
extension String {

    public var wholeRange: NSRange {
        return NSRange(location: 0, length: self.count)
    }
}

// MARK: - regular expression
extension String {

    public func canMatch(_ pattern: String, option: NSRegularExpression.Options, matchOptions: NSRegularExpression.MatchingOptions, range: NSRange) -> Bool {
        return self.numOfMatch(pattern, option: option, matchOptions: matchOptions, range: range) > 0
    }

    public func numOfMatch(_ pattern: String, option: NSRegularExpression.Options, matchOptions: NSRegularExpression.MatchingOptions, range: NSRange) -> Int {

        return self.matchs(pattern, option: option, matchOptions: matchOptions, range: range).count
    }

    public func matchs(_ pattern: String, option: NSRegularExpression.Options, matchOptions: NSRegularExpression.MatchingOptions, range: NSRange) -> [NSTextCheckingResult] {
        do {
            let exp = try NSRegularExpression(pattern: pattern, options: option)
            return exp.matches(in: self, options: matchOptions, range: range)
        } catch _ {
            return []
        }
    }
}
