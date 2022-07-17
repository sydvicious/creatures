//
//  CharacterView.swift
//  iOS
//
//  Created by Syd Polk on 6/26/22.
//  Copyright © 2022 Syd Polk. All rights reserved.
//

import SwiftUI

struct CharacterView: View {
    
    var character: CreatureModel?
    var name: String = "<no selection>"
    var strength: Ability? = nil
    var dexterity: Ability? = nil
    var constitution: Ability? = nil
    var intelligence: Ability? = nil
    var wisdom: Ability? = nil
    var charisma: Ability? = nil
    
    init(character: CreatureModel?) {
        if let character {
            // When a character is deleted from the fetchedresults and this view is showing, it gets redrawn with the old object. Yuck.
            if let name = character.name {
                self.name = name
            } else {
                print("CharacterView called with stale character")
            }
            CreaturesController.sharedCreaturesController().provideCreatureDetails(character)
            if let creature = character.creature {
                self.strength = creature.abilities[.Strength] ?? nil
                self.dexterity = creature.abilities[.Dexterity] ?? nil
                self.constitution = creature.abilities[.Constitution] ?? nil
                self.intelligence = creature.abilities[.Intelligence] ?? nil
                self.wisdom = character.creature?.abilities[.Wisdom] ?? nil
                self.charisma = character.creature?.abilities[.Charisma] ?? nil
            }
        }
    }
    
    var body: some View {
        VStack {
            if self.name == "<no selection>" {
                Text("Select a character or hit + to add a new one")
            } else {
                Grid(alignment: .trailing) {
                    AbilityGridRow(.Strength, ability: strength)
                    AbilityGridRow(.Dexterity, ability: dexterity)
                    AbilityGridRow(.Constitution, ability: constitution)
                    AbilityGridRow(.Intelligence, ability: intelligence)
                    AbilityGridRow(.Wisdom, ability: wisdom)
                    AbilityGridRow(.Charisma, ability: charisma)
                }.padding().border(.black)
            }
        }.navigationTitle(name)
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var protoData = ProtoCharacter.dummyProtoData()
    static var creatureModel = protoData.modelFrom()

    static var previews: some View {
        CharacterView(character: creatureModel)
    }
}
