//
//  RouterTest.swift
//  DigidentityTests
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import XCTest
@testable import Digidentity

class RouterTest: XCTestCase {
    
    func testGetCatalog() {
        let params = CatalogParams()
        let router = Router.getCatalogs(params: params)
        do {
            let request = try router.request()
            XCTAssertNotNil(request.allHTTPHeaderFields)
            let value = request.value(forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            XCTAssertEqual(value, ContentType.json.rawValue)
        } catch {
            XCTFail()
        }
    }
    
    func testGetCatalogWithSinceId() {
        let params = TestConstants.catalogParamsSinceId
        let router = Router.getCatalogs(params: params)
        do {
            let request = try router.request()
            XCTAssertNotNil(request.allHTTPHeaderFields)
            let value = request.value(forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            XCTAssertEqual(value, ContentType.json.rawValue)
        } catch {
            XCTFail()
        }
    }
    
    func testGetCatalogWithMaxId() {
        let params = TestConstants.catalogParamsMaxId
        let router = Router.getCatalogs(params: params)
        do {
            let request = try router.request()
            XCTAssertNotNil(request.allHTTPHeaderFields)
            let value = request.value(forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            XCTAssertEqual(value, ContentType.json.rawValue)
        } catch {
            XCTFail()
        }
    }

}
