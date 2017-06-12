//
//  TransactionsController.swift
//  Characters
//
//  Created by Syd Polk on 11/13/16.
//  Copyright (c) 2016-2017 Bone Jarring Games and Software, LLC. All rights reserved.
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
