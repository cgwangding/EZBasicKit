//
//  SelectionDemoViewController.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/6/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class SelectionDemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var controller: ProductController = ProductController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controller.loadData()
    }

    @IBAction func nextBtnDidTapped(_ sender: UIButton) {
        let selectedObjects = controller.selection.selectedObjects
        guard !selectedObjects.isEmpty else {
//            self.presentAlert(title: "", message: "Please select one before click next", buttontitle: "OK")
            return
        }
        selectedObjects.forEach { (obj) in
            print(obj.identifier)
        }
    }
}

extension SelectionDemoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionCell", for: indexPath)
        
        if let obj = controller.objects.object(at: indexPath.row) {
            let title = cell.viewWithTag(200) as? UILabel
            title?.text = "\(obj.identifier)"
            let btn = cell.viewWithTag(201) as? UIButton
            btn?.isSelected = controller.selection.isSelected(obj)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let obj = controller.objects.object(at: indexPath.row) {
            let isSelected = controller.selection.isSelected(obj)
            controller.selection.setSelected(!isSelected, forObject: obj)
            tableView.reloadData()
        }
    }
}
