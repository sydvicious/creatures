//
//  TestD20Ability.swift
//  Characters
//
//  Created by Syd Polk on 9/16/16.
//
//

import XCTest
@testable import Characters

class TestD20Ability: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testD20Ability() {
        var ability = d20Ability(score: 0)
        XCTAssertEqual(ability.baseScore, 0)
        XCTAssertEqual(ability.currentScore, 0)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        var modifier = ability.modifier
        XCTAssertEqual(modifier, -5)

        ability = d20Ability(score: -1)
        XCTAssertEqual(ability.baseScore, 0)
        XCTAssertEqual(ability.currentScore, 0)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        modifier = ability.modifier
        XCTAssertEqual(modifier, -5)
        
        ability = d20Ability(score: 1)
        XCTAssertEqual(ability.baseScore, 1)
        XCTAssertEqual(ability.currentScore, 1)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        modifier = ability.modifier
        XCTAssertEqual(modifier, -5)
        
        ability = d20Ability(score: 2)
        XCTAssertEqual(ability.baseScore, 2)
        XCTAssertEqual(ability.currentScore, 2)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        modifier = ability.modifier
        XCTAssertEqual(modifier, -4)

        ability = d20Ability(score: 9)
        XCTAssertEqual(ability.baseScore, 9)
        XCTAssertEqual(ability.currentScore, 9)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        modifier = ability.modifier
        XCTAssertEqual(modifier, -1)

        ability = d20Ability(score: 10)
        XCTAssertEqual(ability.baseScore, 10)
        XCTAssertEqual(ability.currentScore, 10)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        modifier = ability.modifier
        XCTAssertEqual(modifier, 0)

        ability = d20Ability(score: 19)
        XCTAssertEqual(ability.baseScore, 19)
        XCTAssertEqual(ability.currentScore, 19)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        modifier = ability.modifier
        XCTAssertEqual(modifier, 4)

        ability = d20Ability(score: 20)
        XCTAssertEqual(ability.baseScore, 20)
        XCTAssertEqual(ability.currentScore, 20)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        modifier = ability.modifier
        XCTAssertEqual(modifier, 5)

        ability = d20Ability(score: 15)
        ability.bonus.addPermanent("race", fromSource: "Character Creation", withValue: 2)
        XCTAssertEqual(ability.baseScore, 15)
        XCTAssertEqual(ability.currentScore, 17)
        XCTAssertEqual(ability.bonus.netValue(), 2)
        modifier = ability.modifier
        XCTAssertEqual(modifier, 3)
        ability.bonus.addTemporary("enhancement", fromSource: "Bull's Strength", withValue: 1, withRounds: 1)
        modifier = ability.modifier
        XCTAssertEqual(modifier, 4)
        XCTAssertEqual(ability.baseScore, 15)
        XCTAssertEqual(ability.currentScore, 18)
        ability.bonus.decrementRounds()
        modifier = ability.modifier
        XCTAssertEqual(ability.baseScore, 15)
        XCTAssertEqual(ability.currentScore, 17)
        XCTAssertEqual(modifier, 3)
        ability.bonus.addTemporary("enhancement", fromSource: "Bull's Strength", withValue: 1, withRounds: 1)

        ability.baseScore = 10
        XCTAssertEqual(ability.baseScore, 10)
        XCTAssertEqual(ability.currentScore, 12)
        XCTAssertEqual(ability.bonus.netValue(), 2)
        modifier = ability.modifier
        XCTAssertEqual(modifier, 2)
        ability.bonus.decrementRounds()
        modifier = ability.modifier
        XCTAssertEqual(ability.baseScore, 10)
        XCTAssertEqual(ability.currentScore, 12)
        XCTAssertEqual(modifier, 1)

        ability.baseScore = -1
        XCTAssertEqual(ability.baseScore, 0)
        XCTAssertEqual(ability.currentScore, 2)
        XCTAssertEqual(ability.bonus.netValue(), 2)
        modifier = ability.modifier
        XCTAssertEqual(modifier, -4)
        ability.bonus.decrementRounds()
        modifier = ability.modifier
        XCTAssertEqual(ability.baseScore, 10)
        XCTAssertEqual(ability.currentScore, 12)
        XCTAssertEqual(modifier, 1)
        
        

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
