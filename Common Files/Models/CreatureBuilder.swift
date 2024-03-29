//
//  CreatureBuilder.swift
//  Characters
//
//  Created by Syd Polk on 7/23/17.
//  Copyright © 2017 Bone Jarring Games and Software. All rights reserved.
//  Copyright © 2022 Syd Polk (reassigned). All rights reserved.
//

import Foundation

class CreatureBuilder: NSObject {

    var abilities: [Abilities:Int] = [:]
    
    func set(abilityFor key: Abilities, score: Int) -> CreatureBuilder {
        self.abilities[key] = score
        return self
    }
    
    func set(abilites: [Abilities:Int]) -> CreatureBuilder {
        self.abilities = abilites
        return self
    }
            
    private func isCreatureValid() -> Bool {
        guard abilities[.Strength] != nil else {
            return false
        }
        guard abilities[.Dexterity] != nil else {
            return false
        }
        guard abilities[.Constitution] != nil else {
            return false
        }
        guard abilities[.Intelligence] != nil else {
            return false
        }
        guard abilities[.Wisdom] != nil else {
            return false
        }
        guard abilities[.Charisma] != nil else {
            return false
        }
        return true
    }
    
    func build() -> Creature? {
        guard isCreatureValid() else {
            return nil
        }
        return Creature(abilities: abilities)
    }
    
}
