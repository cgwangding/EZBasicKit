//
//  EZInstruction.swift
//  ezbuy
//
//  Created by Rocke on 16/5/26.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

public protocol EZInstructionType {

    func wrapperType(forComponents components: [String]) -> EZIWrapper.Type
}

public struct EZInstruction {

    public let type: EZInstructionType

    public let components: [String]

    public var path: String {
        return self.components.isEmpty ? "" : ([""] + self.components).joined(separator: "/")
    }

    internal(set) public var info: [String: String]

    public let source: Any?

    public init(type: EZInstructionType, components: [String] = [], info: [String: String] = [:], source: Any? = nil) {
        self.type = type
        self.components = components
        self.info = info
        self.source = source
    }

}

extension EZInstruction {

    public var wrapper: EZIWrapper {
        return self.type.wrapperType(forComponents: self.components).init(instruction: self)
    }
}
