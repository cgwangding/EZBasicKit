//
//  EZDefaultDispatchable.swift
//  EZBasicKit_Example
//
//  Created by wangding on 2019/5/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import EZBasicKit

protocol EZDefaultDispatchable: EZIHandleable {

    func handleHome(_ wrapper: EZIWrapper) -> EZIHandlerAction
}

extension EZDefaultDispatchable {

    func handler(forEZI instruction: EZInstruction) -> EZIHandlerAction {
        switch instruction.type as! EZIType {
        case .home:
            return handleHome(instruction.wrapper)
        }
    }
}
