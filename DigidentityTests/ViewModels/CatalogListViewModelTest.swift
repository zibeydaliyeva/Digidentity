//
//  CatalogListViewModelTest.swift
//  DigidentityTests
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import XCTest
@testable import Digidentity

class CatalogListViewModelTest: XCTestCase {
    
    private var sut: CatalogListViewModel!
    private var apiService: APIServiceProtocol!
    
    override func setUpWithError() throws {
        apiService = TestConstants.testWithMock ? MockAPIService() : APIService()
        sut = CatalogListViewModel(apiService)
    }

    override func tearDownWithError() throws {
        sut = nil
        apiService = nil
        try super.tearDownWithError()
    }
    
    func testGetCatalog() {
        let expectation = self.expectation(description: "Get catalog cell view model")
        self.initialLoadTest(expectation)
        self.waitForExpectations(timeout: TestConstants.timeIntervale) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
        let cellViewModel = sut.getCatalog(at: 0)
        if sut.catalogCount > 0 {
            XCTAssertNotNil(cellViewModel)
        }
    }
    
    func testInitialLoad() {
        let expectation = self.expectation(description: "Initial load")
        self.initialLoadTest(expectation)
        self.waitForExpectations(timeout: TestConstants.timeIntervale) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
        XCTAssertLessThanOrEqual(sut.catalogCount, 10)
    }
    
    func testLoadNewerCatalog() {
        let expectation = self.expectation(description: "Load initial catalog")
        let expectationNewer = self.expectation(description: "Get newer catalog")
        
        self.initialLoadTest( expectation)
        let initialCount = sut.catalogCount
        
        self.loadNewerCatalogTest(expectationNewer)
        let newDataCount = sut.catalogCount - initialCount
        
        self.waitForExpectations(timeout: TestConstants.timeIntervale) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
        XCTAssertLessThanOrEqual(newDataCount, 10)
        XCTAssertGreaterThanOrEqual(sut.catalogCount, newDataCount)
    }
    
    func testLoadNewerCatalogFromJson() {
        let expectation = self.expectation(description: "Get initial catalogs")
        let expectationNewer = self.expectation(description: "Get newer catalog from JSON")
        
        self.initialLoadTest( expectation)
        let initialCount = sut.catalogCount
        
        self.loadNewerCatalogTest(expectationNewer)
        let newDataCount = sut.catalogCount - initialCount
        
        self.waitForExpectations(timeout: TestConstants.timeIntervale) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
        
        XCTAssertEqual(newDataCount, 10)
        XCTAssertEqual(sut.catalogCount, 20)
        XCTAssertGreaterThan(sut.catalogCount, newDataCount)
    }
    
    func testLoadOlderCatalog() {
        let expectation = self.expectation(description: "Get initial catalogs")
        let expectationOlder = self.expectation(description: "Load old catalog")
        
        initialLoadTest(expectation)
        let initialCount = sut.catalogCount
        
        loadOlderCatalogTest(expectationOlder)
        let newDataCount = sut.catalogCount - initialCount
        
        self.waitForExpectations(timeout: TestConstants.timeIntervale) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
        
        XCTAssertLessThanOrEqual(newDataCount, 10)
        XCTAssertGreaterThanOrEqual(sut.catalogCount, newDataCount)
    }
    
    func testLoadOlderCatalogFromJson() {
        let expectation = self.expectation(description: "Get initial catalogs")
        let expectationOlder = self.expectation(description: "Load old catalog from JSON")
        
        self.initialLoadTest( expectation)
        let initialCount = sut.catalogCount
        
        self.loadOlderCatalogTest(expectationOlder)
        let newDataCount = sut.catalogCount - initialCount
        
        self.waitForExpectations(timeout: TestConstants.timeIntervale) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
        
        XCTAssertEqual(newDataCount, 2)
        XCTAssertEqual(sut.catalogCount, 12)
        XCTAssertGreaterThan(sut.catalogCount, newDataCount)
    }
    
    
    private func loadOlderCatalogTest(_ expectation: XCTestExpectation) {
        sut.loadOlderCatalog { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }

    }
    
    private func loadNewerCatalogTest(_ expectation: XCTestExpectation) {
        sut.loadNewerCatalog { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
    }
    
    private func initialLoadTest(_ expectation: XCTestExpectation) {
        sut.initialLoad{ error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
    }
}
