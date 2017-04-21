//
//  Ability.swift
//  Characters
//
//  Created by Syd Polk on 8/27/16.
//
//

import Foundation

class Ability: TransactionsProtocol {
    private var _name: String
    private var _baseScore: Int
    
    var baseScore: Int {
        get {
            return self._baseScore
        }
    }
    
    init(name: String, score: Int, transactions: TransactionsController) {
        self._name = name
        if (score < 0) {
            self._baseScore = 0
        } else {
            self._baseScore = score
        }
        save_transaction(transactions, section: "ability", attribute: name, source: "creation", type: "base", value: String(score), duration: -1)
    }
    
    func save_transaction(_ transactions: TransactionsController, section: String, attribute: String, source: String, type: String, value: String, duration: Int) {
        let trans = Transaction(system: "", section: section, attribute: attribute, source: source, type: type, value: value, duration: duration)
        transactions.add(transaction: trans)
    }
}

