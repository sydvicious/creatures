//
//  TestAbility.swift
//  Characters
//
//  Created by Syd Polk on 9/16/16.
//
//

import XCTest
@testable import Characters

class TestAbility: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAbility() {
        var ability = Ability(score: 10)
        XCTAssertEqual(ability.baseScore, 10)
        
        ability.baseScore = 12
        XCTAssertEqual(ability.baseScore, 12)
        
        ability.baseScore = -1
        XCTAssertEqual(ability.baseScore, 0)
        
        ability = Ability(score: -1)
        XCTAssertEqual(ability.baseScore, 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
