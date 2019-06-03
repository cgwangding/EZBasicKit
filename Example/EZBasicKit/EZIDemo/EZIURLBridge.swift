//
//  EZIURLBridge.swift
//  EZBasicKit_Example
//
//  Created by wangding on 2019/5/31.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

extension EZIURLBridgeOptions {

    public static let ezbuyApp: EZIURLBridgeOptions = EZIURLBridgeOptions(rawValue: 1 << 1)
}

class EZBuyAPPEZIURLBridge: EZIURLBridge {

    static let scheme = "ezbuyapp"

    func bridgeToEZI(from url: URL) -> EZInstruction? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), url.scheme?.lowercased() == EZBuyAPPEZIURLBridge.scheme else {
            return nil
        }

        let queries = components.queryItems?.toDictionary ?? [:]
        let comps = components.path.components(separatedBy: "/").filter({ !$0.isEmpty })

        let ezi = EZInstruction(type: EZIType(value: url.host), components: comps, info: queries, source: url)
        return ezi

    }

    func bridgeToURL(from ezi: EZInstruction) -> URL? {

        guard ezi.type != EZIType.unknown else { return nil }

        var urlComponents = URLComponents()
        urlComponents.scheme = EZBuyAPPEZIURLBridge.scheme
        urlComponents.host = ezi.type.identifier
        urlComponents.path = ezi.path
        urlComponents.queryItems = ezi.info.map({ URLQueryItem(name: $0.0, value: $0.1) })
        return urlComponents.url
    }
}

extension EZInstruction {

    fileprivate static let ezbuyAppBridge: EZIURLBridge = EZBuyAPPEZIURLBridge()

    init?(_ url: URL?, bridgeOptions: [EZIURLBridgeOptions]) {

        guard let url = url else {
            return nil
        }

        if bridgeOptions.contains(.ezbuyApp), let ezi = EZInstruction.ezbuyAppBridge.bridgeToEZI(from: url) {
            self = ezi
            return
        }

        return nil
    }
}
