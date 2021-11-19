//
//  CacherTest.swift
//  DigidentityTests
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import XCTest
@testable import Digidentity

class CacherTest: XCTestCase {
    
    private var sut: Cacher!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Cacher(fileName: "test")
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testPersistLoad() {
        let data = ["file1", "file2"]
        sut.persist(items: data)
        Thread.sleep(forTimeInterval: 2.0)
        let readData: [String]? = sut.load()
        XCTAssertEqual(readData!, data)
        XCTAssertTrue(readData!.count == 2)
    }

}
