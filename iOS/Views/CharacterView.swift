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
    var strength: Int = 0
    var dexterity: Int = 0
    var constitution: Int = 0
    var intelligence: Int = 0
    var wisdom: Int = 0
    var charisma: Int = 0
    
    init(character: CreatureModel?) {
        if let character = character, let name = character.name {
            self.name = name
            strength = character.creature?.abilityScoreFor(.Strength) ?? 0
            dexterity = character.creature?.abilityScoreFor(.Dexterity) ?? 0
            constitution = character.creature?.abilityScoreFor(.Constitution) ?? 0
            intelligence = character.creature?.abilityScoreFor(.Intelligence) ?? 0
            wisdom = character.creature?.abilityScoreFor(.Wisdom) ?? 0
            charisma = character.creature?.abilityScoreFor(.Charisma) ?? 0

        } else {
            self.name = "<no selection>"
        }
    }
    
    var body: some View {
        VStack {
            Text("\(name)")
            Divider()
                .gridCellUnsizedAxes(.horizontal)
            Grid(alignment: .trailing) {
                GridRow {
                    HStack {
                        Text("Strength").multilineTextAlignment(.trailing).bold()
                        Text("\(strength)").multilineTextAlignment(.trailing)
                        Text("\(d20Ability.modifierString(value: strength))")
                    }
                }
                GridRow {
                    HStack {
                        Text("Dexterity").multilineTextAlignment(.trailing).bold()
                        Text("\(dexterity)").multilineTextAlignment(.trailing)
                        Text("\(d20Ability.modifierString(value: dexterity))")
                    }
                }
                GridRow {
                    HStack {
                        Text("Constitution").multilineTextAlignment(.trailing).bold()
                        Text("\(constitution)").multilineTextAlignment(.trailing)
                        Text("\(d20Ability.modifierString(value: constitution))")
                    }
                }
                GridRow {
                    HStack {
                        Text("Intelligence").multilineTextAlignment(.trailing).bold()
                        Text("\(intelligence)").multilineTextAlignment(.trailing)
                        Text("\(d20Ability.modifierString(value: intelligence))")
                    }
                }
                GridRow {
                    HStack {
                        Text("Wisdom").multilineTextAlignment(.trailing).bold()
                        Text("\(wisdom)").multilineTextAlignment(.trailing)
                        Text("\(d20Ability.modifierString(value: wisdom))")
                    }
                }
                GridRow {
                    HStack {
                        Text("Charisma").multilineTextAlignment(.trailing).bold()
                        Text("\(charisma)").multilineTextAlignment(.trailing)
                        Text("\(d20Ability.modifierString(value: charisma))")
                    }
                }
            }
        }
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
