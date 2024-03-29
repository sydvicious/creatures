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
    @State private var welcomeScreenShowing = false

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(characters, id: \.oid) { character in
                    Text(character.name!).tag(character)
                }.onDelete(perform:{ selectionSet in
                    let creaturesController = CreaturesController.sharedCreaturesController()
                    creaturesController.deleteIndexedCreatures(indexSet: selectionSet)
                    try! viewContext.save()
                    selection = nil
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
            let defaults = UserDefaults.standard
            welcomeScreenShowing = !defaults.bool(forKey: "WelcomeScreenShown")
            if self.horizontalSizeClass == .regular && self.selection == nil && self.characters.count > 0 {
                self.selection = self.characters[0]
            }
            if self.characters.count == 0 {
                newCharacterWizardShowing = true
            }
        })
        .sheet(isPresented: $welcomeScreenShowing, content:{
            WelcomeScreen(welcomeScreenShowing: $welcomeScreenShowing)
        })
        .sheet(isPresented: $newCharacterWizardShowing, content:{
            NewCharacterWizard(newCharacterWizardShowing: $newCharacterWizardShowing, selection: $selection)
        })
    }
    
    private func addItem() {
        newCharacterWizardShowing = true
    }
}

struct CharacterBrowser_Previews: PreviewProvider {
    static var previews: some View {
        let controller = CreaturesController.sharedCreaturesController(true, "Testing")
        let testCreature = ProtoCharacter.dummyProtoData()
        let _ = try! controller.createCreature("Pendecar", withCreature: testCreature.creatureFrom())

        CharacterBrowser()
            .environment(\.managedObjectContext, controller.context.managedObjectContext!)
    }
}
