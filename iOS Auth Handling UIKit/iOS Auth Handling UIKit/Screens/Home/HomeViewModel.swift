//
//  HomeViewModel.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/7/24.
//

import Combine
import Foundation

extension HomeViewController {
    class ViewModel {
        static let defaultInfoText = "Tap Fetch Button to fetch secured data"

        @Published var infoText = HomeViewController.ViewModel.defaultInfoText

        private let networkHandler: NetworkHandler
        private let tokenStorage: AccessTokenStorage

        init(networkHandler: NetworkHandler, tokenStorage: AccessTokenStorage) {
            self.networkHandler = networkHandler
            self.tokenStorage = tokenStorage
        }
    }
}

extension HomeViewController.ViewModel {
    func resetInfoText() {
        infoText = HomeViewController.ViewModel.defaultInfoText
    }

    func fetchSecureData() async throws {
        let route = NetworkRoutes.fetchSecureData
        let method = route.method
        guard let url = route.url,
        let accessToken = tokenStorage.get()?.accessToken else {
            print("No Url or access token found")
            throw ConfigurationError.nilObject
        }

        let responseData = try await networkHandler.request(
            url,
            responseType: SecureFetchData.self,
            httpMethod: method.rawValue,
            accessToken: accessToken
        )

        infoText = responseData.message
    }
}
