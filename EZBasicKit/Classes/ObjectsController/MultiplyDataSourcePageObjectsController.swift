//
//  MultiplyDataSourcePageObjectsController.swift
//  ezbuyKit
//
//  Created by Enjoy on 2018/12/24.
//  Copyright © 2018 com.ezbuy. All rights reserved.
//

import UIKit

open class MultiplyDataSourcePageObjectsController<Object>: ObjectsControllerBase<Object> {
    
    private var offset: Int = 0
    private var limit: Int = 20
    
    open func loadObjects(atOffset offset: Int, limit: Int, completion: @escaping (([Object]) -> Void), failure: @escaping (Error) -> Void) -> Bool {
        
        fatalError("Not Implemented")
    }
    
    private func loadObjectAndCheckMore(atOffset offset: Int, limit: Int, completion: @escaping ([Object], Bool) -> Void, failure: @escaping (Error) -> Void) -> Bool {
        
        return self.loadObjects(atOffset: offset, limit: limit, completion: { (objects) -> Void in
            
            let hasMore: Bool
            
            if objects.count < limit {
                hasMore = false
            } else {
                hasMore = true
            }
            completion(objects, hasMore)
            
        }, failure: failure)
    }
    
    
    open override func reload(completion: @escaping ([Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool {
        
        self.offset = 0
        
        return loadObjectAndCheckMore(atOffset: self.offset, limit: self.limit, completion: { (objects, hasMore) -> Void in
            
            self.objects = objects
            self.hasMore = hasMore
            self.offset += self.limit
            
            completion(objects)
            
        }, failure: failure)
    }
    
    public final override func loadMore(completion: @escaping (_ inserted: [Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool {
        
        if !self.hasMore {
            return false
        }
        
        return self.loadObjectAndCheckMore(atOffset: self.offset, limit: self.limit, completion: { (objects, hasMore) -> Void in
            self.objects.append(contentsOf: objects)
            self.hasMore = hasMore
            self.offset += self.limit
            
            completion(objects)
        }, failure: failure)
    }
    
}
