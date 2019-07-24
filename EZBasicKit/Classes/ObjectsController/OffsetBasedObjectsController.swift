//
//  OffsetBasedObjectsController.swift
//  ezbuy
//
//  Created by Rocke on 16/3/16.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

open class OffsetBasedObjectsController<Object>: ObjectsControllerBase<Object> {

    public override init() {
        super.init()
    }

    open var limit: Int = 20

    private func loadObjectAndCheckMore(atOffset offset: Int, limit: Int, completion: @escaping ([Object], Bool) -> Void, failure: @escaping (Error) -> Void) -> Bool {

        let newLimit = limit + 1

        return self.loadObjects(atOffset: offset, limit: newLimit, completion: { (objects) -> Void in

            var items = objects
            let hasMore: Bool
            if items.count > limit {
                hasMore = true
                items.removeSubrange(limit..<items.count)
            } else {
                hasMore = false
            }
            completion(items, hasMore)

        }, failure: failure)
    }

    open func loadObjects(atOffset offset: Int, limit: Int, completion: @escaping (([Object]) -> Void), failure: @escaping (Error) -> Void) -> Bool {

        fatalError("Not Implemented")
    }

    open override func reload(completion: @escaping ([Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool {

        return loadObjectAndCheckMore(atOffset: 0, limit: self.limit, completion: { (objects, hasMore) -> Void in

            self.objects = objects
            self.hasMore = hasMore

            completion(objects)

            }, failure: failure)
    }

    public final override func loadMore(completion: @escaping (_ inserted: [Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool {

        if !self.hasMore {
            return false
        }

        return self.loadObjectAndCheckMore(atOffset: self.objects.count, limit: self.limit, completion: { (objects, hasMore) -> Void in
            self.objects.append(contentsOf: objects)
            self.hasMore = hasMore
            completion(objects)
        }, failure: failure)
    }
}
