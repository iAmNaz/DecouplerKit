//
//  DecouplerKit_ExampleUITests.swift
//  DecouplerKit_ExampleUITests
//
//  Created by Nazario Mariano on 28/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

var launched = false // we want to launch the app once for this test

class DecouplerKit_ExampleUITests: XCTestCase {

    let app = XCUIApplication()
    var currentMonth: String!
    
    override func setUp() {
        super.setUp()
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        currentMonth = dateFormatter.string(from: now)
        
        continueAfterFailure = false

        if launched {
            return
        } else {
            launched = true
            app.launch()
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func tapAddExerciseButton() {
        app.navigationBars["Exercise Tracker"].buttons["Add"].tap()
    }
    
    func setExercise(name: String) {
        let cell = app.tables.cells["name cell"]
        let tf = cell.textFields["nametf"]
        tf.tap()
        tf.typeText(name)
    }
    
    func setDuration(hour: String, minute: String) {
        openDurationPicker()
        app.pickerWheels["1 min"].adjust(toPickerWheelValue: minute)
        app.pickerWheels["0 hours"].adjust(toPickerWheelValue: hour)
    }
    
    func setDate(date: String, hour: String, minute: String, ampm: String) {
        openDatePicker()
        
        app.datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: date)
        app.datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: hour)
        app.datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: minute)
        app.datePickers.pickerWheels.element(boundBy: 3).adjust(toPickerWheelValue: ampm)
    }
    
    func openDurationPicker() {
        app.tables.staticTexts["Duration"].tap()
    }
    
    func openDatePicker() {
        app.tables.staticTexts["Date"].tap()
    }
    
    func tapComposerDoneButton() {
        app.navigationBars.buttons["Done"].tap()
    }
    
    func saveChanges() {
        app.navigationBars.buttons["Save"].tap()
    }
    
    func cancelAdd() {
        app.navigationBars.buttons["Cancel"].tap()
    }
    
    func exerciseCell(atIndex index: Int) -> XCUIElement {
        return app.tables.cells.element(boundBy: index)
    }
    
    func newExercise(name: String, duration: (hour: String, minute: String), date: (date: String, hour: String, minute: String, ampm: String) ) {
        tapAddExerciseButton()
        setExercise(name: name)
        setDuration(hour: duration.hour, minute: duration.minute)
        tapComposerDoneButton()
        setDate(date: date.date, hour: date.hour, minute: date.minute, ampm: date.ampm)
        tapComposerDoneButton()
    }
    
    // Important!:
    //Test names should be in alpha order if you want tests to be sequential
    func test1dd() {
        let date = currentMonth + " 30"
        newExercise(name: "squat", duration: (hour: "1", minute: "30"), date: (date: date,hour: "4", minute: "36", ampm: "PM"))
        saveChanges()
        XCTAssert(exerciseCell(atIndex: 0).staticTexts["squat"].exists)
    }
    
    func test2Edit() {
        exerciseCell(atIndex: 0).tap()
        setExercise(name: " edited")
        saveChanges()
        XCTAssert(app.tables.cells.element(boundBy: 0).staticTexts["squat edited"].exists)
    }
    
    func test3Delete() {
        exerciseCell(atIndex: 0).swipeLeft()
        exerciseCell(atIndex: 0).buttons["Delete"].tap()
        XCTAssert(!app.tables.cells.element(boundBy: 0).staticTexts["squat edited"].exists)
    }
    
    func test4AddAndCancelled() {
        let date = currentMonth + " 1"
        newExercise(name: "jumping jack", duration: (hour: "0", minute: "10"), date: (date: date, hour: "3", minute: "22", ampm: "AM"))
        cancelAdd()
        XCTAssert(!app.tables.cells.element(boundBy: 0).exists)
    }
    
    func test5AddAndSavedCorrectly() {
        let date = currentMonth + " 5"
        newExercise(name: "seated row", duration: (hour: "0", minute: "10"), date: (date: date, hour: "3", minute: "22", ampm: "AM"))
        saveChanges()
        XCTAssert(app.tables.cells.element(boundBy: 0).exists)
        let rows = app.tables.cells.containing(NSPredicate(format: "label CONTAINS '\(date)'"))
        XCTAssert(rows.count > 0)
    }
}
