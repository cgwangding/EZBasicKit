//
//  EZInstruction.swift
//  ezbuy
//
//  Created by Rocke on 16/5/26.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

public protocol EZInstructionType {

    var identifier: String { get }

    func wrapperType(forComponents components: [String]) -> EZIWrapper.Type
}

extension EZInstructionType  {

    public func wrapperType(forComponents components: [String]) -> EZIWrapper {
        fatalError("需要有具体的类型遵守 EZInstructionType 协议")
    }
}

public func ==(lhs: EZInstructionType, rhs: EZInstructionType) -> Bool {
    return lhs.identifier == rhs.identifier
}

public func ==<E:EZInstructionType>(lhs: E, rhs: E) -> Bool {
    return lhs.identifier == rhs.identifier
}

public func ==<E:EZInstructionType>(lhs: EZInstructionType, rhs: E) -> Bool {
    return lhs.identifier == rhs.identifier
}

public func !=(lhs: EZInstructionType, rhs: EZInstructionType) -> Bool {
    return lhs.identifier != rhs.identifier
}

public func !=<E:EZInstructionType>(lhs: E, rhs: E) -> Bool {
    return lhs.identifier != rhs.identifier
}

public func !=<E:EZInstructionType>(lhs: EZInstructionType, rhs: E) -> Bool {
    return lhs.identifier != rhs.identifier
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

public extension EZInstruction {

    public var wrapper: EZIWrapper {
        return self.type.wrapperType(forComponents: self.components).init(instruction: self)
    }
}
