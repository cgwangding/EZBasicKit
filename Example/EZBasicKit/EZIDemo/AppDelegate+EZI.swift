//
//  AppDelegate+EZI.swift
//  EZBasicKit_Example
//
//  Created by wangding on 2019/5/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import EZBasicKit

extension AppDelegate: EZINode {}

extension AppDelegate: EZIDispatchable {

    func handleHome(_ wrapper: EZIWrapper) -> EZIHandlerAction {

        return .handling({
            debugPrint("ezi handle in AppDelegate")
        })
    }

}
