//
//  ObjectsController.swift
//  ezbuy
//
//  Created by Rocke on 15/11/26.
//  Copyright © 2015年 com.ezbuy. All rights reserved.
//

import UIKit

public protocol ObjectsController {

    associatedtype Object

    var objects: [Object] { get }

    var hasMore: Bool { get }

    func clearObjects()

    func reload(completion: @escaping ([Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool

    func loadMore(completion: @escaping (_ inserted: [Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool
}
