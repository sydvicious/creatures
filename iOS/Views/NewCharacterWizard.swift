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
    
    @State private var protoData = ProtoCharacter.dummyProtoData() // Remove dummyProtoData when adding character wizard

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
                            Text("✔️")
                                .background(.red)
                        }
                    }
                }
                TextField("<NAME>", text: $protoData.name)
                    .onSubmit {
                        updateDoneButton()
                    }
                    .onAppear {
                        updateDoneButton()
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
    }
    
    private func validateAbilities() {
        for key in Abilities.allCases {
            guard let ability = protoData.abilities[key],
                    let score = ability?.currentScore,
                    score > 0 else {
                abilitiesValid = false
                return
            }
        }
        abilitiesValid = true
    }
    
    private func updateDoneButton() {
        validateName()
        validateAbilities()
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
