//
//  SetSelection.swift
//  Selection
//
//  Created by Rocke on 16/5/31.
//  Copyright © 2016年 ezbuy. All rights reserved.
//

import Foundation

open class SetSelection<Source: ObjectsContainer>: ObjectsSelection where Source.Object: Hashable {

    open weak var source: Source?

    public var selection: Set<Source.Object> = []

    open var selectedObjects: [Source.Object] {
        return selection.map { $0 }
    }

    open func isSelected(_ o: Source.Object) -> Bool {
        return self.selection.contains(o)
    }

    public init() {

    }

    open var count: Int { return self.selection.count }

    @discardableResult
    open func setSelected(_ selected: Bool, forObject object: Source.Object) -> Bool {

        guard self.isSelected(object) != selected else { return false }

        if selected {
            self.selection.insert(object)
        } else {
            self.selection.remove(object)
        }
        return true
    }

    open func clear() {
        self.selection.removeAll()
    }

    open func updateIfSourceAvaiable() {
        guard let source = self.source else { return }

        let intersectedselection: Set<Object> = {
            var reval = Set<Object>()

            for item in source.objects {
                if self.isSelected(item) {
                    reval.insert(item)
                }
            }

            return reval
        }()

        self.selection = intersectedselection
    }

    @discardableResult
    public func setSelected<S>(_ selected: Bool, forObjects objects: S) -> Bool where S : Sequence, Source.Object == S.Element {

        var changed = false
        for o in objects {
            let oChanged = self.setSelected(selected, forObject: o)
            changed = changed || oChanged
        }
        return changed
    }
}
