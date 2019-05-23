//
//  EZIHandleable.swift
//  ezbuy
//
//  Created by Rocke on 16/8/29.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

public enum EZIHandlerAction {
    
    case handling(() -> Void)
    case deferred
    case blocking
    case ignoring
}

extension EZIHandlerAction {

    @discardableResult
    public func handle() -> Bool {
        switch self {
        case .handling(let handler):
            handler()
        default:
            break
        }
        return self.isHandling
    }
    
    public var isHandling: Bool {
        switch self {
        case .handling(_), .blocking:
            return true
        case .ignoring, .deferred:
            return false
        }
    }
    
    public var hasAction: Bool {
        switch self {
        case .handling(_):
            return true
        default:
            return false
        }
    }
}

public protocol EZIHandleable {
    
    func handler(forEZI instruction: EZInstruction) -> EZIHandlerAction
}
