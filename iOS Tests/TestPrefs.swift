//
//  TestPrefs.swift
//  Characters
//
//  Created by Syd Polk on 6/12/15.
//
//

import XCTest
@testable import Characters

class TestPrefs: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        let uuid1 = Prefs.getNewID()
        XCTAssertNotNil(uuid1, "TestPrefs: uuid1 returned nil!")
        let uuid2 = Prefs.getNewID()
        XCTAssertNotNil(uuid2, "TestPrefs: uuid2 returned nil!")
        XCTAssertNotEqual(uuid1, uuid2, "TestPrefs: uuid1 and uuid2 are equal.")
    }

}
