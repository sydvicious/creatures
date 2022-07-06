//
//  NewCharacterWizard.swift
//  iOS
//
//  Created by Syd Polk on 7/5/22.
//

import SwiftUI

struct NewCharacterWizard: View {
    @Binding var newCharacterWizardShowing: Bool
    
    var body: some View {
        Text("New Character Wizard")
        Button("Done") {
            newCharacterWizardShowing = false
        }
    }
}

struct NewCharacterWizard_Previews: PreviewProvider {
    @State static var show = true

    static var previews: some View {
        NewCharacterWizard(newCharacterWizardShowing: $show)
    }
}
