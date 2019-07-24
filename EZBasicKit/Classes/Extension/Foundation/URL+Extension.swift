//
//  URL+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/6/1.
//

import Foundation

extension URL {
    
}

extension Array where Element == URLQueryItem {

    public var toDictionary: [String: String] {

        var queries = [String: String]()

        for item in self {
            queries[item.name] = item.value
        }

        return queries
    }
}

extension Dictionary where Key == String, Value == String {

    public var toQueryItems: [URLQueryItem] {

        return self.map({ URLQueryItem(name: $0, value: $1) })
    }
}
