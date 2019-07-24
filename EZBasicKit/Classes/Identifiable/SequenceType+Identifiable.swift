//
//  SequenceType+Identifiable.swift
//  Identifiable
//
//  Created by Rocke on 16/6/28.
//  Copyright © 2016年 L & L. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element: Identifiable, Iterator.Element.Identifier: Hashable {
    
    public var idMapping: [Iterator.Element.Identifier: Iterator.Element] {
        
        var mapping: [Iterator.Element.Identifier: Iterator.Element] = [:]
        for element in self {
            mapping[element.identifier] = element
        }
        return mapping
    }
    
    public var idGrouping: [Iterator.Element.Identifier: [Iterator.Element]] {
        
        var grouping: [Iterator.Element.Identifier: [Iterator.Element]]  = [:]
        for element in self {
            let identifier = element.identifier
            var group: [Iterator.Element] = grouping[identifier] ?? []
            group.append(element)
            grouping[identifier] = group
        }
        return grouping
    }
}

extension Sequence where Iterator.Element: NSObject {
    
    public func toIDMapping<Identifier: Hashable>(forKeyPath keyPath: String, as type: Identifier.Type, nilHandler: @escaping (Iterator.Element) -> Identifier) -> [Identifier: Iterator.Element] {
    
        let generator = Iterator.Element.idGenerator(forKeyPath: keyPath, as: type, nilHandler: nilHandler)
        
        return self.toIDMapping(withIDGenerator: generator)
    }
    
    public func toIDGrouping<Identifier: Hashable>(forKeyPath keyPath: String, as type: Identifier.Type, nilHandler: @escaping (Iterator.Element) -> Identifier) -> [Identifier: [Iterator.Element]] {
        
        let generator = Iterator.Element.idGenerator(forKeyPath: keyPath, as: type, nilHandler: nilHandler)
        
        return self.toIDGrouping(withIDGenerator: generator)
    }
}
 
extension Sequence {

    public func toIDMapping<Identifier: Hashable>(withIDGenerator generator: @escaping (Iterator.Element) -> Identifier) -> [Identifier: Iterator.Element] {
        
        let wrappers = IDHashableWrapper.makeWrappers(bases: self, idGenerator: generator)
        
        return wrappers.idMapping.idBases
    }
    
    public func toIDGrouping<Identifier: Hashable>(withIDGenerator generator: @escaping (Iterator.Element) -> Identifier) -> [Identifier: [Iterator.Element]] {
        
        let wrappers = IDHashableWrapper.makeWrappers(bases: self, idGenerator: generator)
        
        return wrappers.idGrouping.idBases
    }
}
