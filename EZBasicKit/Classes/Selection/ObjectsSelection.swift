//
//  ObjectsSelection.swift
//  ezbuy
//
//  Created by Rocke on 16/7/14.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

public protocol ObjectsSelection: class {

    associatedtype Source: ObjectsContainer

    associatedtype Object = Source.Object

    var source: Source? { get set }

    var selectedObjects: [Object] { get }

    func isSelected(_ o: Object) -> Bool

    @discardableResult
    func setSelected(_ selected: Bool, forObject object: Object) -> Bool

    var count: Int { get }

    func clear()

    func setSelected<S: Sequence>(_ selected: Bool, forObjects objects: S) -> Bool where S.Iterator.Element == Object

    func updateIfSourceAvaiable()
}

extension ObjectsSelection {

    public func makeItem(_ object: Object) -> SelectionItem<Self> {
        return SelectionItem(object: object, selection: self)
    }
}

extension ObjectsSelection {

    public func updateIfSourceAvaiable() {

    }

}

extension ObjectsSelection {

    public var isAllSelected: Bool {

        guard let source = self.source else { return false }

        return source.objects.count > 0 && source.objects.count <= self.count
    }
}

//extension ObjectsSelection {
//
//    @discardableResult
//    public func setSelected<S: Sequence>(_ selected: Bool, forObjects objects: S) -> Bool where S.Iterator.Element == Object {
//
//        var changed = false
//        for o in objects {
//            let oChanged = self.setSelected(selected, forObject: o)
//            changed = changed || oChanged
//        }
//        return changed
//    }
//}

extension ObjectsSelection {

    @discardableResult
    public func select(_ object: Object) -> Bool {
        return self.setSelected(true, forObject: object)
    }

    @discardableResult
    public func deselect(_ object: Object) -> Bool {
        return self.setSelected(false, forObject: object)
    }
}
