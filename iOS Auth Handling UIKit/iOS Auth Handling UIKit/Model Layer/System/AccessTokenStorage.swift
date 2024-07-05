//
//  AccessTokenStorage.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/5/24.
//

import Foundation
import Security

struct AccessTokenStorage {
    private let accountKey = "com.recker.auth_class_token"

    @discardableResult
    func save(_ token: AccessToken) -> Bool {
        delete()
        
        guard let data = try? JSONEncoder().encode(token) else { return false }
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrAccount: accountKey,
                                      kSecValueData: data]
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    func get() -> AccessToken? {
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrAccount: accountKey,
                                      kSecReturnData: true,
                                      kSecMatchLimit: kSecMatchLimitOne]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess,
              let data = item as? Data
        else { return nil }

        return try? JSONDecoder().decode(AccessToken.self, from: data)
    }

    @discardableResult
    func delete() -> Bool {
        let deleteQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrAccount: accountKey]

        let status = SecItemDelete(deleteQuery as CFDictionary)
        return status == errSecSuccess
    }
}
