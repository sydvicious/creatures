//
//  TransactionsController.swift
//  Characters
//
//  Created by Syd Polk on 11/13/16.
//
//

import Foundation

class TransactionsController: NSObject {
    private var _pending = [Transaction]()
    
    override init() {
        super.init()
    }

    func add(transaction: Transaction) {
        _pending.append(transaction)
    }
    
    func pendingTransactions() -> [Transaction] {
        return _pending
    }
    
    func clearPendingTransactions() {
        _pending = [Transaction]()
    }
}
