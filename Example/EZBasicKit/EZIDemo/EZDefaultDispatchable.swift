//
//  EZDefaultDispatchable.swift
//  EZBasicKit_Example
//
//  Created by wangding on 2019/5/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import EZBasicKit

protocol EZIDispatchable: EZIHandleable {

    func handleHome(_ wrapper: EZIWrapper) -> EZIHandlerAction
}

extension EZIDispatchable {

    func handler(forEZI instruction: EZInstruction) -> EZIHandlerAction {
        switch instruction.type as! EZIType {
        case .home:
            return handleHome(instruction.wrapper)
        }
    }
}

protocol EZIDefaultDispatchable: EZIDispatchable {

}

extension EZIDefaultDispatchable where Self: UIViewController {

    func handleHome(_ wrapper: EZIWrapper) -> EZIHandlerAction {
        return .handling({
            debugPrint("handle in \(String(describing: type(of: Self.self)))")
        })
    }
}
