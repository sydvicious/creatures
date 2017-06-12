//
//  CreaturesController.swift
//  Characters
//
//  Created by Syd Polk on 6/11/15.
//  Copyright (c) 2015-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//


import Foundation
import CoreData

class CreaturesController {
    // MARK: - Core Data stack

    var context: CharactersContext
    
    private init (_ charactersContext: CharactersContext ) {
        do {
            self.context = charactersContext
            try self.context.fetchedResultsController?.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            print("Unresolved error \(error)")
            abort()
        }
    }
    
    static private var sharedController: CreaturesController? = nil

    static func sharedCreaturesController(_ charactersContext: CharactersContext) -> CreaturesController {
        if sharedController == nil {
            sharedController = CreaturesController(charactersContext)
        }
        return sharedController!
    }
    
    func setDelegate(_ delegate: NSFetchedResultsControllerDelegate) {
        self.context.fetchedResultsController?.delegate = delegate
    }

    func getCreature(fromModel model: CreatureModel) -> Creature {
        let creature = Creature()
        if let transactions = model.transactions {
            creature.parse(transactions: transactions)
        }
        return creature
    }

    func createCreature(_ name: String, withSystem: String = "Pathfinder", withCreature: Creature? = nil) throws -> CreatureModel {
        let context = self.context.managedObjectContext
        let creatureModel = CreatureModel(context: context!)
        
        creatureModel.name = name
        let oid = Prefs.getNewID()
        creatureModel.oid = oid

        var creature: Creature
        if let givenCreature = withCreature {
            creature = givenCreature
        } else {
            // Assuming Pathfinder
            creature = getCreature(fromModel: creatureModel)
        }
        creatureModel.creature = creature
        try self.save(creatureModel)

        return creatureModel
    }
    
    func setCreature(creatureModel: CreatureModel, creature: Creature?) {
        creatureModel.creature = creature
    }
    
    func save(_ creatureModel: CreatureModel) throws {
        let context = self.context.managedObjectContext
        guard let creature = creatureModel.creature else {
            NSLog("Can't save without a creature")
            abort()
        }
        let transactionsController = creature.transactionsController
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
    
    func saveCreature(_ name: String, atIndexPath: IndexPath) throws {
        let creature = self.creatureFromIndexPath(atIndexPath)
        try self.save(creature)
    }
    
    func saveName(_ name: String, forCreature creatureModel: CreatureModel) throws {
        let trimmed_name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (trimmed_name != creatureModel.name) {
            creatureModel.name = trimmed_name
            try self.save(creatureModel)
        }
    }
    
    func deleteCreatureAtIndexPath(_ indexPath: IndexPath) {
        self.context.managedObjectContext?.delete(self.context.fetchedResultsController?.object(at: indexPath) as! CreatureModel)
        try! self.context.saveContext()
    }
    
    func deleteCreature(_ creature: CreatureModel) {
        self.context.managedObjectContext?.delete(creature)
        try! self.context.saveContext()
    }
    
    func creatureFromIndexPath(_ indexPath: IndexPath) -> CreatureModel {
        let creatureModel = self.context.fetchedResultsController!.object(at: indexPath) as! CreatureModel
        // Fetch all of the transactions
        
        // Create a creature based off of them.
        // This is where the transactions list must be read.
        let creature = getCreature(fromModel: creatureModel)
        creatureModel.creature = creature
        
        return creatureModel
    }
    
    func indexPathFromCreature(_ creature: CreatureModel) -> IndexPath {
        let indexPath = self.context.fetchedResultsController?.indexPath(forObject: creature)
        return indexPath!
    }
    
    func creatures() -> [CreatureModel] {
        let models = self.context.fetchedResultsController!.fetchedObjects as! [CreatureModel]
        for model in models {
            model.creature = getCreature(fromModel: model)
        }
        return models
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
                    print("  Strength - \(creature.strength)")
                    print("  Dexterity - \(creature.dexterity)")
                    print("  Constitution - \(creature.constitution)")
                    print("  Intelligence - \(creature.intelligence)")
                    print("  Wisdom - \(creature.wisdom)")
                    print("  Charisma - \(creature.charisma)")
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
