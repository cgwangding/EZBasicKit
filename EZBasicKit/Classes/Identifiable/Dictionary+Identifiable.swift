//
//  Dictionary+Identifiable.swift
//  Identifiable
//
//  Created by Rocke on 16/6/28.
//  Copyright © 2016年 L & L. All rights reserved.
//

import Foundation

extension Dictionary where Value: Hashable {
    
    public var valueGrouping: [Value: Set<Key>] {
        
        return self.reduce([Value: Set<Key>]()) { (mapping, pair) in
        
            var reval = mapping
            var keys = reval[pair.1] ?? []
            keys.insert(pair.0)
            reval[pair.1] = keys
            return reval
        }
    }
    
    public var valueMapping: [Value: Key] {
        
        return self.reduce([Value: Key]()) { (mapping, pair) in
            
            var reval = mapping
            reval[pair.1] = pair.0
            return reval
        }
    }
}

extension Dictionary where Value: IdentifiableWrapper {

    public var idBases: [Key: Value.Base] {
        
        var reval: [Key: Value.Base] = [:]
        
        for (key, value) in self {
            reval[key] = value.base
        }
        
        return reval
    }
}

extension Dictionary where Value: Sequence, Value.Iterator.Element: IdentifiableWrapper {
    
    public var idBases: [Key: [Value.Iterator.Element.Base]] {
        
        var reval: [Key: [Value.Iterator.Element.Base]] = [:]
        
        for (key, value) in self {
            reval[key] = value.idBases
        }
        
        return reval
    }
}
