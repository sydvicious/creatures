//
//  Creature.swift
//  Characters
//
//  Created by Syd Polk on 10/16/16.
//
//

import UIKit

class Creature {

    let transactionsController = TransactionsController()
    
    let _strength: Ability
    let _dexterity: Ability
    let _constitution: Ability
    let _intelligence: Ability
    let _wisdom: Ability
    let _charisma: Ability
    
    init(system: String, strength: Int, dexterity: Int, constitution: Int, intelligence: Int, wisdom: Int, charisma: Int) {
        if system == "Pathfinder" {
            _strength = PathfinderAbility(name: "strength", score: strength, transactions: transactionsController)
            _dexterity = PathfinderAbility(name: "dexterity", score: dexterity, transactions: transactionsController)
            _constitution = PathfinderAbility(name: "consitution", score: constitution, transactions: transactionsController)
            _intelligence = PathfinderAbility(name: "intelligence", score: intelligence, transactions: transactionsController)
            _wisdom = PathfinderAbility(name: "widsom", score: wisdom, transactions: transactionsController)
            _charisma = PathfinderAbility(name: "charisma", score: charisma, transactions: transactionsController)
        } else if system == "D&D" || system == "AD&D" {
            _strength = Ability(name: "strength", score: strength, transactions: transactionsController)
            _dexterity = Ability(name: "dexterity", score: dexterity, transactions: transactionsController)
            _constitution = Ability(name: "consitution", score: constitution, transactions: transactionsController)
            _intelligence = Ability(name: "intelligence", score: intelligence, transactions: transactionsController)
            _wisdom = Ability(name: "widsom", score: wisdom, transactions: transactionsController)
            _charisma = Ability(name: "charisma", score: charisma, transactions: transactionsController)
        } else {
            _strength = d20Ability(name: "strength", score: strength, transactions: transactionsController)
            _dexterity = d20Ability(name: "dexterity", score: dexterity, transactions: transactionsController)
            _constitution = d20Ability(name: "consitution", score: constitution, transactions: transactionsController)
            _intelligence = d20Ability(name: "intelligence", score: intelligence, transactions: transactionsController)
            _wisdom = d20Ability(name: "widsom", score: wisdom, transactions: transactionsController)
            _charisma = d20Ability(name: "charisma", score: charisma, transactions: transactionsController)
            
        }
        
    }
    
    
}
