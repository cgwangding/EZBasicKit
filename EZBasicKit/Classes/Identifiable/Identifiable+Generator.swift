//
//  Identifiable+Generator.swift
//  Identifiable
//
//  Created by Rocke on 16/6/28.
//  Copyright © 2016年 L & L. All rights reserved.
//

import Foundation

extension EZIdentifiable {

    public static var idGenerator: (Self) -> Identifier { return { $0.identifier } }
}
