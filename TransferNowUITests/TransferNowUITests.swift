//
//  TransferNowUITests.swift
//  TransferNowUITests
//
//  Created by Kanishk KUMAR on 10/30/18.
//  Copyright © 2018 Kanishk KUMAR. All rights reserved.
//

import XCTest

class TransferNowUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWithValidInputForSuccess() {

        let app = XCUIApplication()

        let fromAccountTextField = app.textFields["From Account"]
        fromAccountTextField.tap()
        fromAccountTextField.typeText("123456")

        let toAccountTextField = app.textFields["To Account"]
        toAccountTextField.tap()
        toAccountTextField.typeText("987654")

        let amountTextField = app.textFields["Amount (HKD)"]
        amountTextField.tap()
        amountTextField.typeText("100")

        app.buttons["Send"].tap()

        let successStaticText = app.staticTexts["Success"]
        XCTAssertEqual(successStaticText.exists, true)
    }

    func testWithInvalidInput() {

        let app = XCUIApplication()

        let fromAccountTextField = app.textFields["From Account"]
        fromAccountTextField.tap()
        fromAccountTextField.typeText("")

        let toAccountTextField = app.textFields["To Account"]
        toAccountTextField.tap()
        toAccountTextField.typeText("987654")

        let amountTextField = app.textFields["Amount (HKD)"]
        amountTextField.tap()
        amountTextField.typeText("100")

        app.buttons["Send"].tap()
        app.alerts["Error"].buttons["OK"].tap()
    }
}
