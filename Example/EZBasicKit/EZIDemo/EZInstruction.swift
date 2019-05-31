//
//  EZInstruction.swift
//  EZBasicKit_Example
//
//  Created by wangding on 2019/5/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import EZBasicKit

enum EZIType: String, Equatable {

    case unknown
    case home

    init(value: String?) {
        guard let value = value else {
            self = .unknown
            return
        }
        switch CaseInsensitiveString(value) {
        case "home":
            self = .home
        default:
            self = .unknown
        }
    }

    static func ==(lhs: EZIType, rhs: EZIType) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

extension EZIType: EZInstructionType {

    func wrapperType(forComponents components: [String]) -> EZIWrapper.Type {
        switch self {
        case .home:
            return EZIWrapper.self
        case .unknown:
            return EZIWrapper.self
        }
    }
}
