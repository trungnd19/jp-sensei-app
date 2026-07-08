import Foundation
 
/// Storage for API keys using App Group UserDefaults
/// Shared between Host App and Share Extension via App Group container
final class KeychainHelper {
    static let shared = KeychainHelper()
    private let defaults: UserDefaults
 
    private init() {
        defaults = UserDefaults(suiteName: Constants.appGroupID) ?? .standard
    }
 
    @discardableResult
    func save(_ data: String, forKey key: String) -> Bool {
        let trimmed = data.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return false }
        defaults.set(trimmed, forKey: key)
        return defaults.synchronize()
    }
 
    func read(forKey key: String) -> String? {
        defaults.string(forKey: key)
    }
 
    func delete(forKey key: String) {
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
}
 