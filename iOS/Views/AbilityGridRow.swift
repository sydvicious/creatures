//
//  AbilityGridRow.swift
//  iOS
//
//  Created by Syd Polk on 6/30/22.
//

import SwiftUI

struct AbilityGridRow: View {
    @State var ability: Ability?
    private var name: String = ""
    private var currentScore: Int = 0
    private var modifierString: String = "-5"
    
    init(ability: Ability?) {
        if let ability = ability {
            name = ability.name
            currentScore = ability.currentScore
            let modifier = d20Ability.modifier(value: currentScore)
            modifierString = modifier < 0 ? "\(modifier)" : "+\(modifier)"
        }
    }
    
    var body: some View {
        GridRow {
                Text(name).multilineTextAlignment(.trailing).bold().padding([.trailing], 5)
                Text("\(currentScore)").multilineTextAlignment(.trailing).padding([.trailing], 5).font(.system(.body, design: .monospaced))
                Text("\(modifierString)").font(.system(.body, design: .monospaced))
        }.padding([.all], 2)
    }
}

struct AbilityGridRow_Previews: PreviewProvider {
    static var ability = Ability(name: "Strength", score: 15)
    
    static var previews: some View {
        Grid {
            AbilityGridRow(ability: ability)
        }
    }
}
