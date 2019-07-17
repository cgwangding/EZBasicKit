//
//  OneRequestObjectsControllerDemo.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/7/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class OneRequestObjectsControllerDemo: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var controller: AbstractObjectsController<Emoji> = {
        
        let control = EmojiListController()
        
        let reval = OneRequestObjectsController(control)
        
        return reval
    }()
    
    fileprivate let fatchController = BatchFetchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        fatchController.fetchDelegate = self
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData() {
        let _ = controller.reload(completion: { (_) in
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.fatchController.batchFetchIfNeeded(for: scrollView)
    }
}

extension OneRequestObjectsControllerDemo: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OneRequestDemoCell", for: indexPath)
        let emoji = controller.objects.object(at: indexPath.row)
        cell.textLabel?.text = emoji?.code
        
        return cell
    }
}

extension OneRequestObjectsControllerDemo: BatchFetchControllerDelegate {
    
    func shouldBatchFetch(for scrollView: UIScrollView) -> Bool {
        return controller.hasMore
    }
    
    func scrollView(_ scrollView: UIScrollView, willBeginBatchFetchWith context: BatchFetchContext) {
        
        let processing = controller.loadMore(completion: { (inserted) -> Void in
            //asyncAfter method is to imitate http requst, when you have real http request, delete this method
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.tableView.reloadData()
                context.completeBatchFetching()
            }
            
        }, failure: { (error) -> Void in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                context.completeBatchFetching()
            }
        })
        
        if processing {
            context.beginBatchFetching()
        }
    }
}
