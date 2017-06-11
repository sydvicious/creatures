//
//  PathfinderAbility.swift
//  Characters
//
//  Created by Syd Polk on 8/27/16.
//
//

import Foundation

class PathfinderAbility: d20Ability {
    static let AbilityCosts:[Int:Int] = [
        7: -4,
        8: -2,
        9: -1,
        10: 0,
        11: 1,
        12: 2,
        13: 3,
        14: 5,
        15: 7,
        16: 10,
        17: 13,
        18: 17
    ]

    override func save_transaction(_ transactions: TransactionsController, section: String, attribute: String, source: String, type: String, value: String, duration: Int) {
        let trans = Transaction(system: "Pathfinder", section: section, attribute: attribute, source: source, type: type, value: value, duration: duration)
        transactions.add(transaction: trans)
    }

}

