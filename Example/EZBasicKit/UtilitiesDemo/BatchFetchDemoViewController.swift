//
//  BatchFetchDemoViewController.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/6/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class BatchFetchDemoViewController: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView(frame: self.view.bounds)
        return table
    }()
    
    fileprivate let fatchController = BatchFetchController()
    
    var resultController: ResultDataController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
        fatchController.fetchDelegate = self
    }
}

extension BatchFetchDemoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.fatchController.batchFetchIfNeeded(for: scrollView)
    }
}

extension BatchFetchDemoViewController: BatchFetchControllerDelegate {
    
    func shouldBatchFetch(for scrollView: UIScrollView) -> Bool {
        return resultController?.hasMore ?? false
    }
    
    func scrollView(_ scrollView: UIScrollView, willBeginBatchFetchWith context: BatchFetchContext) {
        
        let processing = resultController?.loadMore(completion: { (inserted) -> Void in
            
            self.tableView.reloadData()
            
            context.completeBatchFetching()
            
        }, failure: { (error) -> Void in
            
            context.completeBatchFetching()
        }) ?? false
        
        if processing {
            context.beginBatchFetching()
        }
    }
}

class ResultDataController: OffsetBasedObjectsController<NSObject> {}
