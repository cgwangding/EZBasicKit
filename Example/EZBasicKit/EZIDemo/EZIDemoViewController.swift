//
//  EZIDemoViewController.swift
//  EZBasicKit_Example
//
//  Created by wangding on 2019/5/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class EZIDemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var source: [String] = ["ezbuyapp://home", "http://home.com", "ezbuyint://home"]

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

        
    }
}
