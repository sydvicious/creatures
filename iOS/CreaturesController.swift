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
    
    init (fromContext charactersContext: CharactersContext ) {
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
    
    func setDelegate(delegate: NSFetchedResultsControllerDelegate) {
        self.context.fetchedResultsController.delegate = delegate
    }
    
    func createCreature(name: NSString) throws -> Creature {
        let context = self.context.managedObjectContext
        let entity = self.context.fetchRequest.entity!
        let entityname = entity.name!
        let newCreature = NSEntityDescription.insertNewObjectForEntityForName(entityname, inManagedObjectContext: context) as! Creature
        
        try self.saveName(name, forCreature: newCreature)
        return newCreature
    }
    
    func saveCreature(name: NSString, atIndexPath: NSIndexPath) throws {
        let creature = self.creatureFromIndexPath(atIndexPath)
        try self.saveName(name, forCreature: creature)
    }
    
    func saveName(name: NSString, forCreature creature: Creature) throws {
        let trimmed_name = name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if (trimmed_name != creature.name) {
            creature.name = trimmed_name
            try self.context.saveContext()
        }
    }
    
    func deleteCreatureAtIndexPath(indexPath: NSIndexPath) {
        self.context.managedObjectContext.deleteObject(self.context.fetchedResultsController.objectAtIndexPath(indexPath) as! Creature)
        try! self.context.saveContext()
    }
    
    func deleteCreature(creature: Creature) {
        self.context.managedObjectContext.deleteObject(creature)
        try! self.context.saveContext()
    }
    
    func creatureFromIndexPath(indexPath: NSIndexPath) -> Creature {
        return self.context.fetchedResultsController.objectAtIndexPath(indexPath) as! Creature
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
