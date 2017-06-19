//
//  DiveAdvisorTests.swift
//  DiveAdvisorTests
//
//  Created by ben smith on 14/06/17.
//  Copyright © 2017 ben smith. All rights reserved.
//

import CoreData

import XCTest
@testable import DiveAdvisor

//extension DiveDetails {
//
//    convenience init(id: Int16, image: NSObject?, normalTemperature: Double, review: String, waterTemperature: Double) {
//        self.init()
//        self.id = id
//        self.image = image
//        self.normalTemperature = normalTemperature
//        self.review = review
//        self.waterTemperature = waterTemperature
//    }
//}

class DiveAdvisorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStoreAndLoad() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //        XCTAssertEqual(storeDiveDetails(for details[0]), "HelloHelloHelloHelloHello")
        //        XCTAssert((user) != nil)
        //        XCTAssertTrue(success)
        //        XCTAssertFalse(bodyUpdate["firstName"] == originalUser.firstName)
        //        XCTFail()
        //        waitForExpectationsWithTimeout(10.0, handler:nil)
        
        var details: [InterfaceDiveDetails] = []
        details.append(InterfaceDiveDetails.init(id: 18828, image: nil, normalTemperature: 31, review: "review 18828", waterTemperature: 21))
        details.append(InterfaceDiveDetails(id: 18883, image: nil, normalTemperature: 32, review: "review 18883", waterTemperature: 22))
        details.append(InterfaceDiveDetails(id: 23255, image: nil, normalTemperature: 33, review: "review 23255", waterTemperature: 23))
        
        for detail in details {
            do {
                try CoreDataManager.sharedInstance.storeDiveDetails(for: detail)
            } catch {
                XCTFail("storeDiveDetails error")
            }
        }
    }
    
}
