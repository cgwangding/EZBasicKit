//
//  IdentifiableDemo.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/6/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class IdentifiableObject: NSObject {
    public var id: String
    
    init(id: String) {
        self.id = id
        super.init()
    }
}

extension IdentifiableObject: Identifiable {
    public var identifier: String {
        return self.id
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        return self.nsIsEqual(object)
    }
}
