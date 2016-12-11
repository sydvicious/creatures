//
//  Creature.swift
//  Characters
//
//  Created by Syd Polk on 10/16/16.
//
//

import UIKit

class Creature {

    let _trans: TransactionsController = TransactionsController()
    
    let _strength: Ability
    let _dexterity: Ability
    let _constitution: Ability
    let _inteligence: Ability
    let _wisdom: Ability
    let _charisma: Ability
    
    init(system: String, strength: Int, dexterity: Int, constitution: Int, intelligence: Int, wisdom: Int, charisma: Int) {
        if system == "Pathfinder" {
            _strength = PathfinderAbility(name: "strength", score: strength, trans: _trans)
            _dexterity = PathfinderAbility(name: "dexterity", score: dexterity, trans: _trans)
            _constitution = PathfinderAbility(name: "consitution", score: constitution, trans: _trans)
            _inteligence = PathfinderAbility(name: "intelligence", score: intelligence, trans: _trans)
            _wisdom = PathfinderAbility(name: "widsom", score: wisdom, trans: _trans)
            _charisma = PathfinderAbility(name: "charisma", score: charisma, trans: _trans)
        } else if system == "D&D" || system == "AD&D" {
            _strength = Ability(name: "strength", score: strength, trans: _trans)
            _dexterity = Ability(name: "dexterity", score: dexterity, trans: _trans)
            _constitution = Ability(name: "consitution", score: constitution, trans: _trans)
            _inteligence = Ability(name: "intelligence", score: intelligence, trans: _trans)
            _wisdom = Ability(name: "widsom", score: wisdom, trans: _trans)
            _charisma = Ability(name: "charisma", score: charisma, trans: _trans)
        } else {
            _strength = d20Ability(name: "strength", score: strength, trans: _trans)
            _dexterity = d20Ability(name: "dexterity", score: dexterity, trans: _trans)
            _constitution = d20Ability(name: "consitution", score: constitution, trans: _trans)
            _inteligence = d20Ability(name: "intelligence", score: intelligence, trans: _trans)
            _wisdom = d20Ability(name: "widsom", score: wisdom, trans: _trans)
            _charisma = d20Ability(name: "charisma", score: charisma, trans: _trans)
            
        }
        
    }
    
    
}
