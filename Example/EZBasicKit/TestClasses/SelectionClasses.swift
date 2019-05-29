//
//  SelectionTests.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/5/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class Customer: ObjectsContainer {
    
    var objects: [Fruit] = [Fruit(count: 3, type: .🍑), Fruit(count: 5, type: .🍌)]
    
    typealias Object = Fruit
    
}

public enum FruitType {
    case 🍎
    case 🍐
    case 🍌
    case 🍍
    case 🍑
    
    var price: Double {
        switch self {
        case .🍌:
            return 3.0
        case .🍍:
            return 4.0
        case .🍎:
            return 5.0
        case .🍐:
            return 6.0
        case .🍑:
            return 4.5
        }
    }
}

class Fruit: NSObject {
    var price: Double
    var type: FruitType
    var count: Int
    
    init(count: Int, type: FruitType) {
        self.count = count
        self.type = type
        self.price = type.price
        super.init()
    }
}
