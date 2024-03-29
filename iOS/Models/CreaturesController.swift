//
//  CreaturesController.swift
//  Characters
//
//  Created by Syd Polk on 6/11/15.
//  Copyright (c) 2015-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//  Copyright © 2022-2023 Syd Polk (reassigned). All rights reserved.
//


import Foundation
import CoreData

class CreaturesController {
    // MARK: - Core Data stack

    var context: CharactersContext
    
    private init (_ forTest: Bool = false, _ name: String = "Creatures") {
        do {
            self.context = CharactersContext(forTest: forTest, name: name)
            try self.context.fetchedResultsController?.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            print("Unresolved error \(error)")
            abort()
        }
    }
    
    static private var sharedController: CreaturesController? = nil

    static func sharedCreaturesController(_ forTest: Bool = false, _ name: String = "Creatures") -> CreaturesController {
        if sharedController == nil {
            sharedController = CreaturesController(forTest, name)
        }
        return sharedController!
    }
    
    func setDelegate(_ delegate: NSFetchedResultsControllerDelegate) {
        self.context.fetchedResultsController?.delegate = delegate
    }

    func provideCreatureDetails(_ model: CreatureModel) {
        if model.creature == nil {
            let creature = Creature(fromTransactions: model.transactions!)
            model.creature = creature
        }
    }

    func createCreature(_ name: String, withSystem: String = "Pathfinder", withCreature creature: Creature? = nil) throws -> CreatureModel {
        let context = self.context.managedObjectContext
        let creatureModel = CreatureModel(context: context!)

        creatureModel.name = name
        let oid = Prefs.getNewID()
        creatureModel.oid = oid
        
        if creature == nil {
            provideCreatureDetails(creatureModel)
        } else {
            creatureModel.creature = creature
        }

        try self.save(creatureModel)

        return creatureModel
    }
    
    func setCreature(creatureModel: CreatureModel, creature: Creature?) {
        creatureModel.creature = creature
    }
    
    func save(_ creatureModel: CreatureModel) throws {
        let context = self.context.managedObjectContext
        provideCreatureDetails(creatureModel)
        guard let creature = creatureModel.creature else {
            NSLog("Can't save without a creature")
            throw(CreatureModel.CreatureModelDataError.noCreatureInModel)
        }
        let transactionsController = creature.transactionsController()
        let transactions = transactionsController.pendingTransactions()
        for trans in transactions {
            let transModel = TransactionsModel(context: context!)
            transModel.system = trans.system
            transModel.section = trans.section
            transModel.attribute = trans.attribute
            transModel.source = trans.source
            transModel.type = trans.type
            transModel.value = trans.value
            transModel.duration = trans.duration as NSNumber?
            transModel.timestamp = trans.timestamp
            transModel.oid = trans.oid
            transModel.creature = creatureModel
            creatureModel.addToTransactions(transModel)
        }
        try self.context.saveContext()
        transactionsController.clearPendingTransactions()
    }
    
    func saveCreature(_ name: String, atIndexPath indexPath: IndexPath) throws {
        let creature = self.getCreature(fromIndexPath: indexPath)
        try self.save(creature)
    }

    func saveCreature(_ name: String, atIndex index: Int) throws {
        let creature = self.getCreature(fromIndex: index)
        try self.save(creature)
    }

    func saveCreature(fromModel model: CreatureModel) throws {
        guard model.creature != nil else {
            return
        }
        try self.save(model)
    }
    
    func saveName(_ name: String, forCreature creatureModel: CreatureModel) throws {
        let trimmed_name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (trimmed_name != creatureModel.name) {
            creatureModel.name = trimmed_name
            try self.save(creatureModel)
        }
    }
    
    func deleteCreature(atIndexPath indexPath: IndexPath) {
        self.context.managedObjectContext?.delete(self.context.fetchedResultsController?.object(at: indexPath) as! CreatureModel)
        try! self.context.saveContext()
    }
    
    func deleteCreature(_ creature: CreatureModel) {
        self.context.managedObjectContext?.delete(creature)
        try! self.context.saveContext()
    }
    
    func deleteIndexedCreatures(indexSet: IndexSet) {
        // Gather all of the creatures
        
        
        var deadItems : [CreatureModel] = []
        let creatures = self.creatures()
        
        for i in indexSet {
            deadItems.append(creatures[i])
        }
        
        // Delete them one by one
        
        for deadItem in deadItems {
            self.deleteCreature(deadItem)
        }
    }
    
    func getCreature(fromIndexPath indexPath: IndexPath) -> CreatureModel {
        let creatureModel = self.context.fetchedResultsController!.object(at: indexPath) as! CreatureModel
        // Fetch all of the transactions
        
        // Create a creature based off of them.
        // This is where the transactions list must be read.
        provideCreatureDetails(creatureModel)
        
        return creatureModel
    }
    
    func getCreature(fromIndex index: Int) -> CreatureModel {
        let models = self.context.fetchedResultsController!.fetchedObjects as! [CreatureModel]
        let model = models[index]
        provideCreatureDetails(model)

        return model
    }

    func getIndex(fromCreature creature: CreatureModel) -> IndexPath? {
        let indexPath = self.context.fetchedResultsController?.indexPath(forObject: creature)
        return indexPath
    }
    
    func creatures() -> [CreatureModel] {
        let models = self.context.fetchedResultsController!.fetchedObjects as! [CreatureModel]
        for model in models {
            provideCreatureDetails(model)
        }
        return models
    }
    
    func count() -> Int {
        let models = self.context.fetchedResultsController!.fetchedObjects as! [CreatureModel]
        return models.count
    }
    
    func deleteAll() {
        let creatures = self.context.fetchedResultsController?.fetchedObjects as! [CreatureModel]
        for creature in creatures {
            self.deleteCreature(creature)
        }
    }
    
    func logAll() {
        let creature_models = self.creatures()
        if creature_models.count == 0 {
            print("No creatures found")
        } else {
            for model in creature_models {
                print(model.name!)
                if let creature = model.creature {
                    print(" Abilities")
                    for key in Abilities.allCases {
                        print("  \(key.rawValue) - \(creature.currentAbilityScore(for: key))")
                    }
                } else {
                    print("No creature attached!")
                }
            }
        }
    }
    
    func save() {
        try! self.context.saveContext()
    }
}
