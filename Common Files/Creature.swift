//
//  Creature.swift
//  Characters
//
//  Created by Syd Polk on 10/16/16.
//
//

import UIKit

struct Creature {

    let _strength: Ability
    let _dexterity: Ability
    let _constitution: Ability
    let _inteligence: Ability
    let _wisdom: Ability
    let _charisma: Ability
    
    init() {
        _strength = Ability(score: 10)
        _dexterity = Ability(score: 10)
        _constitution = Ability(score: 10)
        _inteligence = Ability(score: 10)
        _wisdom = Ability(score: 10)
        _charisma = Ability(score: 10)
    }
    
    init (strength: Int, dexterity: Int, constitution: Int, intelligence: Int, wisdom: Int, charisma: Int) {
        _strength = Ability(score: strength)
        _dexterity = Ability(score: dexterity)
        _constitution = Ability(score: constitution)
        _inteligence = Ability(score: intelligence)
        _wisdom = Ability(score: wisdom)
        _charisma = Ability(score: charisma)
    }
    
}
