//
//  NSObjectExtensionTests.swift
//  EZBasicKit_Tests
//
//  Created by wangding on 2019/6/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import EZBasicKit

class NSObjectExtensionTests: QuickSpec {


    class MyObject: NSObject {

    }

    override func spec() {

        it("my object name") {
            expect(MyObject.name).to(equal("MyObject"))
            expect(MyObject().className).to(equal("MyObject"))
        }
    }
}
