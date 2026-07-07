import SwiftUI

struct APIKeySettingsView: View {
    @StateObject private var storage = SharedStorage.shared
    @State private var apiKey: String = ""
    @State private var saved = false
    @State private var validationError: String?

    private var currentProvider: AIProvider {
        storage.getProvider()
    }

    var body: some View {
        Form {
            // Show existing key status (masked, never reveal full key)
            if storage.hasAPIKey {
                Section("Current Key") {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                        Text(maskedKey)
                            .font(.system(.body, design: .monospaced))
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Section {
                SecureField("Paste new API Key", text: $apiKey)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

                if let error = validationError {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            } header: {
                Text(storage.hasAPIKey ? "Replace Key" : "Enter API Key")
            } footer: {
                Text(currentProvider == .gemini
                     ? "Get your free key at aistudio.google.com/apikey"
                     : "Get your key at platform.openai.com/api-keys")
            }

            Section {
                Button("Save") {
                    saveKey()
                }
                .disabled(apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

                if storage.hasAPIKey {
                    Button("Delete Key", role: .destructive) {
                        storage.deleteAPIKey()
                        apiKey = ""
                        saved = false
                        validationError = nil
                    }
                }
            }
        }
        .navigationTitle("API Key")
        .onDisappear {
            // Clear key from memory when leaving screen
            apiKey = ""
        }
        .overlay {
            if saved {
                SavedToast()
                    .task {
                        try? await Task.sleep(for: .seconds(1.5))
                        saved = false
                    }
            }
        }
    }

    /// Validate key format before saving
    private func saveKey() {
        let trimmed = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
        validationError = nil

        // Basic format validation
        switch currentProvider {
        case .gemini:
            if !trimmed.hasPrefix("AIza") {
                validationError = "Gemini key thường bắt đầu bằng 'AIza...'. Kiểm tra lại?"
                // Still allow saving — just a warning, not blocking
            }
        case .openai:
            if !trimmed.hasPrefix("sk-") {
                validationError = "OpenAI key thường bắt đầu bằng 'sk-...'. Kiểm tra lại?"
            }
        }

        storage.saveAPIKey(trimmed)
        apiKey = ""  // Clear from memory immediately after save
        saved = true
    }

    /// Show masked version: first 4 chars + dots + last 4 chars
    private var maskedKey: String {
        guard let key = storage.getAPIKey(), key.count > 8 else {
            return "••••••••"
        }
        let prefix = String(key.prefix(4))
        let suffix = String(key.suffix(4))
        return "\(prefix)••••••••\(suffix)"
    }
}

private struct SavedToast: View {
    var body: some View {
        VStack {
            Spacer()
            Text("✓ Saved")
                .font(.subheadline.weight(.medium))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial, in: Capsule())
                .padding(.bottom, 32)
        }
    }
}

#Preview {
    NavigationStack {
        APIKeySettingsView()
    }
}

#Preview {
    NavigationStack {
        APIKeySettingsView()
    }
}
