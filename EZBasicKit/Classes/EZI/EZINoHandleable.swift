//
//  EZINoHandleable.swift
//  ezbuy
//
//  Created by Rocke on 16/8/31.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

public protocol EZINoHandleable: EZIHandleable {

}

extension EZINoHandleable {

    func handler(forEZI instruction: EZInstruction) -> EZIHandlerAction {
        return .blocking
    }
}
