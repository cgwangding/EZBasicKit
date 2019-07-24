//
//  NSRangeExtensionTests.swift
//  EZBasicKit_Tests
//
//  Created by wangding on 2019/6/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import EZBasicKit

class NSRangeExtensionTests: QuickSpec {

    let text = "abcdefg"

    override func spec() {


        context("NSRange to string range") {

            it("lower bound out of string", closure: {
                let range = NSRange(-1..<3)
                expect(range.toRange(with: self.text)).to(beNil())
            })

            it("upper bound out of string", closure: {
                let range = NSRange(0..<9)
                expect(range.toRange(with: self.text)).to(beNil())
            })

            it("lower and upper bound out of string", closure: {
                let range = NSRange(-1..<9)
                expect(range.toRange(with: self.text)).to(beNil())
            })

            it("bounds inside string", closure: {
                let r1 = NSRange(0..<1)
                expect(r1.toRange(with: self.text)).to(equal(self.text.range(of: "a")))
                let r2 = NSRange(0..<7)
                expect(r2.toRange(with: self.text)).to(equal(self.text.range(of: "abcdefg")))
            })
        }
    }

}
