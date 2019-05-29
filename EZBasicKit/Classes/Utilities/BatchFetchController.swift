//
//  BatchFetchController.swift
//  ezbuy
//
//  Created by Arror on 2017/2/23.
//  Copyright © 2017年 com.ezbuy. All rights reserved.
//

import UIKit

public protocol BatchFetchControllerDelegate: class {
    
    func shouldBatchFetch(for scrollView: UIScrollView) -> Bool
    
    func scrollView(_ scrollView: UIScrollView, willBeginBatchFetchWith context: BatchFetchContext)
}

public class BatchFetchController {
    
    let context: BatchFetchContext
    
    public let leadingScreensForBatching: CGFloat
    
    public init(leadingScreensForBatching: CGFloat = 2.0) {
        
        self.leadingScreensForBatching = leadingScreensForBatching
        self.context = BatchFetchContext()
    }
    
    public weak var fetchDelegate: BatchFetchControllerDelegate?
    
    public func batchFetchIfNeeded(for scrollView: UIScrollView) {
        
        guard let delegate = self.fetchDelegate else { return }
        
        let scrollViewHeight            = scrollView.bounds.height
        let scrollViewContentHeight     = scrollView.contentSize.height
        let scrollViewContentOffsetY    = scrollView.contentOffset.y
        
        if (scrollViewContentHeight - scrollViewContentOffsetY - (self.leadingScreensForBatching + 1) * scrollViewHeight < 0) {
            
            guard delegate.shouldBatchFetch(for: scrollView), !self.context.isFetching else { return }
            
            delegate.scrollView(scrollView, willBeginBatchFetchWith: self.context)
        }
    }
}

public class BatchFetchContext {
    
    private var _isFetching: Bool
    
    private(set) var isFetching: Bool {
        get {
            objc_sync_enter(self)
            
            defer { objc_sync_exit(self) }
            
            return self._isFetching
        }
        set {
            objc_sync_enter(self)
            
            defer { objc_sync_exit(self) }
            
            self._isFetching = newValue
        }
    }
    
    public init() {
        self._isFetching = false
    }
    
    public func beginBatchFetching() {
        isFetching = true
    }
    
    public func completeBatchFetching() {
        isFetching = false
    }
}
