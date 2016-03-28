//
//  Piper.swift
//  Piper
//
//  Created by Bradley Hilton on 2/1/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import Foundation

public protocol Finally {
    
    associatedtype Result
    func finally(queue: NSOperationQueue, handler: Result -> Void)
    
}

public struct EmptyOperation : Finally {
    
    public func finally(queue: NSOperationQueue, handler: Void -> Void) {
        queue.addOperationWithBlock { handler() }
    }
    
}

public struct Operation<Input : Finally, Out> : Finally {
    
    var input: Input
    var operation: Input.Result -> Out
    var queue: NSOperationQueue
    
    public func finally(queue: NSOperationQueue = NSOperationQueue.mainQueue(), handler: Out -> Void) {
        input.finally(self.queue) { input in
            let out = self.operation(input)
            queue.addOperationWithBlock {
                handler(out)
            }
        }
    }
    
    public func main<T>(operation: Out -> T) -> Operation<Operation, T> {
        return queue(NSOperationQueue.mainQueue(), operation: operation)
    }
    
    public func background<T>(operation: Out -> T) -> Operation<Operation, T> {
        return queue(NSOperationQueue(), operation: operation)
    }
    
    public func queue<T>(queue: NSOperationQueue, operation: Out -> T) -> Operation<Operation, T> {
        return Operation<Operation, T>(input: self, operation: operation, queue: queue)
    }
    
    public func execute() {
        finally(NSOperationQueue()) { _ in }
    }
    
}

public func main<T>(operation: Void -> T) -> Operation<EmptyOperation, T> {
    return queue(NSOperationQueue.mainQueue(), operation: operation)
}

public func background<T>(operation: Void -> T) -> Operation<EmptyOperation, T> {
    return queue(NSOperationQueue(), operation: operation)
}

public func queue<T>(queue: NSOperationQueue, operation: Void -> T) -> Operation<EmptyOperation, T> {
    return Operation<EmptyOperation, T>(input: EmptyOperation(), operation: operation, queue: queue)
}
