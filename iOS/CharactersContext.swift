//
//  CharactersManagedObjectContext.swift
//  Characters
//
//  Created by Syd Polk on 8/6/15.
//  Copyright (c) 2015-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//


import Foundation
import CoreData

class CharactersContext: NSObject, NSFetchedResultsControllerDelegate {
    // MARK: - Core Data stack

    var managedObjectContext: NSManagedObjectContext? = nil
    var persistentContainer: NSPersistentContainer? = nil
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? = nil
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "Characters", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()


    init (forTest: Bool = false, name: String) {
        super.init()
        
        persistentContainer = {
            /*
             The persistent container for the application. This implementation
             creates and returns a container, having loaded the store for the
             application to it. This property is optional since there are legitimate
             error conditions that could cause the creation of the store to fail.
             */
            let container = NSPersistentContainer(name: name, managedObjectModel: managedObjectModel)

            if (forTest) {
                let description = NSPersistentStoreDescription()
                description.type = NSInMemoryStoreType
                container.persistentStoreDescriptions = [description]
            }
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
                self.managedObjectContext = container.viewContext
                self.fetchedResultsController = {
                    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CreatureModel.fetchRequest()
                    // Set the batch size to a suitable number.

                    fetchRequest.fetchBatchSize = 20

                    // Edit the sort key as appropriate.
                    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))

                    fetchRequest.sortDescriptors = [sortDescriptor]

                    // Edit the section name key path and cache name if appropriate.
                    // nil for section name key path means "no sections".
                    let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: (forTest ? nil : "Master"))
                    return fetchedResultsController
                }()
            })
            return container
        }()
    }
    
    
    // MARK: - Core Data Saving support
    
    func saveContext () throws {
        let context = self.managedObjectContext
        if (context?.hasChanges)! {
            do {
                try context?.save()
                try self.fetchedResultsController?.performFetch()
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
                    let userInfo = nserror.userInfo
                    if (code == NSValidationStringTooShortError) {
                        let foundValidationErrorValue = userInfo["NSValidationErrorValue"] as! String
                        if (foundValidationErrorValue == "") {
                            let creature = userInfo["NSValidationErrorObject"] as! CreatureModel
                            context?.rollback()
                            print ("Name for \(String(describing: creature.name)) cannot be set to the empty string")
                            throw CreatureModel.CreatureModelDataError.nameCannotBeNull
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
        
}
