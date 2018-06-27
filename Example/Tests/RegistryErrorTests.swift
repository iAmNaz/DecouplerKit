//
//  RegistryErrorTests.swift
//  DecouplerKit_Tests
//
//  Created by Nazario Mariano on 27/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import DecouplerKit

class RegistryErrorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRegistryErrorReturnsLocaizedDescription() {
        let errorDesc = "errorhere"
        let error = RegistryError.set(description: errorDesc)
        XCTAssertTrue(error.localizedDescription == errorDesc)
    }
}
