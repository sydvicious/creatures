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
    
    init (_ charactersContext: CharactersContext ) {
        do {
            self.context = charactersContext
            try self.context.fetchedResultsController.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            print("Unresolved error \(error)")
            abort()
        }
    }
    
    func setDelegate(_ delegate: NSFetchedResultsControllerDelegate) {
        self.context.fetchedResultsController.delegate = delegate
    }
    
    func createCreature(_ name: String) throws -> Creature {
        let context = self.context.managedObjectContext
        let newCreature = Creature(context: context!)
        
        try self.saveName(name, forCreature: newCreature)
        return newCreature
    }
    
    func saveCreature(_ name: String, atIndexPath: IndexPath) throws {
        let creature = self.creatureFromIndexPath(atIndexPath)
        try self.saveName(name, forCreature: creature)
    }
    
    func saveName(_ name: String, forCreature creature: Creature) throws {
        let trimmed_name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (trimmed_name != creature.name) {
            creature.name = trimmed_name
            try self.context.saveContext()
        }
    }
    
    func deleteCreatureAtIndexPath(_ indexPath: IndexPath) {
        self.context.managedObjectContext?.delete(self.context.fetchedResultsController.object(at: indexPath) as! Creature)
        try! self.context.saveContext()
    }
    
    func deleteCreature(_ creature: Creature) {
        self.context.managedObjectContext?.delete(creature)
        try! self.context.saveContext()
    }
    
    func creatureFromIndexPath(_ indexPath: IndexPath) -> Creature {
        return self.context.fetchedResultsController.object(at: indexPath) as! Creature
    }
    
    func indexPathFromCreature(_ creature: Creature) -> IndexPath {
        let indexPath = self.context.fetchedResultsController.indexPath(forObject: creature)
        return indexPath!
    }
    
    func creatures() -> [Creature] {
        return self.context.fetchedResultsController.fetchedObjects as! [Creature]
    }
    
    func deleteAll() {
        let creatures = self.context.fetchedResultsController.fetchedObjects as! [Creature]
        for creature in creatures {
            self.deleteCreature(creature)
        }
    }
    
    func logAll() {
        let creatures = self.creatures()
        for creature in creatures {
            print(creature.name)
        }
    }
}
