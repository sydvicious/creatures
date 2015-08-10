//
//  TestCreatures.swift
//  Characters
//
//  Created by Syd Polk on 6/12/15.
//
//

import XCTest
import CoreData
@testable import Characters

class TestCharactersContext: CharactersContext {
    init () {
        let newpsc : NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: CharactersContext.managedObjectModel)
            
        let failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
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
        }()
        super.init(newpsc)
    }
}

class TestCreatures: XCTestCase {

    lazy var creaturesController = CreaturesController(fromContext: TestCharactersContext())
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        creaturesController.deleteAll()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreate() {
        let creature = try! creaturesController.createCreature("TestCreature1")
        XCTAssertNotNil(creature, "creature was nil in testCreate.")
    }
    
    func testDelete() {
        creaturesController.logAll()
        let creature = try! creaturesController.createCreature("TestCreature2")
        creaturesController.logAll()
        print(creature.name)
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        creaturesController.deleteCreatureAtIndexPath(indexPath)
        creaturesController.logAll()
        let creatures = creaturesController.creatures()
        XCTAssertEqual(creatures.count, 0, "Creatures array not zero.")
    }
    
    func testName() {
        let creature = try! creaturesController.createCreature("TestCreature3")
        try! creaturesController.saveName("TestCreature3.1", forCreature: creature)
        let name = creature.name
        XCTAssertEqual(name, "TestCreature3.1", "Name operation failed.")

        do {
            try creaturesController.saveName("", forCreature: creature)
            XCTFail("testName() was supposed to throw if name was the null string.")
        } catch Creature.CreatureDataError.NameCannotBeNull {
            // Yay. We pass
        } catch {
            let nserror = error as NSError
            XCTFail("Some other error happened when we tried to set name to null. Error code = \(nserror.code); domain = \(nserror.domain); description = \(nserror.localizedDescription)")
        }
    }
    
}
