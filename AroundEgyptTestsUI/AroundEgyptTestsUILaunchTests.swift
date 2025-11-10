//
//  AroundEgyptTestsUILaunchTests.swift
//  AroundEgyptTestsUI
//
//  Created by MacbookPro on 10/11/2025.
//

import XCTest

final class AroundEgyptTestsUILaunchTests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func test_searchBarExists() {
        let searchField = app.textFields["Search"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 3), "Search field should exist")
    }

    func test_performSearch_showsResults() {
        let searchField = app.textFields["Search"]
        XCTAssertTrue(searchField.exists)
        
        searchField.tap()
        searchField.typeText("Abu\n")
        
        let resultCell = app.staticTexts.matching(identifier: "image").firstMatch
        XCTAssertTrue(resultCell.waitForExistence(timeout: 5), "Search result should appear")
    }

    func test_openDetailView() {
        let searchField = app.textFields["Search"]
        searchField.tap()
        searchField.typeText("Abu\n")

        let resultCell = app.staticTexts.matching(identifier: "image").firstMatch
        XCTAssertTrue(resultCell.waitForExistence(timeout: 5))
        resultCell.tap()
        
        let shareButton = app.buttons.matching(identifier: "shareButton").firstMatch
        XCTAssertTrue(shareButton.waitForExistence(timeout: 5), "Details should opened")
    }

    func test_shareButtonOpensShareSheet() {
        let searchField = app.textFields["Search"]
        searchField.tap()
        searchField.typeText("Abu\n")

        let resultCell = app.staticTexts.matching(identifier: "image").firstMatch
        resultCell.tap()

        sleep(1)

        let shareButton = app.buttons.matching(identifier: "shareButton").firstMatch
        XCTAssertTrue(shareButton.waitForExistence(timeout: 3))
        shareButton.tap()

        let shareSheet = app.otherElements["ShareSheet"]
        XCTAssertTrue(shareSheet.waitForExistence(timeout: 3), "Share sheet appear")
    }
    
}
