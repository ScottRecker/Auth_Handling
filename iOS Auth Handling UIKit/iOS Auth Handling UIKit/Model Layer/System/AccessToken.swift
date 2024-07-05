//
//  AccessToken.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/5/24.
//

import Foundation

struct AccessToken: Codable {
    var accessToken: String
    var refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access"
        case refreshToken = "refresh"
    }
}
