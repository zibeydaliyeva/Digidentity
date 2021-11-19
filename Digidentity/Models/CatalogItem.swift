//
//  CatalogItem.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import Foundation

struct CatalogItem: Codable {
    var text: String
    var confidence: Double
    var image: String
    var id: String
    
    enum CodingKeys : String, CodingKey {
        case id = "_id"
        case image, text, confidence
    }

}
