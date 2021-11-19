//
//  CatalogCellViewModel.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 16.11.21.
//

import Foundation
import UIKit

struct CatalogCellViewModel {
    
    let text: String
    let confidence: Double
    let imagePath: String
    let id: String
    
    init(catalog: CatalogItem) {
        self.text = catalog.text
        self.confidence = catalog.confidence
        self.imagePath = catalog.image
        self.id = catalog.id
    }
    
}
