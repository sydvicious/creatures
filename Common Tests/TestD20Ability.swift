//
//  TestD20Ability.swift
//  Characters
//
//  Created by Syd Polk on 9/16/16.
//  Copyright (c) 2016 Bone Jarring Games and Software, LLC. All rights reserved.
//  Copyright © 2022 Syd Polk (reassigned). All rights reserved.
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
        var transactionsController = TransactionsController()
        var ability = d20Ability(key: .Strength, score: 0, transactions: transactionsController)
        XCTAssertEqual(ability.baseScore, 0)
        XCTAssertEqual(ability.currentScore, 0)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        var modifier = ability.modifier
        XCTAssertEqual(modifier, -5)

        transactionsController = TransactionsController()
        ability = d20Ability(key: .Strength, score: -1, transactions: transactionsController)
        XCTAssertEqual(ability.baseScore, 0)
        XCTAssertEqual(ability.currentScore, 0)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        modifier = ability.modifier
        XCTAssertEqual(modifier, -5)

        transactionsController = TransactionsController()
        ability = d20Ability(key: .Strength, score: 1, transactions: transactionsController)
        XCTAssertEqual(ability.baseScore, 1)
        XCTAssertEqual(ability.currentScore, 1)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        modifier = ability.modifier
        XCTAssertEqual(modifier, -5)
        
        transactionsController = TransactionsController()
        ability = d20Ability(key: .Strength, score: 2, transactions: transactionsController)
        XCTAssertEqual(ability.baseScore, 2)
        XCTAssertEqual(ability.currentScore, 2)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        modifier = ability.modifier
        XCTAssertEqual(modifier, -4)

        transactionsController = TransactionsController()
        ability = d20Ability(key: .Strength, score: 9, transactions: transactionsController)
        XCTAssertEqual(ability.baseScore, 9)
        XCTAssertEqual(ability.currentScore, 9)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        modifier = ability.modifier
        XCTAssertEqual(modifier, -1)

        transactionsController = TransactionsController()
        ability = d20Ability(key: .Strength, score: 10, transactions: transactionsController)
        XCTAssertEqual(ability.baseScore, 10)
        XCTAssertEqual(ability.currentScore, 10)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        modifier = ability.modifier
        XCTAssertEqual(modifier, 0)

        transactionsController = TransactionsController()
        ability = d20Ability(key: .Strength, score: 19, transactions: transactionsController)
        XCTAssertEqual(ability.baseScore, 19)
        XCTAssertEqual(ability.currentScore, 19)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        modifier = ability.modifier
        XCTAssertEqual(modifier, 4)

        transactionsController = TransactionsController()
        ability = d20Ability(key: .Strength, score: 20, transactions: transactionsController)
        XCTAssertEqual(ability.baseScore, 20)
        XCTAssertEqual(ability.currentScore, 20)
        XCTAssertEqual(ability.bonus.netValue(), 0)
        modifier = ability.modifier
        XCTAssertEqual(modifier, 5)

        transactionsController = TransactionsController()
        ability = d20Ability(key: .Strength, score: 15, transactions: transactionsController)
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

    }
    
}
