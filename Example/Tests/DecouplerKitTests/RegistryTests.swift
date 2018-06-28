//
//  RegistryTests.swift
//  DecouplerKit_Tests
//
//  Created by Nazario Mariano on 27/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import DecouplerKit
import PromiseKit

class RegistryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstollerIsRegistered() {
        let controller = FormController()
        let registry = ResponderRegistry()
        registry.register(inputHandler: controller)
        let task = Task.Form(.Validate(.AddSession))
        XCTAssertTrue(registry.isRegistered(withProcess: task))
    }
    
    func testTransmitMethodReturns() {
        let controller = FormController()
        let registry = ResponderRegistry()
        let formatter = DateFormatter()
        let request = Request(proc: Task.Form(.Validate(.AddSession)), body: ExerciseSessionViewModel(dateFormatter: formatter, uniqueId: uniqueID(), name: "name", date: Date(), duration: Date()))
        registry.register(inputHandler: controller)
        let promise = registry.tx(request: request)
            XCTAssertTrue(promise.isFulfilled)
        let response: Response = promise.value as! Response
        let originalProcess = response.process
        
        XCTAssertTrue(originalProcess?.key == request.process.key)
    }
    
    func testTransmitMethodReturnsError() {
        let controller = FormController()
        let registry = ResponderRegistry()
        let formatter = DateFormatter()
        let request = Request(proc: Task.Exercise(.add), body: ExerciseSessionViewModel(dateFormatter: formatter, uniqueId: uniqueID(), name: "name", date: Date(), duration: Date()))
            registry.register(inputHandler: controller)
        let promise = registry.tx(request: request)
        XCTAssertTrue(promise.isRejected)
    }
    
    func testResponseReturnsRequest() {
        let controller = FormController()
        let registry = ResponderRegistry()
        let formatter = DateFormatter()
        let request = Request(proc: Task.Form(.Validate(.AddSession)), body: ExerciseSessionViewModel(dateFormatter: formatter, uniqueId: uniqueID(), name: "name", date: Date(), duration: Date()))
        registry.register(inputHandler: controller)
        let promise = registry.tx(request: request)
        XCTAssertTrue(promise.isFulfilled)
        let response: Response = promise.value as! Response
        
        XCTAssertNotNil(response.request())
    }
}
