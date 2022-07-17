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
    var strength: Int = 0
    var dexterity: Int = 0
    var constitution: Int = 0
    var intelligence: Int = 0
    var wisdom: Int = 0
    var charisma: Int = 0
    
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
                self.strength = creature.baseAbilityScore(for: .Strength)
                self.dexterity = creature.baseAbilityScore(for: .Dexterity)
                self.constitution = creature.baseAbilityScore(for: .Constitution)
                self.intelligence = creature.baseAbilityScore(for: .Intelligence)
                self.wisdom = creature.baseAbilityScore(for: .Wisdom)
                self.charisma = creature.baseAbilityScore(for: .Charisma)
            }
        }
    }
    
    var body: some View {
        VStack {
            if self.name == "<no selection>" {
                Text("Select a character or hit + to add a new one")
            } else {
                Grid(alignment: .trailing) {
                    AbilityGridRow(.Strength, score: strength)
                    AbilityGridRow(.Dexterity, score: dexterity)
                    AbilityGridRow(.Constitution, score: constitution)
                    AbilityGridRow(.Intelligence, score: intelligence)
                    AbilityGridRow(.Wisdom, score: wisdom)
                    AbilityGridRow(.Charisma, score: charisma)
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
