//
//  ProtoData.swift
//  Characters
//
//  Created by Syd Polk on 7/7/22.
//
//  Copyright © 2022 Syd Polk. All rights reserved.
//

import Foundation

class ProtoCharacter {
    var name: String = ""
    var abilities : [Abilities:Int] = [:]
    
    static func dummyProtoData() -> ProtoCharacter {
        var abilities = [Abilities: Int]()
        abilities[.Strength] = Rolls4d6().score()
        abilities[.Dexterity] = Rolls4d6().score()
        abilities[.Constitution] = Rolls4d6().score()
        abilities[.Intelligence] = Rolls4d6().score()
        abilities[.Wisdom] = Rolls4d6().score()
        abilities[.Charisma] = Rolls4d6().score()
        let protoData = ProtoCharacter()
        protoData.name = "Pendecar" + String(Int.random(in: 0...32767))
        protoData.abilities = abilities
        return protoData
    }
    
    func isCharacterReady() -> Bool {
        let proposedName = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if "" == proposedName {
            return false
        }
        for key in Abilities.allCases {
            guard let _ = abilities[key] else {
                return false
            }
        }
        return true
    }
    
    func creatureFrom() -> Creature? {
        guard isCharacterReady() else {
            return nil
        }
        return CreatureBuilder()
            .set(system: "Pathfinder")
            .set(abilites: abilities)
            .build()
    }
    
    func modelFrom() -> CreatureModel? {
        if let creature = creatureFrom() {
            let controller = CreaturesController.sharedCreaturesController()
            return try! controller.createCreature(name, withCreature: creature)
        } else {
            return nil
        }
    }
    
}