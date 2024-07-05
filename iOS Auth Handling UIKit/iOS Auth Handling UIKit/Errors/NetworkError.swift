//
//  NetworkError.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/5/24.
//

import Foundation

enum NetworkError: Error {
    case userError(String)
    case dataError(String)
    case encodingError
    case decodingError
    case failedStatusCode(String)
    case failedStatusCodeResponseData(Int, Data)
    case noResponse

    var statusCodeResponseData: (Int, Data)? {
        if case let .failedStatusCodeResponseData(statusCode, responseData) = self {
            return (statusCode, responseData)
        }
        return nil
    }
}
