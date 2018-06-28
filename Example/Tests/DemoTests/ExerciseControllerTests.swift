//
//  ExerciseControllerTests.swift
//  DecouplerKit_Tests
//
//  Created by Nazario Mariano on 28/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import DecouplerKit_Example
import DecouplerKit
class ExerciseControllerTests: XCTestCase {
    let dateFormatter = DateFormatter()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddSessionSavesSession() {
        let session = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: "test", date: Date(), duration: Date())
        let dataStore = FakePersistentStoreController()
        let controller = ExerciseController()
        controller.dataStoreController = dataStore as PersistentStore
        
        let addRequest = Request(proc: Task.Exercise(.add), body: session)
        let promise = controller.tx(request: addRequest)
        XCTAssertTrue(promise.isFulfilled)
    }
    
    func testDeleteSessionGetsDeletedSession() {
        let session = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: "test", date: Date(), duration: Date())
        let dataStore = FakePersistentStoreController()
        let controller = ExerciseController()
        controller.dataStoreController = dataStore as PersistentStore
        
        let addRequest = Request(proc: Task.Exercise(.add), body: session)
        let promise = controller.tx(request: addRequest)
        XCTAssertTrue(promise.isFulfilled)
        
        let deleteRequest = Request(proc: Task.Exercise(.delete), body: session)
        let promise2 = controller.tx(request: deleteRequest)
        XCTAssertTrue(promise2.isFulfilled)
        let response = promise2.value as! Response
        let deletedSession: ExerciseSessionViewModel = response.body()

        XCTAssertTrue(deletedSession == session)
    }

    func testDeleteUnsavedSessionReturnsError() {
        let session1 = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: "test", date: Date(), duration: Date())
        let session2 = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: "test", date: Date(), duration: Date())

        let dataStore = FakePersistentStoreController()
        let controller = ExerciseController()
        controller.dataStoreController = dataStore as PersistentStore
        
        let addRequest = Request(proc: Task.Exercise(.add), body: session1)
        let promise = controller.tx(request: addRequest)
        XCTAssertTrue(promise.isFulfilled)
        
        let deleteRequest = Request(proc: Task.Exercise(.delete), body: session2)
        let promise2 = controller.tx(request: deleteRequest)
        XCTAssertTrue(promise2.isRejected)
    }
    
    func testListSessionsReturnOneSession() {
        let session = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: "test", date: Date(), duration: Date())
        let dataStore = FakePersistentStoreController()
        let controller = ExerciseController()
            controller.dateFormatter = dateFormatter
            controller.dataStoreController = dataStore as PersistentStore
        
        let addRequest = Request(proc: Task.Exercise(.add), body: session)
        let promise = controller.tx(request: addRequest)
        XCTAssertTrue(promise.isFulfilled)
        
        let listRequest = Request(proc: Task.Exercise(.list))
        let promise2 = controller.tx(request: listRequest)
        XCTAssertTrue(promise2.isFulfilled)
        let response = promise2.value as! Response
        let list: [ExerciseSessionViewModel] = response.body()
        
        XCTAssertTrue(list.count == 1)
    }
    
    func testListSessionsReturnTwoSessions() {
        let session1 = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: "1", date: Date(), duration: Date())
        let session2 = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: "2", date: Date(), duration: Date())

        let dataStore = FakePersistentStoreController()
        let controller = ExerciseController()
            controller.dateFormatter = dateFormatter
            controller.dataStoreController = dataStore as PersistentStore
        
        let addRequest1 = Request(proc: Task.Exercise(.add), body: session1)
        XCTAssertTrue(controller.tx(request: addRequest1).isFulfilled)
        
        let addRequest2 = Request(proc: Task.Exercise(.add), body: session2)
        XCTAssertTrue(controller.tx(request: addRequest2).isFulfilled)
        
        let listRequest = Request(proc: Task.Exercise(.list))
        let promise2 = controller.tx(request: listRequest)
        XCTAssertTrue(promise2.isFulfilled)
        let response = promise2.value as! Response
        let list: [ExerciseSessionViewModel] = response.body()
        
        XCTAssertTrue(list.count == 2)
    }
    
    func testDeleteOneSessionReturnOneSessions() {
        let session1 = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: "1", date: Date(), duration: Date())
        let session2 = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: "2", date: Date(), duration: Date())
        let dataStore = FakePersistentStoreController()
        let controller = ExerciseController()
        controller.dateFormatter = dateFormatter
        controller.dataStoreController = dataStore as PersistentStore
        
        let addRequest1 = Request(proc: Task.Exercise(.add), body: session1)
        XCTAssertTrue(controller.tx(request: addRequest1).isFulfilled)
        
        let addRequest2 = Request(proc: Task.Exercise(.add), body: session2)
        XCTAssertTrue(controller.tx(request: addRequest2).isFulfilled)
        
        let deleteRequest = Request(proc: Task.Exercise(.delete), body: session2)
        XCTAssertTrue(controller.tx(request: deleteRequest).isFulfilled)
        
        let listRequest = Request(proc: Task.Exercise(.list))
        let promise2 = controller.tx(request: listRequest)
        XCTAssertTrue(promise2.isFulfilled)
        let response = promise2.value as! Response
        let list: [ExerciseSessionViewModel] = response.body()
        
        XCTAssertTrue(list.count == 1)
    }
    
    func testEditSessionIsSuccess() {
        var session = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: "test", date: Date(), duration: Date())
        let dataStore = FakePersistentStoreController()
        let controller = ExerciseController()
        controller.dataStoreController = dataStore as PersistentStore
        
        let addRequest = Request(proc: Task.Exercise(.add), body: session)
        let promise = controller.tx(request: addRequest)
        XCTAssertTrue(promise.isFulfilled)
        session.name = "modified"
        let editRequest = Request(proc: Task.Exercise(.edit), body: session)
        let promise2 = controller.tx(request: editRequest)
        XCTAssertTrue(promise2.isFulfilled)
    }
    
    func testUnhandledProcessReturnError() {

        let dataStore = FakePersistentStoreController()
        let controller = ExerciseController()
        controller.dataStoreController = dataStore as PersistentStore
        
        let request = Request(proc: Task.Form(.Validate(.AddSession)))
        let promise = controller.tx(request: request)
        XCTAssertTrue(promise.isRejected)
    }
}
