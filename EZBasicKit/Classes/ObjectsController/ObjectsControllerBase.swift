//
//  ObjectsControllerBase.swift
//  ezbuy
//
//  Created by YangFan on 16/6/11.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

open class ObjectsControllerBase<Object>: AbstractObjectsController<Object> {

    fileprivate var _objects: [Object] = []

    open override var objects: [Object] {
        get {
            return self._objects
        }
        set {
            self._objects = newValue
        }
    }

    fileprivate var _hasMore: Bool = true

    open override var hasMore: Bool {
        get {
            return self._hasMore
        }
        set {
            self._hasMore = newValue
        }
    }

    public override init() {
        super.init()
    }

    open override func clearObjects() {
        self.objects = []
        self.hasMore = true
    }
}
