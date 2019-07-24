//
//  Bundle+Extension.swift
//  EZBasicKit
//
//  Created by wangding on 2019/7/19.
//

import Foundation

extension Bundle {

    public func resourceBundle(_ resouceBundleName: String) -> Bundle? {
        guard let url = self.url(forResource: resouceBundleName, withExtension: "bundle") else { return nil }
        return Bundle(url: url)
    }
}

class EZBundleHelper: NSObject {}

extension Bundle {

    public static var ezBasicKitBundle: Bundle = {
        return Bundle(for: EZBundleHelper.self)
    }()

    public static var ezBasicKitResourceBundle: Bundle? {
        return Bundle.ezBasicKitBundle.resourceBundle("EZBasicKit")
    }
}
