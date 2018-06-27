//
//  ResponseTests.swift
//  DecouplerKit_Tests
//
//  Created by Nazario Mariano on 27/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import DecouplerKit_Example
import DecouplerKit
class ResponseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestEquality() {
        let validationTask = Task.Form(.Validate(.AddSession))
        let req1 = Request(proc: validationTask)
        let resp1 = Response(request: req1)
        let resp2 = Response(request: req1)
        XCTAssert(resp1 == resp2)
    }
    
    func testSetPayloadReturnsCorrectBody() {
        let vm = FormViewModel(name: "form")
        let validationTask = Task.Form(.Validate(.AddSession))
        let req1 = Response(proc: validationTask, body: vm)
        let reqData: FormViewModel = req1.body()
        XCTAssert(vm.name == reqData.name)
    }
    
    func testSetProcessCorrectValueSet() {
        let validationTask = Task.Form(.Validate(.AddSession))
        let req1 = Response(proc: validationTask)
        XCTAssert(req1.process.key == validationTask.key)
    }
}
