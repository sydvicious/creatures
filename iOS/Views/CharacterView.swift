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
    var strength: Ability?
    var dexterity: Ability?
    var constitution: Ability?
    var intelligence: Ability?
    var wisdom: Ability?
    var charisma: Ability?
    
    init(character: CreatureModel?) {
        if let character = character, let name = character.name {
            self.name = name
            strength = character.creature?.abilities[.Strength] ?? nil
            dexterity = character.creature?.abilities[.Dexterity] ?? nil
            constitution = character.creature?.abilities[.Constitution] ?? nil
            intelligence = character.creature?.abilities[.Intelligence] ?? nil
            wisdom = character.creature?.abilities[.Wisdom] ?? nil
            charisma = character.creature?.abilities[.Charisma] ?? nil
        } else {
            self.name = "<no selection>"
        }
    }
    
    var body: some View {
        VStack {
            if self.name == "<no selection>" {
                Text("Select a character or hit + to add a new one")
            } else {
                Grid(alignment: .trailing) {
                    AbilityGridRow(ability: strength)
                    AbilityGridRow(ability: dexterity)
                    AbilityGridRow(ability: constitution)
                    AbilityGridRow(ability: intelligence)
                    AbilityGridRow(ability: wisdom)
                    AbilityGridRow(ability: charisma)
                }.padding().border(.black)
            }
        }.navigationTitle(name)
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var protoData = ProtoData.dummyProtoData()
    static var creatureModel = protoData.modelFrom()

    static var previews: some View {
        CharacterView(character: creatureModel)
    }
}
