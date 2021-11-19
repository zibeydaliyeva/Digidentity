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

    func testGetCatalogs() {
        let expectation = self.expectation(description: "Get catalogs")
        let params = CatalogParams()
        getCatalogsTest(params: params, expectation)
        XCTAssertEqual(sut.catalogCount > 0, true)
        XCTAssertLessThanOrEqual(sut.newDataCount, 10)
    }
    
    func testGetCatalogsWithParams() {
        let expectation = self.expectation(description: "Get get catalogs with params")
        let params = TestConstants.catalogParamsMaxId
        getCatalogsTest(params: params, expectation)
        XCTAssertLessThanOrEqual(sut.newDataCount, 10)
    }
    
    func testGetCatalogsWithSinceIdFromJson() {
        let expectation = self.expectation(description: "Get get catalogs with params from json")
        let params = TestConstants.catalogParamsSinceId
        getCatalogsTest(params: params, expectation)
        XCTAssertEqual(sut.catalogCount, 1)
        XCTAssertEqual(sut.newDataCount, 1)
    }
    
    func testGetCatalogsWithMaxIdFromJson() {
        let expectation = self.expectation(description: "Get catalogs")
        getCatalogsTest(params: CatalogParams(), expectation)
        XCTAssertEqual(sut.catalogCount, 10)
        
        let expectationParams = self.expectation(description: "Get get catalogs with params from json")
        let params = TestConstants.catalogParamsMaxId
        getCatalogsTest(params: params, expectationParams)
        XCTAssertEqual(sut.newDataCount, 2)
        XCTAssertEqual(sut.catalogCount, 12)
    }
    
    func testGetCatalog() {
        let expectation = self.expectation(description: "Get catalog cell view model")
        self.getCatalogsTest(params: CatalogParams(), expectation)
        let cellViewModel = sut.getCatalog(at: 0)
        XCTAssertNotNil(cellViewModel)
    }
    
    func testInitialLoad() {
        let expectation = self.expectation(description: "Initial load")
        sut.initialLoad { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        XCTAssertEqual(sut.catalogCount > 0, true)
        
        self.waitForExpectations(timeout: TestConstants.timeIntervale) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testLoadNewerCatalog() {
        let expectation = self.expectation(description: "Load new catalog")
        
        sut.loadNewerCatalog { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: TestConstants.timeIntervale) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testLoadOlderCatalog() {
        let expectation = self.expectation(description: "Load new catalog")
        
        sut.loadOlderCatalog { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: TestConstants.timeIntervale) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    
    private func getCatalogsTest(params: CatalogParams, _ expectation: XCTestExpectation) {
        sut.getCatalogs(params: params) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: TestConstants.timeIntervale) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
}
