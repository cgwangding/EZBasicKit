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

    case home

    init?(_ rawValue: CaseInsensitiveString) {
        switch rawValue {
        case "home":
            self = .home
        default: return nil
        }
    }
}

extension EZIType: EZInstructionType {

    func wrapperType(forComponents components: [String]) -> EZIWrapper.Type {
        switch self {
        case .home:
            return EZIWrapper.self
        }
    }
}
