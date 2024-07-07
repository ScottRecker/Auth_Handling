//
//  LoginViewModel.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/7/24.
//

import Foundation

extension LoginViewController {
    class ViewModel {
        var email: String?
        var password: String?

        private let networkHandler: NetworkHandler
        private let tokenStorage: AccessTokenStorage

        init(networkHandler: NetworkHandler, tokenStorage: AccessTokenStorage) {
            self.networkHandler = networkHandler
            self.tokenStorage = tokenStorage
        }
    }
}

extension LoginViewController.ViewModel {
    func submitLogin() async throws {
        guard let email, let password else {
            throw FormError.missingFields
        }

        guard !email.isEmpty, !password.isEmpty else {
            print("Email and password are required")
            throw FormError.missingFields
        }

        let route = NetworkRoutes.accessToken
        let method = route.method
        guard let url = route.url else {
            print("No Url found")
            throw ConfigurationError.nilObject
        }

        let jsonDict = [
            "username": email,
            "password": password
        ]

        let accessToken = try await networkHandler.request(
            url,
            jsonDictionary: jsonDict,
            responseType: AccessToken.self,
            httpMethod: method.rawValue
        )

        tokenStorage.save(accessToken)
    }
}
