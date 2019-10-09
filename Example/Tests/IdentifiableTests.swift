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
    
    let id1 = IDCard(id: 1)
    let id2 = IDCard(id: 2)
    let id3 = IDCard(id: 1)
    
    let obj1 = IdentifierObject(id: 1)
    let obj2 = IdentifierObject(id: 1)
    let obj3 = IdentifierObject(id: 2)

    override func spec() {
        
        describe("Identifiable Object") {
            
            it("must have identifier", closure: {
                expect(self.id1.identifier).to(equal(1))
            })
            
            it("use identifier as identity", closure: {
                expect(self.id1.identifier).to(equal(self.id3.identifier))
                expect(self.id1.identifier).notTo(equal(self.id2.identifier))
            })
            
            it("identifier equal, identifier.hashValue equal", closure: {
                expect(self.obj2.identifier.hashValue).to(equal(self.obj1.identifier.hashValue))
            })
            
            it("nsHashValue is identifier's hashValue", closure: {
                expect(self.obj1.nsHashValue).to(equal(self.obj1.identifier.hashValue))
                expect(self.obj1.nsHashValue).to(equal(self.obj2.nsHashValue))
            })
            
            it("hash is nsHashValue", closure: {
                expect(self.obj1.nsHashValue).to(equal(self.obj1.hash))
            })
            
            it("nsIsEqual judged by identifier ", closure: {
                expect(self.obj1.identifier).to(equal(self.obj2.identifier))
                expect(self.obj1.nsIsEqual(self.obj2)).to(equal(true))
                expect(self.obj1.identifier).notTo(equal(self.obj3.identifier))
                expect(self.obj1.nsIsEqual(self.obj3)).to(equal(false))
            })
            
            it("isEqual equal to nsIsEqual", closure: {
                expect(self.obj1.nsIsEqual(self.obj2)).to(equal(self.obj1.isEqual(self.obj2)))
                expect(self.obj1.nsIsEqual(self.obj3)).to(equal(self.obj1.isEqual(self.obj3)))
            })
            
            it("== to judge isEqual", closure: {
                expect(self.obj1 == self.obj2).to(equal(true))
            })
            
            it("< to compare", closure: {
                expect(self.obj1 < self.obj2).to(equal(false))
                expect(self.obj1 < self.obj3).to(equal(true))
            })
        }
    }
}

class IdentifierObject: NSObject, EZIdentifiable {
    
    let identifier: Int
    
    init(id: Int) {
        self.identifier = id
        super.init()
    }
    
    override var hash: Int {
        return self.nsHashValue
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        return self.nsIsEqual(object)
    }
}

class IDCard: NSObject, EZIdentifiable {
    
    let identifier: Int
    
    init(id: Int) {
        self.identifier = id
        super.init()
    }
}
