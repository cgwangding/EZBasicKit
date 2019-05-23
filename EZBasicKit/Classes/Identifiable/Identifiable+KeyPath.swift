//
//  KeyPathIdentifierGenerator.swift
//  Identifiable
//
//  Created by Rocke on 16/6/29.
//  Copyright © 2016年 L & L. All rights reserved.
//

import Foundation

extension NSObjectProtocol where Self: NSObject {

    public static func idGenerator<Identifier>(forKeyPath keyPath: String, as type: Identifier.Type, nilHandler: @escaping (Self) -> Identifier) -> (Self) -> Identifier {
    
        let generator: (Self) -> Identifier = { object in
            if let value = object.value(forKeyPath: keyPath) as? Identifier {
                return value
            } else {
                return nilHandler(object)
            }
        }
        return generator
    }
}
