//
//  SelectionTests.swift
//  EZBasicKit_Tests
//
//  Created by ezbuy on 2019/5/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import EZBasicKit

class SelectionTests: QuickSpec {

    override func spec() {
        
        describe("a Customer") {
            let customer = Customer()
            let apple = Fruit(count: 4, type: .🍎)
            let banana = Fruit(count: 6, type: .🍌)
            let pineapple = Fruit(count: 1, type: .🍍)
            customer.objects = [apple, banana, pineapple]
            var selection: SetSelection<Customer>!
            beforeEach {
                selection = SetSelection<Customer>()
                selection.source = customer
            }
            
            describe("select", {
                expect(selection.setSelected(true, forObject: apple)).to(equal(true))
                
            })
        }
    }

}
