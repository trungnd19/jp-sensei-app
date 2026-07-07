import Foundation
import SwiftUI

/// Shared storage between Host App and Share Extension using App Group UserDefaults + Keychain
final class SharedStorage: ObservableObject {
    static let shared = SharedStorage()

    private let defaults: UserDefaults
    private let keychain = KeychainHelper.shared

    @Published var hasAPIKey: Bool = false

    private init() {
        defaults = UserDefaults(suiteName: Constants.appGroupID) ?? .standard
        hasAPIKey = keychain.read(forKey: Constants.StorageKeys.apiKey) != nil
    }

    // MARK: - API Key (Keychain)

    @discardableResult
    func saveAPIKey(_ key: String) -> Bool {
        let trimmed = key.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return false }
        let success = keychain.save(trimmed, forKey: Constants.StorageKeys.apiKey)
        DispatchQueue.main.async {
            self.hasAPIKey = success
        }
        return success
    }

    func getAPIKey() -> String? {
        keychain.read(forKey: Constants.StorageKeys.apiKey)
    }

    func deleteAPIKey() {
        keychain.delete(forKey: Constants.StorageKeys.apiKey)
        DispatchQueue.main.async {
            self.hasAPIKey = false
        }
    }

    // MARK: - Provider (UserDefaults)

    func saveProvider(_ provider: AIProvider) {
        defaults.set(provider.rawValue, forKey: Constants.StorageKeys.provider)
    }

    func getProvider() -> AIProvider {
        guard let raw = defaults.string(forKey: Constants.StorageKeys.provider),
              let provider = AIProvider(rawValue: raw) else {
            return .gemini
        }
        return provider
    }

    // MARK: - Model (UserDefaults)

    func saveModel(_ model: String) {
        defaults.set(model, forKey: Constants.StorageKeys.model)
    }

    func getModel() -> String {
        defaults.string(forKey: Constants.StorageKeys.model) ?? AIProvider.gemini.defaultModel
    }

    // MARK: - Prompt (UserDefaults)

    func savePrompt(_ prompt: String) {
        defaults.set(prompt, forKey: Constants.StorageKeys.prompt)
    }

    func getPrompt() -> String {
        defaults.string(forKey: Constants.StorageKeys.prompt) ?? PromptBuilder.defaultPrompt
    }
}
