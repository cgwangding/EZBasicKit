//
//  CollectionType+Identifiable.swift
//  Identifiable
//
//  Created by Rocke on 16/6/28.
//  Copyright © 2016年 L & L. All rights reserved.
//

import Foundation

extension Collection where Index: Hashable, Indices.Iterator.Element == Index {
    
    public var indexMapping: [Index: Iterator.Element] {
        
        var mapping: [Index: Iterator.Element] = [:]
        
        let indices = self.indices
        for (index, element) in zip(indices, self) {
            mapping[index] = element
        }
        return mapping
    }
}

extension Collection where Iterator.Element: Hashable, Indices.Iterator.Element == Index {
    
    public var reversedIndexMapping: [Iterator.Element: [Index]] {
        
        var mapping: [Iterator.Element: [Index]] = [:]
    
        for (index, element) in zip(self.indices, self) {
            var indices = mapping[element] ?? []
            indices.append(index)
            mapping[element] = indices
        }
        return mapping
    }
}

extension RangeReplaceableCollection where Index: Comparable {

    public mutating func remove<S: Sequence>(at indices: S) where S.Iterator.Element == Index {
        let sortedIndices = Array(indices).sorted(by: >)
        for index in sortedIndices {
            self.remove(at: index)
        }
    }
}

extension RangeReplaceableCollection where Iterator.Element: Hashable, Index: Hashable, Index: Comparable, Indices.Iterator.Element == Index {
    
    public mutating func remove<S: Sequence>(_ sequence: S) where Iterator.Element == S.Iterator.Element {
        
        let reversedIndexMapping = self.reversedIndexMapping
        
        let bag: [Iterator.Element: Int] = {
        
            var reval: [Iterator.Element: Int] = [:]
            sequence.forEach { element in
                let count = reval[element] ?? 0
                reval[element] = count + 1
            }
            return reval
        }()
        
        let foundIndices: [Index] = reversedIndexMapping.flatMap { (element, indices) -> ArraySlice<Index> in
            let count = bag[element] ?? 0
            return indices[0 ..< Swift.min(count, indices.count)]
        }
        
        self.remove(at: foundIndices)
    }
}

extension RangeReplaceableCollection where Iterator.Element: Hashable, Index: Hashable, Index: Comparable, Indices.Iterator.Element == Index {
    
    public mutating func removeRedundant() {
        
        let redundantIndices = self.reversedIndexMapping.values.flatMap { (indices) -> [Index] in
            if indices.count > 1 {
                return Array(indices[1..<indices.count])
            } else {
                return []
            }
        }
        
        self.remove(at: redundantIndices)
    }
}
