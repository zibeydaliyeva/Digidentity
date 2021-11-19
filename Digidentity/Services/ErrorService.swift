//
//  ErrorService.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 16.11.21.
//

import Foundation

enum ErrorService: Error, LocalizedError, Equatable {

    case noData,
         fileNotFound(String),
         parseError,
         emptyResponseError,
         pageNotFound,
         serverError,
         incorrectUrl,
         connectionError,
         defaultError(String)

    var errorDescription: String? {
        switch self {
        case .noData:
            return "Could not fetch data from server or local storage!"
        case .fileNotFound(let fileName):
            return "Could not find file named as \(fileName)"
        case .parseError:
            return "Error occured while parsing data!"
        case .emptyResponseError:
            return "Response is empty!"
        case .pageNotFound:
            return "404: Page not found or incorrect url!"
        case .serverError:
            return "Error occured while connecting to server!"
        case .incorrectUrl:
            return "Request URL is incorrect!"
        case .connectionError:
            return "The Internet connection appears to be offline."
        case .defaultError(let errorMessage):
            return errorMessage
        }
    }

}
