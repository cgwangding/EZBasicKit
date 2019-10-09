//
//  UITableViewExtensionController.swift
//  EZBasicKit_Example
//
//  Created by qiuming on 2019/6/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class UITableViewExtensionController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.requireScrollsToTop()
    }
    
    @IBAction func topButtonTapped(_ sender: UIButton) {
        self.tableView.scrollToTop()
    }
}

extension UITableViewExtensionController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        let titleLabel = cell.viewWithTag(3001) as? UILabel
        let button     = cell.viewWithTag(3002) as? UIButton
        
        titleLabel?.text = "测试数据\(indexPath.row)"
        button?.setTitle("当前为第\(indexPath.row)", for: .normal)
        button?.addTarget(self, action: #selector(touchMe(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func touchMe(_ sender: UIButton) {

        if let indexPath = self.tableView.indexPath(for: sender), let topindexPath = self.tableView.topIndexPath {
            let message = "topIndexPath - \(topindexPath)" + "\n" + "currentIndexPath - \(indexPath)"
//            self.presentAutoDismissAlert(message: message, delay: 0.5, finished: nil)
        }
    }
    
    
}
