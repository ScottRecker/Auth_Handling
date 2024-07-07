//
//  NetworkRoutes.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/7/24.
//

import Foundation

enum NetworkRoutes {

    private static let baseUrl = "http://127.0.0.1:8000/"

    case register
    case accessToken
    case fetchSecureData

    var url: URL? {
        var path: String
        switch self {
        case .register:
            path = NetworkRoutes.baseUrl + "api/register/"
        case .accessToken:
            path = NetworkRoutes.baseUrl + "api/auth/token/"
        case .fetchSecureData:
            path = NetworkRoutes.baseUrl + "api/login_data/"
        }

        return URL(string: path)
    }

    var method: HttpMethod {
        switch self {
        case .register, .accessToken:
            return .post
        case .fetchSecureData:
            return .get
        }
    }
}
