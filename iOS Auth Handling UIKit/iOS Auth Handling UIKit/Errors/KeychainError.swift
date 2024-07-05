//
//  KeychainError.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/5/24.
//

import Foundation

enum KeychainError: Error {
    case saveFailed
    case retrieveFailed
    case deleteFailed
}
