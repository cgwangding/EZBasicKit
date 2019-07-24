//
//  EZBasicKit.swift
//  EZBasicKit
//
//  Created by qiuming on 2019/6/21.
//

import Foundation

public class EZBasicKit: NSObject {
    
    public static func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UIButton.methodSwizzling()
        
        return true
    }
}


