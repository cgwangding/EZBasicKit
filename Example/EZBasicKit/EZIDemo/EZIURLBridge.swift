//
//  EZIURLBridge.swift
//  EZBasicKit_Example
//
//  Created by wangding on 2019/5/31.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class EZBuyAPPEZIURLBridge: EZIURLBridge {

    static let scheme = "ezbuyapp"

    func bridgeToEZI(from url: URL) -> EZInstruction? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), url.scheme?.lowercased() == EZBuyAPPEZIURLBridge.scheme else {
            return nil
        }

        let queries = makeDictionary(fromQueryItems: components.queryItems)
        let comps = components.path.components(separatedBy: "/").filter({ !$0.isEmpty })

        let ezi = EZInstruction(type: EZIType(value: url.host), components: comps, info: queries, source: url)
        return ezi

    }

    func bridgeToURL(from ezi: EZInstruction) -> URL? {

        guard ezi.type != .unknown else { return nil }
        var comp
    }
}
