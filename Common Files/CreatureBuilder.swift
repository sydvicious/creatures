//
//  CreatureBuilder.swift
//  Characters
//
//  Created by Syd Polk on 7/23/17.
//

import UIKit

class CreatureBuilder: NSObject {

    var abilities: [Abilities:Int] = [:]
    var system: String = "Pathfinder"
    
    func set(system: String) -> CreatureBuilder {
        self.system = system
        return self
    }
    
    func set(abilityFor: Abilities, score: Int) -> CreatureBuilder {
        self.abilities[abilityFor] = score
        return self;
    }
    
    func build() throws -> Creature {
        return Creature(system: system, strength: self.abilities[.Strength]!, dexterity: self.abilities[.Dexterity]!, constitution: self.abilities[.Constitution]!, intelligence: self.abilities[.Intelligence]!, wisdom: self.abilities[.Wisdom]!, charisma: self.abilities[.Charisma]!)
    }
    
}
