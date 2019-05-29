//
//  NSRange+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/29.
//

import Foundation

extension NSRange {

    public func toRange(with str: String) -> Range<String.Index>? {
        
        guard let start = str.index(str.startIndex, offsetBy: self.lowerBound, limitedBy: str.endIndex), let end = str.index(str.startIndex, offsetBy: self.upperBound, limitedBy: str.endIndex) else { return nil }
        return Range(uncheckedBounds: (start, end))
    }
}
