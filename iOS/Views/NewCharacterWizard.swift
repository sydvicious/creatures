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
    @State private var protoData = ProtoCharacter()

    @State private var rolls: [Rolls4d6]? = nil
    
    var body: some View {
        VStack {
            Text("New Character Wizard")
            Spacer()
            Button("Done", action: done)
        }.onAppear(perform: {
            protoData = ProtoCharacter.dummyProtoData()
            print("Replace dummy characters - protoData.name")
        })
    }
    
    private func done() {
        newCharacterWizardShowing = false
        let _ = protoData.modelFrom()
    }
}

struct NewCharacterWizard_Previews: PreviewProvider {
    @State static var show = true

    static var previews: some View {
        NewCharacterWizard(newCharacterWizardShowing: $show)
    }
}
