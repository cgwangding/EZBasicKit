//
//  MaxLimitObjectsController.swift
//  ezbuy
//
//  Created by Rocke on 16/3/16.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

open class MaxLimitObjectsController<Base: ObjectsController>: ObjectsControllerBox<Base> {

    public let maxLimit: Int

    public init(_ base: Base, maxLimit: Int) {
        self.maxLimit = maxLimit
        super.init(base)
    }

    open override var hasMore: Bool {
        return self.base.objects.count < self.maxLimit && self.base.hasMore
    }

    open override func loadMore(completion: @escaping (_ inserted: [Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool {

        let count = self.objects.count

        let gap = self.maxLimit - count

        guard gap > 0 else { return false }

        return self.base.loadMore(completion: { (inserted) -> Void in

            completion(inserted)
            }, failure: failure)
    }
}
