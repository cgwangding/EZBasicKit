//
//  ArrayExtensionTests.swift
//  EZBasicKit_Tests
//
//  Created by wangding on 2019/6/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import EZBasicKit

class ArrayExtensionTests: QuickSpec {

    override func spec() {

        context("array object index") {

            let s = [1, 2, 3, 4, 5]

            it("inside array", closure: {
                expect(s.object(at: 0)).to(equal(1))
                expect(s.object(at: 2)).to(equal(3))
                expect(s.object(at: 4)).to(equal(5))
            })

            it("outside array", closure: {
                expect(s.object(at: -1)).to(beNil())
                expect(s.object(at: 5)).to(beNil())
            })
        }

        context("array remove duplicate") {
            let s: [Int] = [1, 2, 2, 3, 3]
            it("int", closure: {
                expect(s.removeDuplicates()).to(equal([1, 2, 3]))
                expect(s.removeDuplicates()).toNot(equal([1, 2, 2, 3, 3]))
                expect(s).to(equal([1, 2, 2, 3, 3]))
            })

            let s2: [String] = ["a", "b", "c", "a", "d", "c", "a"]
            it("string", closure: {
                expect(s2.removeDuplicates()).to(equal(["a", "b", "c", "d"]))
                expect(s2.removeDuplicates()).toNot(equal(["a", "b", "c", "a", "d", "c", "a"]))
            })
        }
    }
}
