//
//  IdentifiableWrapper.swift
//  Identifiable
//
//  Created by Rocke on 16/6/28.
//  Copyright © 2016年 L & L. All rights reserved.
//

import Foundation

public protocol IdentifiableWrapper: Identifiable {
    
    associatedtype Base
    
    var base: Base { get }
}

public protocol IDGeneratorWrapper: IdentifiableWrapper {
    
    var idGenerator: (Base) -> Identifier { get }
    
    init(base: Base, idGenerator: @escaping (Base) -> Identifier)
}

extension IDGeneratorWrapper {

    public var identifier: Identifier { return self.idGenerator(self.base) }
}

public struct IDEquatableWrapper<B, ID: Equatable>: IDGeneratorWrapper, Equatable {
    
    public typealias Identifier = ID
    public typealias Base = B

    public let base: B
    
    public let idGenerator: (B) -> ID
    
    public init(base: B, idGenerator: @escaping (B) -> ID) {
        self.base = base
        self.idGenerator = idGenerator
    }
}

public struct IDHashableWrapper<B, ID: Hashable>: IDGeneratorWrapper, Hashable {
    
    public typealias Identifier = ID
    public typealias Base = B
    
    public let base: Base
    
    public let idGenerator: (Base) -> Identifier
    
    public init(base: Base, idGenerator: @escaping (Base) -> Identifier) {
        self.base = base
        self.idGenerator = idGenerator
    }
}

public struct IDComparableWrapper<B, ID: Comparable & Hashable>: IDGeneratorWrapper, Hashable, Comparable {
    
    public typealias Identifier = ID
    public typealias Base = B
    
    public let base: Base
    
    public let idGenerator: (Base) -> Identifier
    
    public init(base: Base, idGenerator: @escaping (Base) -> Identifier) {
        self.base = base
        self.idGenerator = idGenerator
    }
}

extension Sequence where Iterator.Element: IdentifiableWrapper {

    public var idBases: [Iterator.Element.Base] {
        return self.map { $0.base }
    }
}

extension IDGeneratorWrapper {

    public static func makeWrappers<S: Sequence>(bases: S, idGenerator: @escaping (Self.Base) -> Self.Identifier) -> [Self]  where Self.Base == S.Iterator.Element {
        
        return bases.map { Self.init(base: $0, idGenerator: idGenerator) }
    }
}
