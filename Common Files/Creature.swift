//
//  Creature.swift
//  Characters
//
//  Created by Syd Polk on 10/16/16.
//  Copyright (c) 2016-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//

import Foundation

enum Systems:Hashable {
    case Pathfinder
    case DND3
    case DND35
    case DND4
    case DND5
}

let SystemsMap: [String:Systems] = [
    "Pathfinder": .Pathfinder
]

enum Sections:Hashable {
    case Ability
}

func pathfinderAbilityCreation(name: String, value: Int) -> Ability {
    return PathfinderAbility(name: name, score: value)
}

let SystemsAbilityCreationMap : [String:(String, Int) -> Ability] = [
    "Pathfinder": pathfinderAbilityCreation
]

func handleAbilityCreation(system: String, name: String, value: Int) -> Ability {
    return SystemsAbilityCreationMap[system]!(name, value)
}

let sourcesAbilityCreationMap : [String:(String,String,Int)->Ability] = [
    "creation": handleAbilityCreation
]

func addAbilityFrom(creature: Creature, transaction: TransactionsModel, system: Systems) {
    let source = transaction.source!
    let system = transaction.system!
    let name = transaction.attribute!
    let value = Int(transaction.value!)

    let ability = sourcesAbilityCreationMap[source]!(system, name, value!);
    setAbilityCommands[name]!(creature, ability)

}

let sectionCommands: [String: (Creature, TransactionsModel, Systems) -> ()] = [
    "ability": addAbilityFrom
]

func setStrengthFor(creature: Creature, withAbility: Ability) {
    creature._strength = withAbility
}

func setDexterityFor(creature: Creature, withAbility: Ability) {
    creature._dexterity = withAbility
}

func setConstitutionFor(creature: Creature, withAbility: Ability) {
    creature._constitution = withAbility
}

func setIntelligenceFor(creature: Creature, withAbility: Ability) {
    creature._intelligence = withAbility
}

func setWisdomFor(creature: Creature, withAbility: Ability) {
    creature._wisdom = withAbility
}

func setCharismaFor(creature: Creature, withAbility: Ability) {
    creature._charisma = withAbility
}

let setAbilityCommands: [String:(Creature, Ability) -> ()] = [
    "strength": setStrengthFor,
    "dexterity": setDexterityFor,
    "constitution": setConstitutionFor,
    "intelligence": setIntelligenceFor,
    "wisdom": setWisdomFor,
    "charisma": setCharismaFor,

    // TODO: remove this before we go to beta
    "consitution": setConstitutionFor,
    "widsom": setWisdomFor
]

class Creature {

    let transactionsController = TransactionsController()
    
    var _strength: Ability? = nil

    var strength : Int {
        get {
            if let str = _strength {
                return str.currentScore
            } else {
                return 10
            }
        }
    }

    var _dexterity: Ability? = nil

    var dexterity : Int {
        get {
            if let dex = _dexterity {
                return dex.currentScore
            } else {
                return 10
            }
        }
    }

    var _constitution: Ability? = nil

    var constitution : Int {
        get {
            if let con = _constitution {
                return con.currentScore
            } else {
                return 10
            }
        }
    }

    var _intelligence: Ability? = nil

    var intelligence : Int {
        get {
            if let int = _intelligence {
                return int.currentScore
            } else {
                return 10
            }
        }
    }

    var _wisdom: Ability? = nil

    var wisdom : Int {
        get {
            if let wis = _wisdom {
                return wis.currentScore
            } else {
                return 10
            }
        }
    }

    var _charisma: Ability? = nil

    var charisma : Int {
        get {
            if let cha = _charisma {
                return cha.currentScore
            } else {
                return 10
            }
        }
    }

    init() {

    }

    init(system: String, strength: Int, dexterity: Int, constitution: Int, intelligence: Int, wisdom: Int, charisma: Int) {
        if system == "Pathfinder" {
            _strength = PathfinderAbility(name: "strength", score: strength, transactions: transactionsController)
            _dexterity = PathfinderAbility(name: "dexterity", score: dexterity, transactions: transactionsController)
            _constitution = PathfinderAbility(name: "constitution", score: constitution, transactions: transactionsController)
            _intelligence = PathfinderAbility(name: "intelligence", score: intelligence, transactions: transactionsController)
            _wisdom = PathfinderAbility(name: "wisdom", score: wisdom, transactions: transactionsController)
            _charisma = PathfinderAbility(name: "charisma", score: charisma, transactions: transactionsController)
        } else if system == "D&D" || system == "AD&D" {
            _strength = Ability(name: "strength", score: strength, transactions: transactionsController)
            _dexterity = Ability(name: "dexterity", score: dexterity, transactions: transactionsController)
            _constitution = Ability(name: "constitution", score: constitution, transactions: transactionsController)
            _intelligence = Ability(name: "intelligence", score: intelligence, transactions: transactionsController)
            _wisdom = Ability(name: "wisdom", score: wisdom, transactions: transactionsController)
            _charisma = Ability(name: "charisma", score: charisma, transactions: transactionsController)
        } else {
            _strength = d20Ability(name: "strength", score: strength, transactions: transactionsController)
            _dexterity = d20Ability(name: "dexterity", score: dexterity, transactions: transactionsController)
            _constitution = d20Ability(name: "constitution", score: constitution, transactions: transactionsController)
            _intelligence = d20Ability(name: "intelligence", score: intelligence, transactions: transactionsController)
            _wisdom = d20Ability(name: "wisdom", score: wisdom, transactions: transactionsController)
            _charisma = d20Ability(name: "charisma", score: charisma, transactions: transactionsController)
        }
    }

    func parse(transactions: NSSet) {
        for raw_transaction in transactions {
            let transaction = raw_transaction as! TransactionsModel
            sectionCommands[transaction.section!]!(self, transaction, SystemsMap[transaction.system!]!)
        }
    }
}

