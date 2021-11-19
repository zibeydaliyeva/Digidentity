//
//  DigidentityUITests.swift
//  DigidentityUITests
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import XCTest

class DigidentityUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
    
    func testDidSelectCellAtIndexPath() throws {
        let mainCollection = app.collectionViews.firstMatch
        XCTAssertTrue(mainCollection.exists, "The catalog collectionView exists")
        let cell = mainCollection.cells.element(boundBy: 0)
        cell.tap()
        app.navigationBars.firstMatch.tap()
    }
    
}
