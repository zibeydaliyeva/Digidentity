//
//  CatalogDetailViewControllerTest.swift
//  DigidentityTests
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import XCTest
@testable import Digidentity

class CatalogDetailViewControllerTest: XCTestCase {

    
    private var sut: CatalogDetailViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CatalogDetailViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

}
