//
//  EZIDemoViewController.swift
//  EZBasicKit_Example
//
//  Created by wangding on 2019/5/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import EZBasicKit

class EZIDemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var source: [String] = ["ezbuyapp://home"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension EZIDemoViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.source.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EZIDataCell", for: indexPath)
        cell.textLabel?.text = self.source[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let url = self.source[indexPath.row]
        if let ezi = EZInstruction(URL(string: url), bridgeOptions: [.ezbuyApp]) {
            let action = self.handlerInChain(forEZI: ezi, fromFirstNode: false)
            debugPrint(action)
            action.handle()
        }
    }
}

//extension EZIDemoViewController: EZIDefaultDispatchable {}
