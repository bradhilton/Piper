//
//  PiperTests.swift
//  PiperTests
//
//  Created by Bradley Hilton on 3/29/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import XCTest
import Piper

class PiperTests: XCTestCase {
    
    func testAfter() {
        let expectation = expectationWithDescription("after")
        let start = NSDate()
        after(1).background {
            return NSDate()
        }.after(2.2).finally { (background: NSDate) in
            XCTAssert(background.timeIntervalSinceDate(start) > 1)
            XCTAssert(NSDate().timeIntervalSinceDate(background) > 2)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(4, handler: nil)
    }
    
}
