//
//  MCUTests.swift
//  MCUTests
//
//  Created by Naman Vaishnav on 20/08/22.
//

import XCTest
@testable import MCU

class MCUTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

extension XCTestCase {
    
    func waitOrFail(timeout: TimeInterval) {
        let expectation = self.expectation(description: #function)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeout, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: timeout)
    }
}
