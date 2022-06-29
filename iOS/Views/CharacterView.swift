//
//  CharacterView.swift
//  iOS
//
//  Created by Syd Polk on 6/26/22.
//

import SwiftUI

struct CharacterView: View {
    
    var character: Creature?
    var name: String
    
    init(character: Creature?) {
        if let character = character {
            self.name = character.name
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
        let testCreature = Creature(system: "Pathfinder", name: "Pendecar", strength: 17, dexterity: 17, constitution: 18, intelligence: 21, wisdom: 14, charisma: 14)
        CharacterView(character: testCreature)
    }
}
