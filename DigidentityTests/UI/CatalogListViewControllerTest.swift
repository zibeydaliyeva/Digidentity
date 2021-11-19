//
//  CatalogListViewControllerTest.swift
//  DigidentityTests
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import XCTest
@testable import Digidentity

class CatalogListViewControllerTest: XCTestCase {
    
    private var sut: CatalogListViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CatalogListViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

}
