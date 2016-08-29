//
//  TestD20Bonuses.swift
//  Characters
//
//  Created by Syd Polk on 8/28/16.
//
//

import XCTest
@testable import Characters


class TestD20Bonuses: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testD20BonusInfo() {
        var info = d20BonusInfo(1, makePermanent: true, withRounds: 0)
        XCTAssertEqual(info.value, 1)
        XCTAssertEqual(info.state, .Permanent)
        XCTAssertEqual(info.rounds, 0)
        
        var decrResult = info.decrementRounds()
        XCTAssertEqual(info.state, .Permanent)
        XCTAssertEqual(info.rounds, 0)
        XCTAssertEqual(decrResult, .Permanent)
        
        info = d20BonusInfo(-1, makePermanent: false, withRounds: 3)
        XCTAssertEqual(info.value, -1)
        XCTAssertEqual(info.state, .Temporary)
        XCTAssertEqual(info.rounds, 3)
        
        decrResult = info.decrementRounds()
        XCTAssertEqual(info.state, .Temporary)
        XCTAssertEqual(info.rounds, 2)
        XCTAssertEqual(decrResult, .Temporary)

        decrResult = info.decrementRounds()
        decrResult = info.decrementRounds()
        XCTAssertEqual(info.state, .Expired)
        XCTAssertEqual(info.rounds, 0)
        XCTAssertEqual(decrResult, .Expired)
        
        decrResult = info.decrementRounds()
        XCTAssertEqual(info.state, .Expired)
        XCTAssertEqual(info.rounds, 0)
        XCTAssertEqual(decrResult, .Expired)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
