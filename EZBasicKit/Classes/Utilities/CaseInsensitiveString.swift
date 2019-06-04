//
//  CaseInsensitiveString.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/29.
//

import Foundation

public struct CaseInsensitiveString: ExpressibleByStringLiteral, Hashable {

    let lowercaseString: String

    public init(_ string: String) {
        self.lowercaseString = string.lowercased()
    }

    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }

    public func hash(into haser: inout Hasher) {
        haser.combine(self.lowercaseString)
    }
}

public func == (lhs: CaseInsensitiveString, rhs: CaseInsensitiveString) -> Bool {
    return lhs.lowercaseString == rhs.lowercaseString
}

public func ~= (string: String, cis: CaseInsensitiveString) -> Bool {
    return string.lowercased() == cis.lowercaseString
}
