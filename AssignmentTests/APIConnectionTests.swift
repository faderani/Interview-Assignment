//
//  APIConnectionTests.swift
//  AssignmentTests
//
//  Created by Soroush Shahi on 3/15/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import XCTest
import Alamofire


class APIConnectionTests: XCTestCase {
    
    var apiUnderTest : Network.Type!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        apiUnderTest = Network.self

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiUnderTest = nil
    }

    func testAPI () {
        

        let promise = expectation(description: "API is working.")
        promise.expectedFulfillmentCount = 3
        Network.request(urlRequest: .getImages(id: Int.random(in: 100..<200))) { (response) in
            if response.error != nil {
                XCTFail("getImage is not working")
            }
            else {
                promise.fulfill()
            }
        }
        
        Network.requestImage(urlRequest: .getPoster(size: Strings.size, path: Strings.path)) { (response) in
            if response.error != nil {
                
                XCTFail("getPoseter is not working")
            }
            else {
                promise.fulfill()
            }
        }
        
        Network.request(urlRequest: .searchMovie(name: Strings.batman + "\(Int.random(in: 100..<200))", page: 1)) { (response) in
            if response.error != nil {
                XCTFail("getPoseter is not working")
            }
            else {
                promise.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
