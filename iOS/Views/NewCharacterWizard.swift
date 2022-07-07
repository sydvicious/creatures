//
//  NewCharacterWizard.swift
//  iOS
//
//  Created by Syd Polk on 7/5/22.
//

import SwiftUI

struct NewCharacterWizard: View {
    @Environment(\.managedObjectContext) private var viewContext

    @Binding var newCharacterWizardShowing: Bool
    @State private var protoData = ProtoData()

    @State private var rolls: [Rolls4d6]? = nil
    
    var body: some View {
        VStack {
            Text("New Character Wizard")
            Spacer()
            Button("Done", action: done)
        }.onAppear(perform: {
            protoData = ProtoData.dummyProtoData()
            print("Replace dummy characters - protoData.name")
        })
    }
    
    private func done() {
        newCharacterWizardShowing = false
        let _ = protoData.modelFrom()
    }
}

class ProtoData {
    var name: String = ""
    var abilities : [Abilities:Int] = [:]
    
    static func dummyProtoData() -> ProtoData {
        var abilities = [Abilities: Int]()
        abilities[.Strength] = Rolls4d6().score()
        abilities[.Dexterity] = Rolls4d6().score()
        abilities[.Constitution] = Rolls4d6().score()
        abilities[.Intelligence] = Rolls4d6().score()
        abilities[.Wisdom] = Rolls4d6().score()
        abilities[.Charisma] = Rolls4d6().score()
        let protoData = ProtoData()
        protoData.name = "Pendecar" + String(Int.random(in: 0...32767))
        protoData.abilities = abilities
        return protoData
    }
    
    func isCharacterReady() -> Bool {
        let proposedName = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if "" == proposedName {
            return false
        }
        for key in d20Ability.abilityKeys {
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

struct NewCharacterWizard_Previews: PreviewProvider {
    @State static var show = true

    static var previews: some View {
        NewCharacterWizard(newCharacterWizardShowing: $show)
    }
}
