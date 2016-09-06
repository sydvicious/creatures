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
        var info = d20BonusInfo(newPermanentValue: 1)
        XCTAssertEqual(info.value, 1)
        XCTAssertEqual(info.state, .Permanent)
        XCTAssertEqual(info.rounds, 0)
        
        var decrResult = info.decrementRounds()
        XCTAssertEqual(info.state, .Permanent)
        XCTAssertEqual(info.rounds, 0)
        XCTAssertEqual(decrResult, .Permanent)
        
        info = d20BonusInfo(newTemporaryValue: -1, withRounds: 3)
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
    
    func testD20BonusInfoDict() {
        var infoDict = d20BonusInfoDict()
        
        infoDict.addPermanent(withSource: "test1", withValue: 1)
        var netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 1)
        var d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        infoDict.remove(source: "test1")
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 0)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertEqual(d20BonusState, .Expired)
        
        infoDict.addPermanent(withSource: "test1", withValue: 1)
        infoDict.addPermanent(withSource: "test2", withValue: 2)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 2)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        infoDict.remove(source: "test1")
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 2)
        infoDict.remove(source: "test2")
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 0)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertEqual(d20BonusState, .Expired)

        infoDict.addTemporary(withSource: "test1", withValue: 1, withRounds: 3)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 1)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertEqual(d20BonusState, .Expired)
        
        infoDict.addTemporary(withSource: "test1", withValue: 1, withRounds: 2)
        infoDict.addTemporary(withSource: "test2", withValue: 2, withRounds: 1)
        infoDict.addTemporary(withSource: "test3", withValue: -1, withRounds: 3)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 2)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 1)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, -1)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertEqual(d20BonusState, .Expired)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 0)
        
        infoDict.addPermanent(withSource: "test1", withValue: 1)
        infoDict.addTemporary(withSource: "test2", withValue: 2, withRounds: 1)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 2)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 1)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 1)
        
        infoDict.addPermanent(withSource: "test1", withValue: 2)
        infoDict.addTemporary(withSource: "test2", withValue: 1, withRounds: 1)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 2)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 2)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 2)

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
