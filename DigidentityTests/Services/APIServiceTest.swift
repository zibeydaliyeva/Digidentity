//
//  APIServiceTest.swift
//  DigidentityTests
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import XCTest
@testable import Digidentity

class APIServiceTest: XCTestCase {
    
    private var sut: APIServiceProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TestConstants.testWithMock ? MockAPIService() : APIService()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testGetCatalogsFromAPIServer() {
        let expectation = self.expectation(description: "fetch catalogs from api")
        let params = CatalogParams()
        sut.getCatalogs(params: params) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                XCTAssertNotNil(data)
                XCTAssertEqual(data.count > 0, true)
                XCTAssertLessThanOrEqual(data.count, 10)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: TestConstants.timeIntervale) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
}


class MockAPIService: APIServiceProtocol {
    
    func getCatalogs(params: CatalogParams, completion: @escaping ResponseResult<[CatalogItem]?>) {
        guard let data = dataFromTestBundleFile(fileName: "Items", withExtension: "json") else {
            completion(.failure(.parseError))
            return XCTFail("file is not exist")
        }
        do {
            var mockData = try JSONDecoder().decode([CatalogItem].self, from: data)
            if mockData.count > 10 {
                if params.maxId != nil {
                    mockData = Array(mockData[10..<12])
                } else if params.sinceId != nil {
                    mockData = Array(mockData[0..<1])
                } else {
                    mockData = Array(mockData[0..<10])
                }
            }
            completion(.success(Array(mockData)))
        } catch {
            completion(.failure(ErrorService.parseError))
        }
    }
    
    private func dataFromTestBundleFile(fileName: String, withExtension fileExtension: String) -> Data? {

        let testBundle = Bundle(for: APIServiceTest.self)
        let resourceUrl = testBundle.url(forResource: fileName, withExtension: fileExtension)!
        do {
            let data = try Data(contentsOf: resourceUrl)
            return data
        } catch {
            XCTFail("Error reading data from resource file \(fileName).\(fileExtension)")
            return nil
        }
    }
    
}
