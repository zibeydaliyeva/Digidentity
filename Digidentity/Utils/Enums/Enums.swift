//
//  Enums.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import Foundation

enum HTTPMethod {
    case get
    case post
    case put
    case delete

    var value: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }
}


enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case acceptLanguage = "Accept-Language"
}


enum ContentType: String {
    case json = "application/json"
    case multipart = "multipart/form-data"
}
