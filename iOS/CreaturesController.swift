//
//  CreaturesController.swift
//  Characters
//
//  Created by Syd Polk on 6/11/15.
//  Copyright (c) 2015-2016 Bone Jarring Games and Software, LLC. All rights reserved.
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
    
    func createCreature(_ name: String, withSystem: String = "Pathfinder", withCreature: Creature? = nil) throws -> CreatureModel {
        let context = self.context.managedObjectContext
        let newCreature = CreatureModel(context: context!)
        
        let oid = Prefs.getNewID()
        newCreature.oid = oid
        try self.context.saveContext()
        
        var creatureWithAbilities: Creature
        if let creature = withCreature {
            creatureWithAbilities = creature
        } else {
            // Assuming Pathfinder
            creatureWithAbilities = Creature(system: "Pathfinder", strength: 10, dexterity: 10, constitution: 10, intelligence: 10, wisdom: 10, charisma: 10)
            
        }
        newCreature.creature = creatureWithAbilities
        try self.saveName(name, forCreature: newCreature)

        return newCreature
    }
    
    func setCreature(model: CreatureModel, creature: Creature?) {
        model.creature = creature
    }
    
    func saveCreature(_ name: String, atIndexPath: IndexPath) throws {
        let creature = self.creatureFromIndexPath(atIndexPath)
        try self.saveName(name, forCreature: creature)
    }
    
    func saveName(_ name: String, forCreature creature: CreatureModel) throws {
        let trimmed_name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (trimmed_name != creature.name) {
            creature.name = trimmed_name
            try self.context.saveContext()
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
        return self.context.fetchedResultsController!.object(at: indexPath) as! CreatureModel
    }
    
    func indexPathFromCreature(_ creature: CreatureModel) -> IndexPath {
        let indexPath = self.context.fetchedResultsController?.indexPath(forObject: creature)
        return indexPath!
    }
    
    func creatures() -> [CreatureModel] {
        return self.context.fetchedResultsController!.fetchedObjects as! [CreatureModel]
    }
    
    func deleteAll() {
        let creatures = self.context.fetchedResultsController?.fetchedObjects as! [CreatureModel]
        for creature in creatures {
            self.deleteCreature(creature)
        }
    }
    
    func logAll() {
        let creatures = self.creatures()
        for creature in creatures {
            print(creature.name!)
        }
    }
}
