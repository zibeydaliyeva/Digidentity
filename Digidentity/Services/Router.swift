//
//  Router.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import Foundation

enum Router {
    
    private static let baseUrl = "https://marlove.net/e/mock/v1/"
    private static let key = "271f936d14e196ae2219eef9827578b1"
    
    case getCatalogs(params: Encodable)
    
    private var path: String {
        switch self {
        case .getCatalogs:
            return "items"
        }
    }
    
    private var parameters: String? {
        switch self {
        case .getCatalogs(let params):
            return params.convertToString()
        }
    }

    private var method: HTTPMethod {
        switch self {
        case .getCatalogs:
            return .get
        }
    }

    
    func request() throws -> URLRequest {
        var urlString = Router.baseUrl + path
        
        if let parameters = parameters { urlString += parameters }
        
        guard let url = URL(string: urlString) else { throw ErrorService.incorrectUrl }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5)
        
        request.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        request.allHTTPHeaderFields = [HTTPHeaderField.authentication.rawValue: Router.key]
        
        request.httpMethod = method.value
        return request
    }
    
}

