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

extension Array where Element: Hashable {

    public func removeDuplicates() -> [Element] {

        var result: [Element] = []

        for e in self {
            if !result.contains(e) {
                result.append(e)
            }
        }
        return result
    }
}
