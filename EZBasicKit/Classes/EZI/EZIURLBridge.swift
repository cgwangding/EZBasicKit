//
//  EZIURLBridge.swift
//  ezbuy
//
//  Created by YangFan on 2016/10/27.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

public protocol EZIURLBridge {

    func bridgeToEZI(from url: URL) -> EZInstruction?

    func bridgeToURL(from ezi: EZInstruction) -> URL?
}

public struct EZIURLBridgeOptions: OptionSet {

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
