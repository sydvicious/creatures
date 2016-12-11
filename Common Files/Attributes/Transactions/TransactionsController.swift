//
//  TransactionsController.swift
//  Characters
//
//  Created by Syd Polk on 11/13/16.
//
//

import UIKit

class TransactionsController: NSObject {
    private var _pending: [Transaction]
    
    override init() {
        _pending = [Transaction]()
        super.init()
    }

    func add(transaction: Transaction) {
        _pending.append(transaction)
    }

    func flushTransactions() {
        // Write to the CoreData model
    }
    
    func replayTransactions(parser: (Transaction)->()) {
        // Read from CoreData model and use the parser callback to enclosing object controller.
    }
    
}
