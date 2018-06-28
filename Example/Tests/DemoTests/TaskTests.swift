//
//  TaskTests.swift
//  DecouplerKit_Tests
//
//  Created by Nazario Mariano on 28/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

class TaskTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTaskReturnCorrectKey() {
        let keyForExercise = Task.Exercise(.add).key
        let keyForForm = Task.Form(.Validate(.AddSession)).key
        
        XCTAssertTrue(keyFormController == keyForForm && keyExerciseController == keyForExercise)
    }
    
    func testExerciseEquality() {
        let ex1 = Task.Exercise(.add)
        let ex2 = Task.Exercise(.add)
        
        XCTAssertTrue(ex1 == ex2)
    }
    
    func testExerciseInEquality() {
        let ex1 = Task.Exercise(.add)
        let ex2 = Task.Exercise(.delete)
        
        XCTAssertFalse(ex1 == ex2)
    }
    
    func testFormEquality() {
        let form1 = Task.Form(.Validate(.AddSession))
        let form2 = Task.Form(.Validate(.AddSession))
        
        XCTAssertTrue(form1 == form2)
    }

    func testFormInEquality() {
        let form1 = Task.Form(.Validate(.AddSession))
        let form2 = Task.Form(.Validate(.DeleteSession))
        
        XCTAssertFalse(form1 == form2)
    }

    func testFormExerciseEquality() {
        let form = Task.Form(.Validate(.AddSession))
        let exercise = Task.Exercise(.add)
        XCTAssertFalse(form == exercise)
    }
    
    func testExerciseFormEquality() {
        let form = Task.Form(.Validate(.AddSession))
        let exercise = Task.Exercise(.add)
        XCTAssertFalse(exercise == form)
    }

}
