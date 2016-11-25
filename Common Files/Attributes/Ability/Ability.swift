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
    
    var baseScore: Int {
        get {
            return self._baseScore
        }
        set {
            if newValue < 0 {
                self._baseScore = 0
            } else {
                self._baseScore = newValue
            }
        }
    }
    
    init(name: String, score: Int) {
        self._name = name
        if (score < 0) {
            self._baseScore = 0
        } else {
            self._baseScore = score
        }
    }
    
    func transactions() -> [Transaction] {
        let baseScoreTransaction = Transaction(section: "abilities", source: "ability", attribute: self._name, subattribute: "base", value: String(self._baseScore), duration: -1)
        return [baseScoreTransaction]
    }
}

