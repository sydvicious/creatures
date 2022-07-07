//
//  Ability.swift
//  Characters
//
//  Created by Syd Polk on 8/27/16.
//  Copyright (c) 2016-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//  Copyright © 2022 Syd Polk (reassigned). All rights reserved.
//

import Foundation

class Ability: TransactionsProtocol, Equatable, Hashable {
    
    private var _ability: Abilities
    private var _baseScore: Int

    var name: String {
        get {
            return self._ability.rawValue
        }
    }
    var baseScore: Int {
        get {
            return self._baseScore
        }
    }

    var currentScore: Int {
        get {
            return baseScore
        }
    }

    init(key: Abilities, score: Int) {
        self._ability = key
        if (score < 0) {
            self._baseScore = 0
        } else {
            self._baseScore = score
        }
    }

    convenience init(key: Abilities, score: Int, transactions: TransactionsController) {
        self.init(key: key, score:score)
        save_transaction(transactions, section: "ability", attribute: key.rawValue, source: "creation", type: "base", value: String(score), duration: -1)
    }
    
    func save_transaction(_ transactions: TransactionsController, section: String, attribute: String, source: String, type: String, value: String, duration: Int) {
        let trans = Transaction(system: "", section: section, attribute: attribute, source: source, type: type, value: value, duration: duration)
        transactions.add(transaction: trans)
    }
    
    static func == (lhs: Ability, rhs: Ability) -> Bool {
        return lhs._ability == rhs._ability && lhs._baseScore == rhs._baseScore
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(_ability)
        hasher.combine(_baseScore)
    }
}


