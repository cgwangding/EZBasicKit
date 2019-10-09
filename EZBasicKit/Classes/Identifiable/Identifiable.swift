//
//  Identifiable.swift
//  Identiable
//
//  Created by Rocke on 16/6/28.
//  Copyright © 2016年 L & L. All rights reserved.
//

import Foundation

public protocol EZIdentifiable: Equatable {
    
    associatedtype Identifier: Equatable
    
    var identifier: Identifier { get }
}

public func ==<I: EZIdentifiable>(lhs: I, rhs: I) -> Bool {
    return lhs.identifier == rhs.identifier
}
