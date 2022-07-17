////
// Created by Syd Polk on 7/16/22.
//
// Copyright © 2022 Syd Polk
// All Rights Reserved.
//


import UIKit

class AbilitiesController {
  
    private var abilities: [Abilities:Ability] = [:]
    private let system = (UIApplication.shared.delegate as! AppDelegate).system
    let transactionsController = TransactionsController()
    
    let abilityConstructors: [String:(Int)->Ability] = [
        "Pathfinder": PathfinderAbility.init,
        "AD&D": Ability.init,
        "D&D": Ability.init,
        "D&D5": d20Ability.init
    ]
        
    func add_ability(forAbility key: Abilities, score: Int) {
        guard let ability_init:(Int) -> Ability = abilityConstructors[system] else {
            print("Unable to get abilities for system \(system)")
            abort()
        }

        let ability = ability_init(score)
        abilities[key] = ability
        save_transaction(section: "ability", attribute: key.rawValue, source: "creation", type: "base", value: String(score), duration: -1)
    }
    
    func baseScore(forAbility key: Abilities) -> Int {
        return abilities[key]?.baseScore ?? 0
    }
    
    func currentScore(forAbility key: Abilities) -> Int {
        return abilities[key]?.currentScore ?? 0
    }
    
    private func save_transaction(section: String, attribute: String, source: String, type: String, value: String, duration: Int) {
        let trans = Transaction(system: system, section: section, attribute: attribute, source: source, type: type, value: value, duration: duration)
        transactionsController.add(transaction: trans)
    }

}
