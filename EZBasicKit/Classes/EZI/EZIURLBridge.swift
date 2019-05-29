//
//  EZIURLBridge.swift
//  ezbuy
//
//  Created by YangFan on 2016/10/27.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

protocol EZIURLBridge {

    func bridgeToEZI(from url: URL) -> EZInstruction?

    func bridgeToURL(from ezi: EZInstruction) -> URL?
}

public struct EZIURLBridgeOptions: OptionSet {

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let ezbuyApp      = EZIURLBridgeOptions(rawValue: 1 << 0)
    public static let httpWeb       = EZIURLBridgeOptions(rawValue: 1 << 1)
    public static let universalLink = EZIURLBridgeOptions(rawValue: 1 << 2)
    public static let shopbackLink = EZIURLBridgeOptions(rawValue: 1 << 3)
}

private func makeDictionary(fromQueryItems queryItems: [URLQueryItem]?) -> [String: String] {

    var queries = [String: String]()

    for item in queryItems ?? [] {
        queries[item.name] = item.value
    }

    return queries
}

private func makeQueryItems(fromDictionary dict: [String: String]?) -> [URLQueryItem] {

    return dict?.map({ URLQueryItem(name: $0, value: $1) }) ?? []
}
