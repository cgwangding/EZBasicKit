//
//  PresentationDemoViewController.swift
//  EZBasicKit_Example
//
//  Created by qiuming on 2019/7/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension PresentationDemoViewController {
    class func make() -> PresentationDemoViewController {
        return UIStoryboard.presentation.instance(for: PresentationDemoViewController.self)
    }
}

class PresentationDemoViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


