//
//  AbstractObjectsController.swift
//  ezbuy
//
//  Created by YangFan on 16/6/11.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

open class AbstractObjectsController<Object>: NSObject, ObjectsController {

    open var objects: [Object] { return [] }

    open var hasMore: Bool { return false }

    open func clearObjects() { }

    open func reload(completion: @escaping ([Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool { return false }

    open func loadMore(completion: @escaping (_ inserted: [Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool { return false }
}
