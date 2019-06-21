//
//  OffsetBasedObjectsControllerDemo.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/6/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class OffsetBasedObjectsControllerDemo: UITableViewController {
    
    fileprivate let fatchController = BatchFetchController()
    
    fileprivate let controller = EmojiListController()

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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.fatchController.batchFetchIfNeeded(for: scrollView)
    }
}

extension OffsetBasedObjectsControllerDemo: BatchFetchControllerDelegate {
    
    func shouldBatchFetch(for scrollView: UIScrollView) -> Bool {
        print("=========\(controller.hasMore)")
        return controller.hasMore
    }
    
    func scrollView(_ scrollView: UIScrollView, willBeginBatchFetchWith context: BatchFetchContext) {
        
        let processing = controller.loadMore(completion: { (inserted) -> Void in
            
            self.tableView.reloadData()
            
            context.completeBatchFetching()
            
        }, failure: { (error) -> Void in
            
            context.completeBatchFetching()
        })
        
        if processing {
            context.beginBatchFetching()
        }
    }
}

extension OffsetBasedObjectsControllerDemo {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OffsetBaseObjectsControllerCell", for: indexPath)
        let emoji = controller.objects.object(at: indexPath.row)
        cell.textLabel?.text = emoji?.code
        
        return cell
    }
}

class EmojiListController: OffsetBasedObjectsController<Emoji> {
    
    override func loadObjects(atOffset offset: Int, limit: Int, completion: @escaping (([Emoji]) -> Void), failure: @escaping (Error) -> Void) -> Bool {
        
        //request sever to load data
        var emojis: [Emoji] = []
        
        for i in (offset)..<(offset + limit) {
            
            if let emojiCode = list().object(at: i) {
                let emoji = Emoji(code: emojiCode)
                emojis.append(emoji)
            }
        }
        
        emojis.forEach { (emoji) in
            debugPrint(emoji.code)
        }
        completion(emojis)
        return true
    }
}
