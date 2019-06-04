//
//  StringExtensionTests.swift
//  EZBasicKit_Tests
//
//  Created by wangding on 2019/6/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import EZBasicKit

class StringExtensionTests: QuickSpec {

    override func spec() {
        context("string trimming") {
            let s = "ad   df \n"
            it("white space", closure: {
                expect(s.trimmingAllWhitespace).to(equal("addf\n"))
            })

            it("white space and newline", closure: {
              expect(s.trimmingAllWhitespaceAndNewline).to(equal("addf"))
            })
        }

        context("string substring") {
            let s = "abcdefg"

            it("from index subscript", closure: {
                expect(s[from: -1]).to(beNil())
                expect(s[from: 0]).to(equal("abcdefg"))
                expect(s[from: 1]).to(equal("bcdefg"))
                expect(s[from: s.count]).to(beNil())
            })

            it("to index subscript", closure: {
                expect(s[to: -1]).to(beNil())
                expect(s[to: 0]).to(equal("a"))
                expect(s[to: 1]).to(equal("ab"))
                expect(s[to: s.count]).to(beNil())
                expect(s[to: 6]).to(equal("abcdefg"))
                expect(s[to: 10]).to(beNil())
            })

            it("in close range subscript", closure: {
                expect(s[in: -1...1]).to(beNil())
                expect(s[in: 0...1]).to(equal("ab"))
                expect(s[in: 0...6]).to(equal("abcdefg"))
                expect(s[in: 0...7]).to(beNil())
                expect(s[in: -1...7]).to(beNil())
            })

            it("in range subscript", closure: {
                expect(s[in: -1..<1]).to(beNil())
                expect(s[in: 0..<1]).to(equal("a"))
                expect(s[in: 0..<7]).to(equal("abcdefg"))
                expect(s[in: 0..<8]).to(beNil())
                expect(s[in: -1..<8]).to(beNil())
            })
        }

        context("string convert") {
            it("number convert function", closure: {
                var i: Int? = "123".numValue()
                expect(i).to(equal(123))
                i = "1.23".numValue()
                expect(i).to(beNil())
                i = "ad".numValue()
                expect(i).to(beNil())
            })

            it("int value", closure: {
                expect("12".intValue).to(equal(12))
                expect("-12".intValue).to(equal(-12))
                expect("1.3".intValue).to(beNil())
                expect("1ab".intValue).to(beNil())
            })

            it("double value", closure: {
                expect("1.23".doubleValue).to(equal(1.23))
                expect("-1.23".doubleValue).to(equal(-1.23))
                expect("1".doubleValue).to(equal(1))
                expect("1.23ab".doubleValue).to(beNil())
            })

            it("int64 value", closure: {
                expect("12".intValue).to(equal(12))
                expect("-12".intValue).to(equal(-12))
                expect("1.3".intValue).to(beNil())
                expect("1ab".intValue).to(beNil())
            })

            it("float value", closure: {
                expect("1.23".doubleValue).to(equal(1.23))
                expect("-1.23".doubleValue).to(equal(-1.23))
                expect("1".doubleValue).to(equal(1))
                expect("1.23ab".doubleValue).to(beNil())
            })

            it("cfFloat value", closure: {
                expect("1.23".doubleValue).to(equal(1.23))
                expect("-1.23".doubleValue).to(equal(-1.23))
                expect("1".doubleValue).to(equal(1))
                expect("1.23ab".doubleValue).to(beNil())
            })
        }

        context("string approximate") {
            it("ignore cased", closure: {
                expect("AD" ~= "ad").to(beTrue())
            })
        }

        it("string whole range") {
            expect("abcd".wholeRange).to(equal(("abcd" as NSString).range(of: "abcd")))
        }

        context("string regular expression") {
            let s = "aaabcdaabaa"
            expect(s.canMatch("aa", option: NSRegularExpression.Options.caseInsensitive, matchOptions: .withTransparentBounds, range: s.wholeRange)).to(beTrue())
            expect(s.canMatch("cc", option: NSRegularExpression.Options.caseInsensitive, matchOptions: .withTransparentBounds, range: s.wholeRange)).to(beFalse())
            expect(s.numOfMatch("aa", option: .caseInsensitive, matchOptions: .withTransparentBounds, range: s.wholeRange)).to(equal(3))
            expect(s.numOfMatch("cc", option: .caseInsensitive, matchOptions: .withTransparentBounds, range: s.wholeRange)).to(equal(0))
            expect(s.numOfMatch("a", option: .caseInsensitive, matchOptions: .withTransparentBounds, range: s.wholeRange)).to(equal(7))

            expect(s.matchs("cc", option: .caseInsensitive, matchOptions: .withTransparentBounds, range: s.wholeRange)).to(equal([]))
        }
    }
}
