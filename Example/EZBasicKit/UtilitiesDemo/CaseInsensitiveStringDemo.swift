//
//  CaseInsensitiveStringDemo.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/6/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

public enum Origin: String {
    case china
    case singpore
    case malaysia
    case thailand
    case pakistan
    case unknown
    
    init(code: String) {
        switch CaseInsensitiveString(code) {
        case "china":
            self = .china
        case "singpore":
            self = .singpore
        case "malaysia":
            self = .malaysia
        case "thailand":
            self = .thailand
        case "pakistan":
            self = .pakistan
        default:
            self = .unknown
        }
    }
}
