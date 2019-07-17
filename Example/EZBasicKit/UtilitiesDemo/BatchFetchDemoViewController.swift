//
//  BatchFetchDemoViewController.swift
//  EZBasicKit_Example
//
//  Created by ezbuy on 2019/6/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EZBasicKit

class BatchFetchDemoViewController: UITableViewController {
    
    fileprivate let fatchController = BatchFetchController()
    
    var resultController: ResultDataController = ResultDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 44
        fatchController.fetchDelegate = self
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData() {
        let _ = resultController.reload(completion: { (_) in
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
}

extension BatchFetchDemoViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultController.objects.count 
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath)
        let emoji = resultController.objects.object(at: indexPath.row)?.code
        if let data = emoji?.data(using: .nonLossyASCII) {
            let valueUnicode = String(data: data, encoding: .utf8)
            if let versaData = valueUnicode?.data(using: .utf8) {
                cell.textLabel?.text = String(data: versaData, encoding: .nonLossyASCII)
            }
        }
        
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.fatchController.batchFetchIfNeeded(for: scrollView)
    }
}

extension BatchFetchDemoViewController: BatchFetchControllerDelegate {
    
    func shouldBatchFetch(for scrollView: UIScrollView) -> Bool {
        return resultController.hasMore 
    }
    
    func scrollView(_ scrollView: UIScrollView, willBeginBatchFetchWith context: BatchFetchContext) {
        
        let processing = resultController.loadMore(completion: { (inserted) -> Void in
            
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

class ResultDataController: OffsetBasedObjectsController<Emoji> {
    
    override func loadObjects(atOffset offset: Int, limit: Int, completion: @escaping (([Emoji]) -> Void), failure: @escaping (Error) -> Void) -> Bool {
        
        var emojis: [Emoji] = []
        
        
        for i in (offset)..<(offset + limit) {
            
            if let emojiCode = list().object(at: i) {
                let emoji = Emoji(code: emojiCode)
                debugPrint(emoji.code)
                emojis.append(emoji)
            }
        }
        
        completion(emojis)
        
        return true
    }
    
    func loadObjectAndCheckMore(atOffset offset: Int, limit: Int, completion: @escaping ([Emoji], Bool) -> Void, failure: @escaping (Error) -> Void) -> Bool {
        
        let newLimit = limit + 1
        
        return self.loadObjects(atOffset: offset, limit: newLimit, completion: { (objects) -> Void in
            
            var items = objects
            let hasMore: Bool
            if items.count > 21 {
                hasMore = false
            } else {
                hasMore = true
                items.removeSubrange(limit..<items.count)
            }
            completion(items, hasMore)
            
        }, failure: failure)
    }
}

class Emoji: NSObject {
    
    let code: String
    init(code: String) {
        self.code = code
        super.init()
    }
}

/// List all emojis
public func list() -> [String] {
    let ranges = [
        0x1F601...0x1F64F,
        0x2600...0x27B0,
        0x23F0...0x23FA,
        0x1F680...0x1F6C0,
        0x1F170...0x1F251
    ]
    
    var all = ranges.joined().map {
        return String(Character(UnicodeScalar($0)!))
    }
    
    //⌚️⌨️⭐️
    let solos = [0x231A, 0x231B, 0x2328, 0x2B50]
    all.append(contentsOf: solos.map({ String(Character(UnicodeScalar($0)!))}))
    
    return all
}
