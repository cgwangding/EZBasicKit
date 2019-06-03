//
//  EZINode.swift
//  ezbuy
//
//  Created by Rocke on 16/8/29.
//  Copyright © 2016年 com.ezbuy. All rights reserved.
//

import UIKit

public protocol EZINode {
    
    var eziHandleable: EZIHandleable? { get }
    
    func handlerInChain(forEZI instruction: EZInstruction, fromFirstNode: Bool) -> EZIHandlerAction
    
    var nextEZINode: EZINode? { get }
    
    var firstEZINode: EZINode { get }
}

extension EZINode {

    public func handlerInChain(forEZI instruction: EZInstruction) -> EZIHandlerAction {
        return self.handlerInChain(forEZI: instruction, fromFirstNode: false)
    }
    
    public func handlerFromFirstNodeInChain(forEZI instruction: EZInstruction) -> EZIHandlerAction {
        return self.handlerInChain(forEZI: instruction, fromFirstNode: true)
    }
}

extension EZINode where Self: EZIHandleable {

    public var eziHandleable: EZIHandleable? { return self }
}

extension EZINode where Self: UIResponder {

    public var nextEZINode: EZINode? {
                
        var next = self.next

        while next != nil {
            if let node = next as? EZINode {
                return node
            }
            next = next?.next
        }
        return nil
    }
}


extension EZINode {

    public func handlerInChain(forEZI instruction: EZInstruction, fromFirstNode: Bool) -> EZIHandlerAction {

        if fromFirstNode {
            return self.firstEZINode.handlerInChain(forEZI: instruction, fromFirstNode: false)
        } else {
            if let action = self.eziHandleable?.handler(forEZI: instruction), action.isHandling {
                return action
            } else {
                return self.nextEZINode?.handlerInChain(forEZI: instruction, fromFirstNode: false) ?? .ignoring
            }
        }
    }
    
    public var firstEZINode: EZINode { return self }
}
