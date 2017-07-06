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

let abilityConstructors: [String:(String,Int,TransactionsController)->Ability] = [
    "Pathfinder": PathfinderAbility.init,
    "AD&D": Ability.init,
    "D&D": Ability.init,
    "D&D5": d20Ability.init
]

class Creature {
    
    let system: String
    
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
    
    func ability(named: String, fromBaseScore: Int) -> Ability? {
        if let ability_init:(String, Int, TransactionsController) -> Ability = abilityConstructors[system] {
            return ability_init(named, fromBaseScore, transactionsController)
        }
        print("Unknown ability \(system)")
        abort()
    }
    
    func setStrength(baseScore: Int) {
        if _strength == nil {
            _strength = ability(named: "strength", fromBaseScore: baseScore)
        } else {
            // Deal with transactions and modifications and something
        }
    }
    
    func setDexterity(baseScore: Int) {
        if _dexterity == nil {
            _dexterity = ability(named: "dexterity", fromBaseScore: baseScore)
        } else {
        }
    }
    
    func setConstitution(baseScore: Int) {
        if _constitution == nil {
            _constitution = ability(named: "constitution", fromBaseScore: baseScore)
        } else {
        }
    }
    
    func setIntelligence(baseScore: Int) {
        if _intelligence == nil {
            _intelligence = ability(named: "intelligence", fromBaseScore: baseScore)
        } else {
        }
    }
    
    func setWisdom(baseScore: Int) {
        if _wisdom == nil {
            _wisdom = ability(named: "wisdom", fromBaseScore: baseScore)
        } else {
        }
    }
    
    func setCharisma(baseScore: Int) {
        if _charisma == nil {
            _charisma = ability(named: "charisma", fromBaseScore: baseScore)
        } else {
        }
    }
    
    init() {
        system = "Pathfinder"
    }
    
    init(system: String) {
        self.system = system
    }
    
    init(system: String, strength: Int, dexterity: Int, constitution: Int, intelligence: Int, wisdom: Int, charisma: Int) {
        self.system = system
        
        setStrength(baseScore: strength)
        setDexterity(baseScore: dexterity)
        setConstitution(baseScore: constitution)
        setIntelligence(baseScore: intelligence)
        setWisdom(baseScore: wisdom)
        setCharisma(baseScore: charisma)
    }

    func parse(transactions: NSSet) {
        for raw_transaction in transactions {
            let transaction = raw_transaction as! TransactionsModel
            sectionCommands[transaction.section!]!(self, transaction, SystemsMap[transaction.system!]!)
        }
    }
}

