//
//  NewCharacterWizard.swift
//  iOS
//
//  Created by Syd Polk on 7/5/22.
//  Copyright © 2022 Syd Polk. All rights reserved.
//

import SwiftUI

struct NewCharacterWizard: View {
    @Environment(\.managedObjectContext) private var viewContext

    @Binding var newCharacterWizardShowing: Bool
    @Binding var selection: CreatureModel?
    
    @State private var protoData = ProtoCharacter()

    @State private var rolls: [Rolls4d6]? = nil
    @State private var doneDisabled = true
    @State private var nameValid = false
    @State private var abilitiesValid = false
    
    var body: some View {
        VStack {
            Text("New Character Wizard")
            Spacer()
            Form {
                Grid {
                    GridRow {
                        Text("Please provide a name for your new character:")
                        Spacer()
                        if nameValid {
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 15, height: 15, alignment: .trailing)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.green)
                        }
                    }
                }
                TextField("<NAME>", text: $protoData.name)
                    .onSubmit {
                        validateName()
                    }
                    .onAppear {
                        validateName()
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .border(.secondary)
            }
            HStack {
                Button("Cancel", action: cancel)
                Button("Done", action: done)
                    .disabled(doneDisabled)
            }
        }
    }
    
    private func validateName() {
        let trimmedName = protoData.name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        nameValid = trimmedName != ""
        updateDoneButton()
    }
    
    private func validateAbilities() {
        guard let strength = protoData.abilities[.Strength], strength > 0 else {
            abilitiesValid = false
            return
        }
        guard let dexterity = protoData.abilities[.Dexterity], dexterity > 0 else {
            abilitiesValid = false
            return
        }
        guard let constitution = protoData.abilities[.Constitution], constitution > 0 else {
            abilitiesValid = false
            return
        }
        guard let intelligence = protoData.abilities[.Intelligence], intelligence > 0 else {
            abilitiesValid = false
            return
        }
        guard let wisdom = protoData.abilities[.Wisdom], wisdom > 0 else {
            abilitiesValid = false
            return
        }
        guard let charisma = protoData.abilities[.Charisma], charisma > 0 else {
            abilitiesValid = false
            return
        }
        abilitiesValid = true
    }
    
    private func updateDoneButton() {
        doneDisabled = !(nameValid && abilitiesValid)
    }
    
    private func cancel() {
        newCharacterWizardShowing = false
    }
    
    private func done() {
        newCharacterWizardShowing = false
        
        // Looks like a cosmetic bug in List when you set the selection explicitly
        //selection = protoData.modelFrom()
        let _ = protoData.modelFrom()
    }
}

struct NewCharacterWizard_Previews: PreviewProvider {
    @State static var show = true
    @State static var selection: CreatureModel? = nil

    static var previews: some View {
        NewCharacterWizard(newCharacterWizardShowing: $show, selection: $selection)
    }
}
