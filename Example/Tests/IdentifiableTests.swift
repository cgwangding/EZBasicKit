//
//  IdentifiableTests.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/5/31.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble

@testable import EZBasicKit

class IdentifiableTests: QuickSpec {

    override func spec() {
        
        describe("") {
            
            beforeEach {
                
            }
            
            afterEach {
                
            }
            
            it("", closure: {
                
            })
            
        }
    }
}

class IdentifierObject: NSObject, Identifiable {
     let identifier: Int
    
    init(id: Int) {
        self.identifier = id
        super.init()
    }
}
