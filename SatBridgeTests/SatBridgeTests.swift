//
//  SatBridgeTests.swift
//  SatBridgeTests
//
//  Created by Pavle Mijatovic on 2/23/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import XCTest
import SatBridge
@testable import SatBridge

class SatBridgeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Reference a Realm object in a test
        XCTAssertNotNil(CallLog())
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
