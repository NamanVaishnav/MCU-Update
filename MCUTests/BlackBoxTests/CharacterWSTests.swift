//
//  CharacterWSTests.swift
//  MCUTests
//
//  Created by Naman Vaishnav on 22/08/22.
//

import XCTest
@testable import MCU

class CharacterWSTests: XCTestCase {
    var serviceObj: CharacterWS!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   
    func test_service_response_Success(){
        // ARRANGE
        serviceObj = CharacterWS(pageSize: 10, offset: 0, searchQuery: "")
        
        let fetchCharacterListExpectations = expectation(description: "response_should_come_from_backend")
        // ACT
        serviceObj.fetchCharacters { result in
            // ASSERT
            XCTAssertNotNil(result, "Response coming nil for given input")
            fetchCharacterListExpectations.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
