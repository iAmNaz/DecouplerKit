//
//  FormControllerTests.swift
//  DecouplerKit_Tests
//
//  Created by Nazario Mariano on 28/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import DecouplerKit_Example
import DecouplerKit
class FormControllerTests: XCTestCase {
    let dateFormatter = DateFormatter()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFormControllerValidateSuccess() {
        let form = FormController()
        let session = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: "Squat", date: Date(), duration: Date())
        let addRequest = Request(proc: Task.Form(.Validate(.AddSession)), body: session)
        
        let promise = form.tx(request: addRequest)
        XCTAssertTrue(promise.isFulfilled)
    }
    
    func testFormControllerInvalidFormValidatesFailure() {
        let form = FormController()
        let session = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: nil, date: Date(), duration: Date())
        let addRequest = Request(proc: Task.Form(.Validate(.AddSession)), body: session)
        
        let promise = form.tx(request: addRequest)
        XCTAssertFalse(promise.isPending)
        XCTAssertTrue(promise.isRejected)
    }

    func testFormControllerNilNameReturnsEmptyError() {
        let form = FormController()
        let session = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: nil, date: Date(), duration: Date())
        let addRequest = Request(proc: Task.Form(.Validate(.AddSession)), body: session)
        
        let promise = form.tx(request: addRequest)
        XCTAssertTrue(promise.isRejected)
        let error = promise.error as! AppError
        
        XCTAssert(errorMessage(error: error) == "Name is empty")
    }
    
    func testFormControllerWithUnfulfillableTaskShouldReturnError() {
        let form = FormController()
        let session = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: nil, date: Date(), duration: Date())
        let addRequest = Request(proc: Task.Form(.Validate(.DeleteSession)), body: session)
        
        let promise = form.tx(request: addRequest)
        XCTAssertTrue(promise.isRejected)
        let error = promise.error as! AppError
        
        let errorDescription = "FormController is unable to handle the task"
        let returnErrorMessage = errorMessage(error: error)
        XCTAssert(returnErrorMessage == errorDescription)
    }
    
    func testFormControllerWithEmptyDateShouldReturnError() {
        let form = FormController()
        let session = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: "Test", date: nil, duration: Date())
        let addRequest = Request(proc: Task.Form(.Validate(.AddSession)), body: session)
        
        let promise = form.tx(request: addRequest)
        XCTAssertTrue(promise.isRejected)
        let error = promise.error as! AppError
        
        let errorDescription = "Date is empty"
        let returnErrorMessage = errorMessage(error: error)
        XCTAssert(returnErrorMessage == errorDescription)
    }
    
    func testFormControllerWithEmptyDurationShouldReturnError() {
        let form = FormController()
        let session = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: "Test", date: Date(), duration: nil)
        let addRequest = Request(proc: Task.Form(.Validate(.AddSession)), body: session)
        
        let promise = form.tx(request: addRequest)
        XCTAssertTrue(promise.isRejected)
        let error = promise.error as! AppError
        
        let errorDescription = "Duration is empty"
        let returnErrorMessage = errorMessage(error: error)
        XCTAssert(returnErrorMessage == errorDescription)
    }
    
    func testFormControllerWithEmptyNameShouldReturnError() {
        let form = FormController()
        let session = ExerciseSessionViewModel(dateFormatter: dateFormatter, uniqueId: uniqueID(), name: "", date: Date(), duration: nil)
        let addRequest = Request(proc: Task.Form(.Validate(.AddSession)), body: session)
        
        let promise = form.tx(request: addRequest)
        XCTAssertTrue(promise.isRejected)
        let error = promise.error as! AppError
        
        let errorDescription = "Name is empty"
        let returnErrorMessage = errorMessage(error: error)
        XCTAssert(returnErrorMessage == errorDescription)
    }
    
    func errorMessage(error: AppError) -> String {
        switch error {
        case .form(.invalid(let fieldType, let fieldError)):
            switch fieldType {
            case .name:
                return fieldError.message!
            case .duration:
                return fieldError.message!
            case .date:
                return fieldError.message!
            }
        default:
            return "FormController is unable to handle the task"
        }
    }
}
