//
//  OptionsController.swift
//  EZBasicKit
//
//  Created by wangding on 2019/5/28.
//

import Foundation

open class OptionsController<Object: Hashable>: NSObject {

    public convenience init(options: [Object], selectedOption: Object?) {
        self.init(options: options)
        self.selectedOption = selectedOption
    }

    public init(options: [Object]) {
        self.options = options
        super.init()
    }

    public convenience init(options: [Object], selectedIndex: Int?) {
        self.init(options: options)
        self.selectedIndex = selectedIndex
    }

    public let options: [Object]

    open var selectedIndex: Int?

    open var selectedOption: Object? {
        get {
            if let selectedIndex = self.selectedIndex {
                return self.options[selectedIndex]
            } else {
                return nil
            }
        }

        set {
            if let selectedOption = newValue {
                for (index, option) in self.options.enumerated() {
                    if option == selectedOption {
                        self.selectedIndex = index
                        return
                    }
                }
                self.selectedIndex = nil
            } else {
                self.selectedIndex = nil
            }
        }
    }

    open func updateAsDefaultSelection() {
        if self.options.count == 0 {
            self.selectedIndex = nil
        } else {
            self.selectedIndex = 0
        }
    }
}
