//
//  TestViewController.swift
//  EZBasicKit_Example
//
//  Created by qiuming on 2019/6/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension TestViewController {
    static func make() -> TestViewController {
        return UIStoryboard(name: "UIKitExtension", bundle: nil).instance(for: TestViewController.self)
    }
}

class TestViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    

   @IBAction func testButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(TestViewController.make(), animated: true)
    }

}
