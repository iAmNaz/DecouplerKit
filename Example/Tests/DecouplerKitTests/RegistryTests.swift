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

class SomeClass: NSObject {
    
}

class RegistryTests: XCTestCase {
    let registrationFatalErrorDescription = "Handler should implement the Interface protocol. Check if you added the interface in your class i.e. Class: Interface {}";
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testControllerIsRegistered() {
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
        expectFatalError(expectedMessage: "Class not registered!") {
            registry.tx(request: request)
        }
    }
    
    func testRegisteredWithKeyShouldCauseFatalErrorWhenClassDoNotConformToInterface() {
        let controller = SomeClass()
        let registry = ResponderRegistry()
        expectFatalError(expectedMessage: self.registrationFatalErrorDescription) {
            registry.register(inputHandler: controller, withKey: "keys")
        }
    }
    
    func testRegisteredShouldCauseFatalErrorWhenClassDoNotConformToInterface() {
        let controller = SomeClass()
        let registry = ResponderRegistry()
        expectFatalError(expectedMessage: self.registrationFatalErrorDescription) {
            registry.register(inputHandler: controller)
        }
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
    
    func expectFatalError(expectedMessage: String, testcase: @escaping () -> Void) {
        
        // arrange
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String? = nil
        
        // override fatalError. This will pause forever when fatalError is called.
        FatalErrorUtil.replaceFatalError { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            unreachable()
        }
        
        // act, perform on separate thead because a call to fatalError pauses forever
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: 0.1) { _ in
            // assert
            XCTAssertEqual(assertionMessage, expectedMessage)
            
            // clean up
            FatalErrorUtil.restoreFatalError()
        }
    }
}
