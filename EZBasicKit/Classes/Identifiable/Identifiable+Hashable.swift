//
//  Identifiable+Hashable.swift
//  Identifiable
//
//  Created by Rocke on 16/6/28.
//  Copyright © 2016年 L & L. All rights reserved.
//

import Foundation

extension Identifiable where Identifier: Hashable, Self: Hashable {
    
    public var hashValue: Int { return self.identifier.hashValue }
    
    public func hash(into hasher: inout Hasher) { hasher.combine(self.identifier) }
}
