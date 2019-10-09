//
//  Identifiable+Comparable.swift
//  Identifiable
//
//  Created by Rocke on 16/6/28.
//  Copyright © 2016年 L & L. All rights reserved.
//

import Foundation

public func <<I: EZIdentifiable>(lhs: I, rhs: I) -> Bool where I.Identifier: Comparable {
    return lhs.identifier < rhs.identifier
}
