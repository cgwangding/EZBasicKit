//
//  Array+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/24.
//

import Foundation

extension Array {

    public func object(at index: Int) -> Element? {

        guard self.range.contains(index) else {
            return nil
        }
        return self[index]
    }

    private var range: CountableRange<Int> {
        return 0..<self.count
    }
}

extension Array where Element: Numeric {

    public func sum() -> Element {
        return self.reduce(0, { $0 + $1 })
    }
}

extension Array where Element: Hashable {

    public func removeDuplicates() -> [Element] {
        return Array(Set(self))
    }
}
