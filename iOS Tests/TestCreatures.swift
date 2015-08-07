//
//  TestCreatures.swift
//  Characters
//
//  Created by Syd Polk on 6/12/15.
//
//

import XCTest
@testable import Characters

class TestCreatures: XCTestCase {

    lazy var creaturesController = CreaturesController()
    
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
        let creature = creaturesController.createCreature("TestCreature1")
        XCTAssertNotNil(creature, "creature was nil in testCreate.")
    }
    
    func testDelete() {
        creaturesController.logAll()
        let creature = creaturesController.createCreature("TestCreature2")
        creaturesController.logAll()
        print(creature.name)
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        creaturesController.deleteCreatureAtIndexPath(indexPath)
        creaturesController.logAll()
        let creatures = creaturesController.creatures()
        XCTAssertEqual(creatures.count, 0, "Creatures array not zero.")
    }
    
    func testName() {
        let creature = creaturesController.createCreature("TestCreature3")
        creature.name = "TestCreature3.1"
        let name = creature.name
        XCTAssertEqual(name, "TestCreatures3.1", "Name operation failed.")
    }
    
}
