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
    
    var body: some View {
        VStack {
            Text("New Character Wizard")
            Spacer()
            Button("Done", action: done)
        }.onAppear(perform: {
            protoData = ProtoCharacter.dummyProtoData()
            
            print("TODO: Replace dummy characters - protoData.name")
        })
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
