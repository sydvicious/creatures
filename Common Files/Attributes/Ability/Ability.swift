//
//  Ability.swift
//  Characters
//
//  Created by Syd Polk on 8/27/16.
//
//

import UIKit

class Ability: TransactionsProtocol {
    private var _name: String
    private var _baseScore: Int
    private let _trans: TransactionsController
    
    var baseScore: Int {
        get {
            return self._baseScore
        }
    }
    
    init(name: String, score: Int, trans: TransactionsController) {
        self._name = name
        self._trans = trans
        if (score < 0) {
            self._baseScore = 0
        } else {
            self._baseScore = score
        }
        trans.add(transaction: Transaction(section: "ability", source: "creation", attribute: self._name, subattribute: "base", value: String(baseScore), duration: -1))
    }
}

