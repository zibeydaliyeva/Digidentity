//
//  APIService.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 16.11.21.
//

import Foundation

protocol APIServiceProtocol {
    typealias ResponseResult<T: Decodable> = (Result<T, ErrorService>) -> Void
    
    func getCatalogs(params: CatalogParams, completion: @escaping ResponseResult<[CatalogItem]?>)
}

class APIService: APIServiceProtocol {

    private var urlSession: URLSession
    
    // MARK: - Initializer
    init(with urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func getCatalogs(params: CatalogParams, completion: @escaping ResponseResult<[CatalogItem]?>) {
        return self.request(router: Router.getCatalogs(params: params), completion: completion)
    }
    
}



extension APIService {

    private func request<T: Decodable>(router: Router, completion: @escaping (Result<T, ErrorService>) -> Void) {
        do {
            let task = try urlSession.dataTask(with: router.request()) { (data, response, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        completion(.failure(.connectionError))
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(.failure(.emptyResponseError))
                        return
                    }
                    guard (200...299).contains(httpResponse.statusCode) else {
                        let error: ErrorService
                        switch httpResponse.statusCode {
                        case 404:
                            error = .pageNotFound
                        case 500:
                            error = .serverError
                        default: error = .defaultError("Wrong response from server")
                        }
                        completion(.failure(error))
                        return
                    }

                    guard let data = data else {
                        completion(.failure(.noData))
                        return
                    }

                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(.parseError))
                    }
                }

            }
            task.resume()
        } catch let error {
            completion(.failure(.defaultError(error.localizedDescription)))
        }

    }

}
