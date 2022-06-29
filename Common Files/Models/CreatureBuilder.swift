//
//  CreatureBuilder.swift
//  Characters
//
//  Created by Syd Polk on 7/23/17.
//  Copyright © 2017 Bone Jarring Games and Software. All rights reserved.
//

import Foundation

class CreatureBuilder: NSObject {

    var abilities: [Abilities:Int] = [:]
    var system: String = "Pathfinder"
    var name: String?
    
    func set(system: String) -> CreatureBuilder {
        self.system = system
        return self
    }
    
    func set(abilityFor: Abilities, score: Int) -> CreatureBuilder {
        self.abilities[abilityFor] = score
        return self
    }
    
    func set(_ name: String) -> CreatureBuilder {
        self.name = name
        return self
    }
        
    func build() throws -> Creature {
        return Creature(system: system, name: self.name!, strength: self.abilities[.Strength]!, dexterity: self.abilities[.Dexterity]!, constitution: self.abilities[.Constitution]!, intelligence: self.abilities[.Intelligence]!, wisdom: self.abilities[.Wisdom]!, charisma: self.abilities[.Charisma]!)
    }
    
}
