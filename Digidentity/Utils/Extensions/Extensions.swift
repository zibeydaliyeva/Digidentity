//
//  Extensions.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import UIKit

extension Encodable {
    var dictionary: [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return (try? JSONSerialization.jsonObject(with: encoder.encode(self))) as? [String: Any] ?? [:]
    }
    

    func convertToString() -> String {
        var urlParameters = ""
        var count = 0
        for (key, value) in self.dictionary {
            let keyValueStr = "\(key)=\(value)"
            urlParameters += count == 0 ? "?" : "&"
            urlParameters += keyValueStr
            count += 1
        }
        return urlParameters
    }
    
}
