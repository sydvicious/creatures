//
//  MainNavigation.swift
//  iOS
//
//  Created by Syd Polk on 6/26/22.
//  Copyright © 2022 Syd Polk. All rights reserved.
//

import SwiftUI

struct MainNavigation: View {
    @State var characters: [Creature]
    @State private var selection: Creature?
    
    var body: some View {
        NavigationSplitView {
            List(characters, selection: $selection) {character in
                Text(character.name).tag(character)
            }
        } detail: {
            CharacterView(character: selection)
        }
        .navigationSplitViewStyle(.balanced)
    }
}

struct MainNavigation_Previews: PreviewProvider {
    static var previews: some View {
        let testCreature = Creature(system: "Pathfinder", name:"Pendecar", strength: 17, dexterity: 17, constitution: 18, intelligence: 21, wisdom: 14, charisma: 14)
        let characters = [testCreature]

        MainNavigation(characters: characters)
    }
}
