//
//  OperationsManager.swift
//  tawk
//
//  Created by Adnan Munir on 01/08/2021.
//

import Foundation

class OperationsManager {
    static let sharedInstance = OperationsManager()
    private init() { }
    lazy var downloadsInProgress: [Int: Operation] = [:]
    lazy var dataQueue: OperationQueue = {
      var queue = OperationQueue()
      queue.name = "Data Task queue"
      queue.maxConcurrentOperationCount = 1
      return queue
    }()
    
    
    func suspendAllOperations() {
        OperationsManager.sharedInstance.dataQueue.isSuspended = true
    }
    
    func resumeAllOperations() {
        OperationsManager.sharedInstance.dataQueue.isSuspended = false
    }
}
