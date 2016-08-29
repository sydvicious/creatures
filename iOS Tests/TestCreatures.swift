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

class TestCreatures: XCTestCase {

    lazy var creaturesController = CreaturesController.sharedCreaturesController(CharactersContext())
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        creaturesController.deleteAll()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        creaturesController.deleteAll()
        super.tearDown()
    }
    
    func testCreate() {
        let creature = try! creaturesController.createCreature("TestCreature1")
        XCTAssertNotNil(creature, "creature was nil in testCreate.")
    }
    
    func testDelete() {
        creaturesController.logAll()
        let creatures = creaturesController.creatures()
        let startCount = creatures.count
        let creature = try! creaturesController.createCreature("TestCreature2")
        creaturesController.logAll()
        print(creature.name)
        let indexPath = IndexPath(item: 0, section: 0)
        creaturesController.deleteCreatureAtIndexPath(indexPath)
        creaturesController.logAll()
        XCTAssertEqual(creatures.count, startCount, "Did not have same number of creatures at the end.")
    }
    
    func testName() {
        let creature = try! creaturesController.createCreature("TestCreature3")
        try! creaturesController.saveName("TestCreature3.1", forCreature: creature)
        var name = creature.name
        XCTAssertEqual(name, "TestCreature3.1", "Name operation failed.")

        try! creaturesController.saveName(" TestCreature3.2", forCreature: creature)
        name = creature.name
        XCTAssertEqual(name, "TestCreature3.2", "Leading space test failed.")

        try! creaturesController.saveName("TestCreature3.3 ", forCreature: creature)
        name = creature.name
        XCTAssertEqual(name, "TestCreature3.3", "Trailing space test failed.")

        try! creaturesController.saveName(" TestCreature3.4 ", forCreature: creature)
        name = creature.name
        XCTAssertEqual(name, "TestCreature3.4", "Leading and trailing spaces test failed.")
        
        try! creaturesController.saveName(" TestCreature3.5 ", forCreature: creature)
        name = creature.name
        XCTAssertEqual(name, "TestCreature3.5", "Leading and trailing non-breaking spaces test failed.")
        
        try! creaturesController.saveName("\tTestCreature3.6\t", forCreature: creature)
        name = creature.name
        XCTAssertEqual(name, "TestCreature3.6", "Leading and trailing tabs test failed.")

        try! creaturesController.saveName("\nTestCreature3.7\n", forCreature: creature)
        name = creature.name
        XCTAssertEqual(name, "TestCreature3.7", "Leading and trailing newlines test failed.")
        
        try! creaturesController.saveName("\rTestCreature3.8\r", forCreature: creature)
        name = creature.name
        XCTAssertEqual(name, "TestCreature3.8", "Leading and trailing carriage returns test failed.")
        
        do {
            try creaturesController.saveName("", forCreature: creature)
            XCTFail("saveName() was supposed to return an error if name was the null string.")
        } catch Creature.CreatureDataError.nameCannotBeNull {
            // Yay. We pass
        } catch {
            let nserror = error as NSError
            XCTFail("Some other error happened when we tried to set name to null. Error code = \(nserror.code); domain = \(nserror.domain); description = \(nserror.localizedDescription)")
        }

        do {
            try creaturesController.saveName("  ", forCreature: creature)
            XCTFail("saveName() was supposed to return an error if trimmed name was the null string.")
        } catch Creature.CreatureDataError.nameCannotBeNull {
            // Yay. We pass
        } catch {
            let nserror = error as NSError
            XCTFail("Some other error happened when we tried to set name to null. Error code = \(nserror.code); domain = \(nserror.domain); description = \(nserror.localizedDescription)")
        }

    }
    
}
