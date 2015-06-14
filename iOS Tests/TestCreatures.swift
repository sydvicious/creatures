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
        creaturesController.deleteAll()
        super.tearDown()
    }
    
    func testCreate() {
        let creature = creaturesController.createCreature("TestCreature1")
        XCTAssertNotNil(creature, "creature was nil in testCreate.")
        creaturesController.deleteCreature(creature)
    }
    
    func testDelete() {
        let creature = creaturesController.createCreature("TestCreature2")
        creaturesController.deleteCreature(creature)
        let creatures = creaturesController.creatures()
        print(creatures.count)
        XCTAssertEqual(creatures.count, 0, "Creatures array not zero.")
    }
    
    func testName() {
        let creature = creaturesController.createCreature("TestCreature3")
        creature.name = "TestCreature3.1"
        let name = creature.name
        XCTAssertEqual(name, "TestCreatures3.1", "Name operation failed.")
    }
    
}
