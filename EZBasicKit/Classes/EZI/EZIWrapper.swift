//
//  EZIWrapper.swift
//  ezbuy
//
//  Created by Rocke on 16/5/26.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

open class EZIWrapper: NSObject {

    private(set) open var instruction: EZInstruction

    private var info: [CaseInsensitiveString: String]

    public required init(instruction: EZInstruction) {
        self.instruction = instruction
        self.info = {

            var reval: [CaseInsensitiveString: String] = [:]

            for (key, value) in instruction.info {
                reval[CaseInsensitiveString(key)] = value
            }

            return reval
        }()
        super.init()
    }

    public enum OpenMode: Int {
        case whatever = 0
        case push
        case modal

        public var code: String {
            switch self {
            case .whatever:
                return "whatever"
            case .push:
                return "push"
            case .modal:
                return "modal"
            }
        }

        public init(code: String?) {
            switch code {
            case "push"?:
                self = .push
            case "modal"?:
                self = .modal
            default:
                self = .whatever
            }
        }
    }

    func doubleValue(forKey key: String) -> Double? {
        if let str = self[key] {
            return Double(str)
        } else {
            return nil
        }
    }

    func setDoubleValue(_ value: Double?, forKey key: String) {
        if let v = value {
            self[key] = String(v)
        } else {
            self[key] = nil
        }
    }

    public func intValue(forKey key: String) -> Int? {
        if let s = self[key] {
            return Int(s)
        } else {
            return nil
        }
    }

    public func setIntValue(_ value: Int?, forKey key: String) {
        if let v = value {
            self[key] = String(v)
        } else {
            self[key] = nil
        }
    }

    public func boolValue(forKey key: String) -> Bool? {
        if let s = self[key] {
            switch CaseInsensitiveString(s) {
            case "true":
                return true
            case "false":
                return false
            default:
                return nil
            }
        } else {
            return nil
        }
    }

    public func setBoolValue(_ value: Bool?, forKey key: String) {
        if let v = value {
            self[key] = (v ? "true" : "false")
        } else {
            self[key] = nil
        }
    }

    public var openMode: OpenMode {
        get {
            return OpenMode(code: self["openMode"])
        }
        set {
            self["openMode"] = newValue.code
        }
    }

    public var title: String? {
        get {
            return self["title"]
        }
        set {
            self["title"] = newValue
        }
    }

    public subscript(key: String) -> String? {
        get {
            return self.info[CaseInsensitiveString(key)]
        }
        set {
            self.info[CaseInsensitiveString(key)] = newValue
            self.instruction.info[key] = newValue
        }
    }
}
