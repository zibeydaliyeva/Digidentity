//
//  CatalogItem.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import Foundation

struct CatalogItem: Codable {
    let text: String
    let confidence: Double
    let image: String
    let id: String
    
    enum CodingKeys : String, CodingKey {
        case id = "_id"
        case image, text, confidence
    }

}
