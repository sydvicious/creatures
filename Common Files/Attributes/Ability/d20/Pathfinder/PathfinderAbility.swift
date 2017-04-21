//
//  PathfinderAbility.swift
//  Characters
//
//  Created by Syd Polk on 8/27/16.
//
//

import Foundation

class PathfinderAbility: d20Ability {

    override func save_transaction(_ transactions: TransactionsController, section: String, attribute: String, source: String, type: String, value: String, duration: Int) {
        let trans = Transaction(system: "Pathfinder", section: section, attribute: attribute, source: source, type: type, value: value, duration: duration)
        transactions.add(transaction: trans)
    }

}

