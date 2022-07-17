//
//  Creature.swift
//  Characters
//
//  Created by Syd Polk on 10/16/16.
//  Copyright (c) 2016-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//  Copyright © 2022 Syd Polk (reassigned). All rights reserved.
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
    return PathfinderAbility(key: Abilities(rawValue: name.capitalized)!, score: value)
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
    let ability_name = transaction.attribute!
    let value = Int(transaction.value!)

    let ability = sourcesAbilityCreationMap[source]!(system, ability_name, value!)
    creature.abilities[Abilities(rawValue: ability_name.capitalized)!] = ability
}

let sectionCommands: [String: (Creature, TransactionsModel, Systems) -> ()] = [
    "ability": addAbilityFrom
]

let abilityConstructors: [String:(Abilities,Int,TransactionsController)->Ability] = [
    "Pathfinder": PathfinderAbility.init,
    "AD&D": Ability.init,
    "D&D": Ability.init,
    "D&D5": d20Ability.init
]

class Creature {
    
    let system: String
    
    let transactionsController = TransactionsController()
    
    var abilities: [Abilities:Ability?] = [:]
    
    func ability(key: Abilities, fromBaseScore: Int) -> Ability? {
        if let ability_init:(Abilities, Int, TransactionsController) -> Ability = abilityConstructors[system] {
            return ability_init(key, fromBaseScore, transactionsController)
        }
        print("Unknown ability \(system)")
        abort()
    }
    
    func abilityScoreFor(_ abilityKey: Abilities) -> Int {
        if let abilityValue = abilities[abilityKey] {
            if let currentScore = abilityValue?.currentScore {
                return currentScore
            }
        }
        return 0
    }
    
    init() {
        system = "Pathfinder"
    }
    
    init(system: String) {
        self.system = system
    }
    
    init(system: String, abilites: [Abilities:Ability?]) {
        self.system = system
        self.abilities = abilites
    }

    func parse(transactions: NSOrderedSet) {
        for raw_transaction in transactions {
            let transaction = raw_transaction as! TransactionsModel
            sectionCommands[transaction.section!]!(self, transaction, SystemsMap[transaction.system!]!)
        }
    }
}

