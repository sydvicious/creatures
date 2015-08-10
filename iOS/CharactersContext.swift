//
//  CharactersManagedObjectContext.swift
//  Characters
//
//  Created by Syd Polk on 8/6/15.
//
//

import Foundation
import CoreData

class CharactersContext {
    static let managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Characters", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()

    static let applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.bonejarring.Characters" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
        }()
    
    let persistentStoreCoordinator: NSPersistentStoreCoordinator
    
    init(_ psc : NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = applicationDocumentsDirectory.URLByAppendingPathComponent("Characters.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        var options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options)
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
        
        return coordinator
        } () ) {
            persistentStoreCoordinator = psc
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
                            throw Creature.CreatureDataError.NameCannotBeNull
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
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    lazy var fetchRequest = NSFetchRequest()
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        self.fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("Creature", inManagedObjectContext: self.managedObjectContext)
        self.fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        self.fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true, selector: "caseInsensitiveCompare:")
        
        self.fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: "Master")
        return fetchedResultsController
        }()

}
