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
    
    var containers: Container<Int>  = Container<Int>()
    
    var selection: SetSelection<Container<Int>> = SetSelection<Container<Int>>()

    override func spec() {
        
        describe("a selection") {
            beforeEach {
                self.containers.objects = [1,2,3,4,5,6]
                self.selection.source = self.containers
            }
        }
    }
    
    func test_source() {
        describe("must have a source") {
            expect(self.selection.source).notTo(equal(nil))
        }
    }
    
    func test_selectedObjects() {
        expect(self.selection.selectedObjects.count).to(equal(6))
    }
    
    func test_isSelected() {
        expect(self.selection.isSelected(1)).to(equal(false))
    }
    
    func test_count() {
        expect(self.selection.count).to(equal(6))
    }
    
    func test_clear() {
        self.selection.clear()
        expect(self.selection.count).to(equal(0))
    }
    
    func test_setSelectedForObject() {
        var isSetSeletedSuccess = self.selection.setSelected(true, forObject: 1)
        expect(isSetSeletedSuccess).to(equal(true))
        expect(self.selection.isSelected(1)).to(equal(true))
        isSetSeletedSuccess = self.selection.setSelected(true, forObject: 1)
        expect(isSetSeletedSuccess).to(equal(false))
        expect(self.selection.isSelected(1)).to(equal(true))
    }
    
    func test_updateIfSourceAvaiable() {
        self.test_setSelectedForObject()
        self.selection.updateIfSourceAvaiable()
        expect(self.selection.selectedObjects.count).to(equal(1))
    }
    
    func test_setSelectedForObjects() {
        var isSuccess = self.selection.setSelected(true, forObjects: [1,2,3])
        expect(isSuccess).to(equal(true))
        expect(self.selection.isSelected(1)).to(equal(true))
        expect(self.selection.isSelected(2)).to(equal(true))
        expect(self.selection.isSelected(3)).to(equal(true))
        isSuccess = self.selection.setSelected(true, forObjects: [1,2,3])
        expect(isSuccess).to(equal(false))
        expect(self.selection.isSelected(1)).to(equal(true))
        expect(self.selection.isSelected(2)).to(equal(true))
        expect(self.selection.isSelected(3)).to(equal(true))
    }
    
    func test_isAllSelected() {
        expect(self.selection.isAllSelected).to(equal(false))
        self.selection.setSelected(true, forObjects: [1,2,3,4,5,6])
        expect(self.selection.isAllSelected).to(equal(true))
    }
    
    func test_select() {
        var isSuccess = self.selection.select(6)
        expect(isSuccess).to(equal(true))
        expect(self.selection.isSelected(6)).to(equal(true))
        isSuccess = self.selection.select(6)
        expect(isSuccess).to(equal(false))
        expect(self.selection.isSelected(6)).to(equal(true))
    }
    
    func test_deselect() {
        self.selection.select(6)
        var isSuccess = self.selection.deselect(6)
        expect(isSuccess).to(equal(true))
        expect(self.selection.isSelected(6)).to(equal(false))
        isSuccess = self.selection.deselect(6)
        expect(isSuccess).to(equal(false))
        expect(self.selection.isSelected(6)).to(equal(false))
    }
}

class IDObject: NSObject, Identifiable, Comparable {
    
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

class Container<O: Hashable>: NSObject, ObjectsContainer {
    
    var objects: [O] = []
}

class IntContainer: Container<Int> {
    
}

class IDObjectContainer: Container<IDObject> {
    
}

extension ObjectsSelection where Self.Object == IDObject, Self.Source == Container<IDObject> {
    
    func joined() -> String {
        let strings = self.selectedObjects.map({ String($0.identifier) }).sorted()
        return strings.joined(separator: ",")
    }
}
