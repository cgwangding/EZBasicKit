//
//  ObjectsContainer.swift
//  Selection
//
//  Created by Rocke on 16/5/31.
//  Copyright © 2016年 ezbuy. All rights reserved.
//

import Foundation

public protocol ObjectsContainer: class {

    associatedtype Object

    var objects: [Object] { get }
}

public protocol MutableObjectsContainer: ObjectsContainer {

    var objects: [Object] { get set }
}
