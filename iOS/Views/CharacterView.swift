//
//  CharacterView.swift
//  iOS
//
//  Created by Syd Polk on 6/26/22.
//

import SwiftUI

struct CharacterView: View {
    
    var character: CreatureModel?
    var name: String
    
    init(character: CreatureModel?) {
        if let character = character, let name = character.name {
            self.name = name
        } else {
            self.name = "<no selection>"
        }
    }
    
    var body: some View {
        Text("\(name)")
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        let controller = CreaturesController.sharedCreaturesController(true, "Testing")
        let testCreature = Creature(system: "Pathfinder",  strength: 17, dexterity: 17, constitution: 18, intelligence: 21, wisdom: 14, charisma: 14)
        let creatureModel = try! controller.createCreature("Pendecar", withCreature: testCreature)
        CharacterView(character: creatureModel)
    }
}
