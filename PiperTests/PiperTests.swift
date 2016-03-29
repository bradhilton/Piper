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
    
    func testExample() {
        let expectation = expectationWithDescription("Expectation")
        let start = NSDate()
        background {
            // Perform a long running background operation...
            return (0..<100_000_000).reduce(0) { value, index in
                return value + 1
            }
        }.finally { result in
            // Do something on main thread with result...
            print(result) // 100000000
        }
        background {
            return 89
        }.main {
            return $0 + 11
        }.finally {
            print($0)
        }
        after(1).background {
            return NSDate()
        }.after(2.2).finally { (background: NSDate) in
            print(background.timeIntervalSinceDate(start), NSDate().timeIntervalSinceDate(background), NSDate().timeIntervalSinceDate(start))
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testPerformanceExample() {
        
    }
    
}
