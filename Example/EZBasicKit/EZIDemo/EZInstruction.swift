//
//  EZInstruction.swift
//  EZBasicKit_Example
//
//  Created by wangding on 2019/5/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import EZBasicKit

enum EZIType: String {

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
}

extension EZIType: EZInstructionType {
    
    var identifier: String {
        return self.rawValue
    }

    func wrapperType(forComponents components: [String]) -> EZIWrapper.Type {
        switch self {
        case .home:
            return EZIWrapper.self
        case .unknown:
            return EZIWrapper.self
        }
    }
}
