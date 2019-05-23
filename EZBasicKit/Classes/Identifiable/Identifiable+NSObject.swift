//
//  Identifiable+NSObject.swift
//  Identifiable
//
//  Created by Rocke on 16/6/28.
//  Copyright © 2016年 L & L. All rights reserved.
//

import Foundation

extension Identifiable where Self: NSObject, Identifier: Hashable {

    public var nsHashValue: Int { return self.identifier.hashValue }
    
    public func nsIsEqual(_ object: Any?) -> Bool {
        
        guard let another = object as? Self else { return false }

        return self.identifier == another.identifier
    }
}
