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
        var transactionsController = TransactionsController()
        var ability = Ability(name: "Dummy", score: 10, transactions: transactionsController)
        XCTAssertEqual(ability.baseScore, 10)

        transactionsController = TransactionsController()
        ability = Ability(name: "Dummy", score: -1, transactions: transactionsController)
        XCTAssertEqual(ability.baseScore, 0)

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
