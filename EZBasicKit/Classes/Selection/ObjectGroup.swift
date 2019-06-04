//
//  ObjectGroup.swift
//  ezbuy
//
//  Created by Rocke on 16/7/14.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import Foundation

public struct ObjectGroup<G, O> {

    public var title: String = ""
    public let identifer: G
    public let objects: [O]
}

extension ObjectGroup {

    init(identifer: G, objects: [O]) {
        self.identifer = identifer
        self.objects = objects
    }
}
