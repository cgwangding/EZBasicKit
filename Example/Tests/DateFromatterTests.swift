//
//  DateFromatterTests.swift
//  EZBasicKit_Example
//
//  Created by wangding on 2019/6/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import EZBasicKit

class DateFromatterTests: QuickSpec {

    override func spec() {

        context("date from time interval") {

            let t: TimeInterval = 1559627466

            it("default format", closure: {
                expect(t.formattedTime()).to(equal("04/06/2019 13:51"))
            })

            it("custom format", closure: {
            expect(t.formattedTime("YYYY-MM-dd")).to(equal("2019-06-04"))
            })
        }

        describe("date from Int64") {
            context("with unix timestamp", closure: {
                let t: Int64 = 1559627466
                it("default format", closure: {
                    expect(t.formattedTime()).to(equal("04/06/2019 13:51"))
                })

                it("custom format", closure: {
                    expect(t.formattedTime("YYYY-MM-dd")).to(equal("2019-06-04"))
                })
            })

            context("with java timestamp", closure: {
                let t: Int64 = 1559627466000
                it("default format", closure: {
                    expect(t.formattedTime()).to(equal("04/06/2019 13:51"))
                })

                it("custom format", closure: {
                    expect(t.formattedTime("YYYY-MM-dd")).to(equal("2019-06-04"))
                })
            })
        }
    }
}
