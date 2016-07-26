//
//  CharactersManagedObjectContext.swift
//  Characters
//
//  Created by Syd Polk on 8/6/15.
//  Copyright (c) 2015-2016 Bone Jarring Games and Software, LLC. All rights reserved.
//


import Foundation
import CoreData

class CharactersContext {
    static let managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.urlForResource("Characters", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    static let applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.bonejarring.Characters" in the application's documents Application Support directory.
        let urls = FileManager.default.urlsForDirectory(.documentDirectory, inDomains: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    let persistentStoreCoordinator: NSPersistentStoreCoordinator
    
    init() {
        let coordinator : NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: CharactersContext.managedObjectModel)
        let url = try! CharactersContext.applicationDocumentsDirectory.appendingPathComponent("Characters.sqlite")
        let failureReason = "There was an error creating or loading the application's saved data."
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as! NSString
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
            
        persistentStoreCoordinator = coordinator
    }

    // MARK: - Core Data Saving support
    
    func saveContext () throws {
        let context = self.managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
                try self.fetchedResultsController.performFetch()
            } catch {
                // Let me just say that decoding Core Data errors in Swift is amazingly painful.
                
                let nserror = error as NSError
                
                // At this point nserror.userInfo has a handy dictionary explaining what went wrong.
                // However, you can't cast this dictionary (declared as [NSObject : AnyObject]?) to
                // "as! [String:String]. It compiles, but when you do the "let userInfo = ", the
                // runtime fails to convert the CoreFoundation object.
                
                // So you have to get the keys and values and cast each one of them looking for
                // the specific error case you are interested in. Wow. This will have to be split
                // into its own class at some point. This is going to get really gross.
                
                
                if (nserror.domain == NSCocoaErrorDomain) {
                    let code = nserror.code
                    let userInfo = nserror.userInfo as! [String:AnyObject]
                    if (code == NSValidationStringTooShortError) {
                        let foundValidationErrorValue = userInfo["NSValidationErrorValue"] as! String
                        if (foundValidationErrorValue == "") {
                            let creature = userInfo["NSValidationErrorObject"] as! Creature
                            context.rollback()
                            print ("Name for \(creature.name) cannot be set to the empty string")
                            throw Creature.CreatureDataError.nameCannotBeNull
                        }
                    }
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                } else {
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
            }
        }
    }
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Creature.fetchRequest()
        // Set the batch size to a suitable number.
        
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = SortDescriptor(key: "name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: "Master")
        return fetchedResultsController
    }()
}
