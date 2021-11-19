//
//  CryptorHelperTest.swift
//  DigidentityTests
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import XCTest
@testable import Digidentity

class CryptorHelperTest: XCTestCase {
    
    private var sut: CryptorHelper!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CryptorHelper(password: "testPassword")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testEncrypt() {
        let txt = "String"
        let data = txt.data(using: .utf8)
        do {
            let encryptData = try sut.encrypt(data: data!)
            XCTAssertNotNil(encryptData)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testDecrypt() {
        let firstStr = "String"
        let data = firstStr.data(using: .utf8)
        do {
            let encryptData = try sut.encrypt(data: data!)
            let decryptData = try sut.decrypt(data: encryptData)
            let secondStr = String(decoding: decryptData, as: UTF8.self)
            XCTAssertNotNil(decryptData)
            XCTAssertEqual(firstStr, secondStr)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

}
