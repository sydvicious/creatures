//
//  Creature.swift
//  Characters
//
//  Created by Syd Polk on 10/16/16.
//  Copyright (c) 2016-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//  Copyright © 2022 Syd Polk (reassigned). All rights reserved.
//

import UIKit

enum CreaturesTransactionActions: String, CaseIterable {
    case creation
}

class Creature {
    private let abilitiesController = AbilitiesController()
    private let system = (UIApplication.shared.delegate as! AppDelegate).system
    
    init(abilities: [Abilities:Int]) {
        for key in Abilities.allCases {
            let score = abilities[key] ?? 0
            abilitiesController.add_ability(forAbility: key, score: score)
        }
    }
    
    init(fromTransactions transactions: NSOrderedSet) {
        parse(transactions: transactions)
    }
    
    func transactionsController() -> TransactionsController {
        return abilitiesController.transactionsController
    }
    
    func currentAbilityScore(for key: Abilities) -> Int {
        return abilitiesController.currentScore(forAbility: key)
    }
    
    func baseAbilityScore(for key: Abilities) -> Int {
        return abilitiesController.baseScore(forAbility: key)
    }
    
    private func parse(transactions: NSOrderedSet) {
        for raw_transaction in transactions {
            guard let transaction = raw_transaction as? TransactionsModel else {
                print("Transaction cannot be parsed")
                return
            }
            
            guard let transSystem = transaction.system else {
                print("Unknown gaming system for transaction")
                return
            }

            if transSystem != system {
                print("Wrong game system \(system) for this app")
                return
            }

            guard let section_string = transaction.section else {
                print("No section for transaction")
                return
            }
            
            guard let section = CreaturesTransactionActions(rawValue: section_string) else {
                print("Unknown section \(section_string) for transaction")
                return
            }
            
            switch(section) {
            case .creation:
                handleAbility(transaction: transaction)
            }
        }
    }
    
    private func handleAbility(transaction: TransactionsModel) {
        guard let ability_name = transaction.attribute else {
            print("No ability name found for transaction")
            return
        }
        guard let key = Abilities(rawValue: ability_name) else {
            print("Invalid key \(ability_name) for transaction")
            return
        }
        guard let valueString = transaction.value else {
            print("No value string found for transaction")
            return
        }
        guard let value = Int(valueString) else {
            print("value \(valueString) is not an integer for transaction")
            return
        }
        abilitiesController.add_ability(forAbility: key, score: value)
    }
}

