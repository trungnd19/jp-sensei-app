import Foundation
import Security
 
/// Secure storage for sensitive data (API keys) using iOS Keychain
/// Shared between Host App and Share Extension via Keychain Sharing
final class KeychainHelper {
    static let shared = KeychainHelper()
    private init() {}
 
    private let accessGroup = Constants.keychainGroup
 
    @discardableResult
    func save(_ data: String, forKey key: String) -> Bool {
        guard let data = data.data(using: .utf8) else { return false }
 
        // Delete existing item first
        delete(forKey: key)
 
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrAccessGroup as String: accessGroup,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
 
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("[Keychain] Save failed with status: \(status)")
        }
        return status == errSecSuccess
    }
 
    func read(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrAccessGroup as String: accessGroup,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
 
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
 
        guard status == errSecSuccess,
              let data = result as? Data,
              let string = String(data: data, encoding: .utf8) else {
            return nil
        }
 
        return string
    }
 
    func delete(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrAccessGroup as String: accessGroup
        ]
 
        SecItemDelete(query as CFDictionary)
    }
}