//
//  gankioTests.swift
//  gankioTests
//
//  Created by za-wanghe on 2019/1/12.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import XCTest
@testable import gankio

class gankioTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        let str = "2019-01-24"
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = "yyyy-MM-dd"
        let date = dateForamtter.date(from: str)
        let string = dateForamtter.string(from: date!)
        print(string)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
