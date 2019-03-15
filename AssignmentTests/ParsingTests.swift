//
//  APITests.swift
//  AssignmentTests
//
//  Created by Soroush Shahi on 3/15/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import XCTest

@testable import Assignment

class ParsingTests: XCTestCase {
    
    var networkUnderTest : Operator.Type!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        networkUnderTest = Operator.self
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        networkUnderTest = nil
    }

    func testMovieQueryParsing() {
        
        let promise = expectation(description: "Parsing succeeded.")
        networkUnderTest.instance.parseSearchResult(name: Strings.batman, page: 1) { (response) in
            if let _ = response.data as? QueryResult {
                promise.fulfill()
            } else {
                XCTFail("Error: \(response.error?.localizedDescription ?? "Unknown")")
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
        
    }
    
    func testMoviePosterFetching() {
        let promise = expectation(description: "Fetching succeeded.")
        networkUnderTest.instance.getMoviePoster(size: .medium, poster: Posters.obj) { (response) in
            if let _ = response.data {
                promise.fulfill()
            }
            else {
                XCTFail("Error: \(response.error?.localizedDescription ?? "Unknown")")
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testInvalidMoviePosterFetching() { // make sure testAPI() succeeds before doing anything based on the result of this test.

        let promise = expectation(description: "Fetching unsucceeded.")
        networkUnderTest.instance.getMoviePoster(size: .medium, poster: Posters.invalidObj) { (response) in
            if let _ = response.data {
                XCTFail("Error: invalid data are returned")
            }
            else if response.error != nil {
                promise.fulfill()
                
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
