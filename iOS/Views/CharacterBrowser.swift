//
//  MainNavigation.swift
//  iOS
//
//  Created by Syd Polk on 6/26/22.
//  Copyright © 2022 Syd Polk. All rights reserved.
//

import SwiftUI

struct CharacterBrowser: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))],
        animation: .default)
    public var characters: FetchedResults<CreatureModel>
    
    @State private var selection: CreatureModel?
    @State private var newCharacterWizardShowing = false
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(characters, id: \.oid) { character in
                    Text(character.name!).tag(character)
                }.onDelete(perform:{ selectionSet in
                    let creaturesController = CreaturesController.sharedCreaturesController()
                    creaturesController.deleteIndexedCreatures(indexSet: selectionSet)
                    try! viewContext.save()
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
            CharacterView(character: selection)
        }
        .navigationSplitViewStyle(.balanced)
        .onAppear(perform: {
            if self.horizontalSizeClass == .regular && self.selection == nil && self.characters.count > 0 {
                self.selection = self.characters[0]
            }
            let creaturesController = CreaturesController.sharedCreaturesController()
            creaturesController.logAll()
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
            .environment(\.managedObjectContext, controller.context.managedObjectContext!)
    }
}
