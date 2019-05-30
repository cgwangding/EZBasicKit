//
//  SelectionTests.swift
//  EZBasicKit_Tests
//
//  Created by ezbuy on 2019/5/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble

@testable import EZBasicKit

class SelectionTests: QuickSpec {
    
    var containers: Container<Int>  = Container<Int>()
    
    var selection: SetSelection<Container<Int>> = SetSelection<Container<Int>>()

    override func spec() {
        
        describe("selection") {
            beforeEach {
                self.containers.objects = [1,2,3,4,5,6]
                self.selection.source = self.containers
            }
            
            it("source not nil", closure: {
                expect(self.selection.source).notTo(beNil())
            })

            it("selectedObjects count", closure: {
                expect(self.selection.selectedObjects.count).to(equal(0))
            })

            it("isSelected false", closure: {
                expect(self.selection.isSelected(1)).to(equal(false))
                expect(self.selection.isSelected(2)).to(equal(false))
                expect(self.selection.isSelected(3)).to(equal(false))
                expect(self.selection.isSelected(4)).to(equal(false))
                expect(self.selection.isSelected(5)).to(equal(false))
                expect(self.selection.isSelected(6)).to(equal(false))
            })

            it("isSelected true", closure: {
                self.selection.setSelected(true, forObject: 1)
                expect(self.selection.isSelected(1)).to(equal(true))
                self.selection.setSelected(true, forObject:2)
                expect(self.selection.isSelected(2)).to(equal(true))
                self.selection.setSelected(true, forObject:3)
                expect(self.selection.isSelected(3)).to(equal(true))
                self.selection.setSelected(true, forObject:4)
                expect(self.selection.isSelected(4)).to(equal(true))
                self.selection.setSelected(true, forObject:5)
                expect(self.selection.isSelected(5)).to(equal(true))
                self.selection.setSelected(true, forObject: 6)
                expect(self.selection.isSelected(6)).to(equal(true))
                
                self.selection.clear()
            })
            
            it("count", closure: {
                expect(self.selection.count).to(equal(0))
            })

            it("clear function", closure: {
                self.selection.setSelected(true, forObjects: [1,2,3])
                expect(self.selection.count).to(equal(3))
                self.selection.clear()
                expect(self.selection.count).to(equal(0))
            })
            
            it("setSelectedForObject", closure: {
                
                var isSetSeletedSuccess = self.selection.setSelected(true, forObject: 1)
                expect(isSetSeletedSuccess).to(equal(true))
                expect(self.selection.count).to(equal(1))
                expect(self.selection.selectedObjects.count).to(equal(1))
                
                isSetSeletedSuccess = self.selection.setSelected(true, forObject: 1)
                expect(isSetSeletedSuccess).to(equal(false))
                
                self.selection.setSelected(false, forObject: 1)
                expect(self.selection.count).to(equal(0))
                expect(self.selection.selectedObjects.count).to(equal(0))
            })
            
            it("updateIfSourceAvaiable", closure: {
                self.selection.setSelected(true, forObject: 1)
                expect(self.selection.count).to(equal(1))
                self.selection.updateIfSourceAvaiable()
                expect(self.selection.count).to(equal(1))
                
                self.selection.clear()
            })

            it("setSelectedForObjects", closure: {
                
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
                
                isSuccess = self.selection.setSelected(false, forObjects: [1,2,3])
                expect(isSuccess).to(equal(true))
                expect(self.selection.isSelected(1)).to(equal(false))
                expect(self.selection.isSelected(2)).to(equal(false))
                expect(self.selection.isSelected(3)).to(equal(false))
            })
            
            it("isAllSelected", closure: {
                expect(self.selection.isAllSelected).to(equal(false))
                self.selection.setSelected(true, forObjects: [1,2,3])
                expect(self.selection.isAllSelected).to(equal(false))
                self.selection.setSelected(true, forObjects: [4,5,6])
                expect(self.selection.isAllSelected).to(equal(true))
                self.selection.clear()
            })
            
            it("select and deselect ") {
                var isSuccess = self.selection.select(6)
                expect(isSuccess).to(equal(true))
                expect(self.selection.isSelected(6)).to(equal(true))
                isSuccess = self.selection.select(6)
                expect(isSuccess).to(equal(false))
                expect(self.selection.isSelected(6)).to(equal(true))
                
                isSuccess = self.selection.deselect(6)
                expect(isSuccess).to(equal(true))
                expect(self.selection.isSelected(6)).to(equal(false))
                isSuccess = self.selection.deselect(6)
                expect(isSuccess).to(equal(false))
                expect(self.selection.isSelected(6)).to(equal(false))
            }
            
            it("makeItem") {
                var item = self.selection.makeItem(1)
                expect(item.object).to(equal(1))
                expect(item.isSelected).to(equal(false))
            }
            
            it("item isSelected", closure: {
                var item = self.selection.makeItem(1)
                item.isSelected = true
                expect(self.selection.isSelected(1)).to(equal(true))
                item.isSelected = false
                expect(self.selection.isSelected(1)).to(equal(false))
            })
        }
    }
}

class IDObject: NSObject {
    
    let identifier: Int
    
    init(id: Int) {
        self.identifier = id
        super.init()
    }
    
    override var hash: Int {
        return self.hashValue
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        return self.isEqual(object)
    }
}

class Container<O: Hashable>: NSObject, ObjectsContainer {
    
    var objects: [O] = []
}
