//
//  DataPersistencyTests.swift
//  AssignmentTests
//
//  Created by Soroush Shahi on 3/15/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import XCTest

@testable import Assignment




class DataPersistencyTests: XCTestCase {
    
    var vc : SearchVC!
    var mockUserDefaults: MockUserDefaults!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        vc = SearchVC(nibName: "SearchVC", bundle: nil)
        mockUserDefaults = MockUserDefaults(suiteName: "testing")!
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        vc = nil
        mockUserDefaults = nil
    }

    func testUserDefaults() {
        vc.query = Strings.batman
        vc.viewDidLoad()
        vc.viewDidAppear(true)
        Operator.instance.defaults = mockUserDefaults
        let promise = expectation(description: "Save succeeded.")
        let result = XCTWaiter.wait(for: [promise], timeout: 3)
        if result == XCTWaiter.Result.timedOut {
            if let arr = mockUserDefaults.value(forKey: UserDefaultsKeys.queries) as? [String] {
                
                if arr.first == Strings.batman {
                    promise.fulfill()
                }
                else {
                    XCTFail("Error: query is not correctly saved in userdefaults. should have saved \(Strings.batman) but has saved \(arr.first ?? "")")
                }
            }
            else {
               XCTFail("Error: query is not successfully saved in userdefaults.")
            }
        }
        else {
            XCTFail("Delay interrupted")
        }
        
    }
    
    func testUserDefaultsforAnInvalidQuery() { // make sure testAPI() succeeds before doing anything based on the result of this test.
        vc.query = Strings.invalid
        vc.viewDidLoad()
        vc.viewDidAppear(true)
        Operator.instance.defaults = mockUserDefaults
        let promise = expectation(description: "Save succeeded.")
        let result = XCTWaiter.wait(for: [promise], timeout: 3)
        if result == XCTWaiter.Result.timedOut {
            if let _ = mockUserDefaults.value(forKey: UserDefaultsKeys.queries) as? [String] {
                XCTFail("Error: invalid query is saved in userdefaults.")
            }
            else {
                promise.fulfill()
            }
        }
        else {
            XCTFail("Delay interrupted")
        }
        
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
