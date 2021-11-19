//
//  ExtensionsTest.swift
//  DigidentityTests
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import XCTest
@testable import Digidentity

class ExtensionsTest: XCTestCase {
    
    private var sut: UIViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CatalogListViewController()
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testCutomErrorUIAlertControllerWithoutCompletion() {
        sut.errorAlert(with: "Error alert")
    }
    
    func testCutomTrackError() {
        sut.trackError(with: "Track error")
    }
    
    func testErrorService() {
        XCTAssertNotNil(ErrorService.noData.localizedDescription)
        XCTAssertNotNil(ErrorService.fileNotFound("File not found").localizedDescription)
        XCTAssertNotNil(ErrorService.parseError.localizedDescription)
        XCTAssertNotNil(ErrorService.emptyResponseError.localizedDescription)
        XCTAssertNotNil(ErrorService.pageNotFound.localizedDescription)
        XCTAssertNotNil(ErrorService.serverError.localizedDescription)
        XCTAssertNotNil(ErrorService.incorrectUrl.localizedDescription)
        XCTAssertNotNil(ErrorService.connectionError.localizedDescription)
        XCTAssertNotNil(ErrorService.defaultError("Default error").localizedDescription)
    }
    
}
