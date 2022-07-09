//
//  MainNavigation.swift
//  iOS
//
//  Created by Syd Polk on 6/26/22.
//  Copyright © 2022 Syd Polk. All rights reserved.
//

import SwiftUI

struct CharacterBrowser: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @State private var indeces: [Int] = []
    
    @State private var selection: Int?
    @State private var newCharacterWizardShowing = false
    @State private var welcomeScreenShowing = false
    let creaturesController = CreaturesController.sharedCreaturesController()
    
    init() {
        let count = creaturesController.count()
        for i in 0...count-1 {
            indeces.append(i)
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(indeces, id: \.self) { index in
                    let character = creaturesController.getCreature(fromIndex: index)
                    Text(character.name!).tag(character)
                }.onDelete(perform:{ selectionSet in
                    creaturesController.deleteIndexedCreatures(indexSet: selectionSet)
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Characters")
        } detail: {
            if let index = selection {
                let character = creaturesController.getCreature(fromIndex: index)
                CharacterView(character: character)
            }
        }
        .navigationSplitViewStyle(.balanced)
        .onAppear(perform: {
            let defaults = UserDefaults.standard
            welcomeScreenShowing = !defaults.bool(forKey: "WelcomeScreenShown")
            let count = creaturesController.count()
            if self.horizontalSizeClass == .regular && self.selection == nil && count > 0 {
                self.selection = 0
            }
            if count == 0 {
                newCharacterWizardShowing = true
            }
        })
        .fullScreenCover(isPresented: $welcomeScreenShowing, content:{
            WelcomeScreen(welcomeScreenShowing: $welcomeScreenShowing)
        })
        .sheet(isPresented: $newCharacterWizardShowing, content:{
            NewCharacterWizard(newCharacterWizardShowing: $newCharacterWizardShowing)
        })
    }
    
    private func addItem() {
        newCharacterWizardShowing = true
    }
}

struct CharacterBrowser_Previews: PreviewProvider {
    static var previews: some View {
        let controller = CreaturesController.sharedCreaturesController(true, "Testing")
        let testCreature = Creature(system: "Pathfinder", strength: 17, dexterity: 17, constitution: 18, intelligence: 21, wisdom: 14, charisma: 14)
        let _ = try! controller.createCreature("Pendecar", withCreature: testCreature)

        CharacterBrowser()
    }
}
