//
//  POC_transactionsUITests.swift
//  POC-transactionsUITests
//
//  Created by z on 19/05/2022.
//

import XCTest
@testable import POC_transactions

class POC_transactionsUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testServersPickerExistence() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
    
        
        let picker = app.pickerWheels["pickerView"]
        XCTAssert(picker.waitForExistence(timeout: 10.0))
        
        XCTAssertEqual(picker.cells.count, 3926)
    }
}
