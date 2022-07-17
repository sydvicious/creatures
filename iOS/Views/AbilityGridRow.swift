//
//  AbilityGridRow.swift
//  iOS
//
//  Created by Syd Polk on 6/30/22.
//  Copyright © 2022 Syd Polk. All rights reserved.
//

import SwiftUI

struct AbilityGridRow: View {
    private var name: String?
    private var baseScore: Int = 0
    private var modifierString: String = "-5"
    
    init(_ key: Abilities, score: Int) {
        name = key.rawValue
        baseScore = score
        let modifier = d20Ability.modifier(value: baseScore)
        modifierString = modifier < 0 ? "\(modifier)" : "+\(modifier)"
    }
    
    var body: some View {
        GridRow {
                Text(name ?? "<no name>").multilineTextAlignment(.trailing).bold().padding([.trailing], 5)
                Text("\(baseScore)").multilineTextAlignment(.trailing).padding([.trailing], 5).font(.system(.body, design: .monospaced))
                Text("\(modifierString)").font(.system(.body, design: .monospaced))
        }.padding([.all], 2)
    }
}

struct AbilityGridRow_Previews: PreviewProvider {
    static var previews: some View {
        Grid {
            AbilityGridRow(.Strength, score: 15)
        }
    }
}
