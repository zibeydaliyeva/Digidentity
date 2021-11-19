//
//  TestConstants.swift
//  DigidentityTests
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import Foundation
@testable import Digidentity

struct TestConstants {
    
    private init() {}

    static let timeIntervale: TimeInterval = 5
    static let testWithMock = true
    
    static let catalogParamsSinceId = CatalogParams(sinceId: "6196d03650e7f")
    static let catalogParamsMaxId = CatalogParams(maxId: "6196d03481be9")
    
    static let imageUrl = "https://via.placeholder.com/512x512?text=184. M2W03"
}
