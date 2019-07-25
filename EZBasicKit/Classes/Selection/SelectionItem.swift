//
//  SelectionItem.swift
//  ezbuy
//
//  Created by Rocke on 16/7/14.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

public struct SelectionItem<S: ObjectsSelection> {

    public let object: S.Object

    fileprivate(set) public weak var selection: S?

    public var isSelected: Bool {
        get {
            return self.selection?.isSelected(self.object) ?? false
        }
        set {
            self.selection?.setSelected(newValue, forObject: self.object)
        }
    }

    public init(object: S.Object, selection: S) {
        self.object = object
        self.selection = selection
    }
}
