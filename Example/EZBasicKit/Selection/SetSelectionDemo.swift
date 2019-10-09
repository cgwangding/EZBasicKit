//
//  SetSelectionDemo.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/5/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class ProductController: NSObject {
    
    public var products: [IDObject] = [] {
        didSet {
            self.selection.updateIfSourceAvaiable()
        }
    }

    public var selection: SetSelection<ProductController> {
        willSet {
            self.selection.source = nil
        }
        didSet {
            self.selection.source = self
        }
    }
    
    public override init() {
        selection = SetSelection<ProductController>()
    }
    
    public func loadData() {
        //load data
        let p1 = IDObject(id: 1)
        let p2 = IDObject(id: 2)
        let p3 = IDObject(id: 3)
        self.products = [p1, p2, p3]
    }
}

extension ProductController: ObjectsContainer {
    var objects: [IDObject] {
        return self.products
    }
}

class IDObject: NSObject, EZIdentifiable {
    
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
