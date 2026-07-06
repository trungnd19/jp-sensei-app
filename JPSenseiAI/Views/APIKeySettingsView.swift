import SwiftUI

struct APIKeySettingsView: View {
    @StateObject private var storage = SharedStorage.shared
    @State private var apiKey: String = ""
    @State private var showKey = false
    @State private var saved = false

    var body: some View {
        Form {
            Section {
                HStack {
                    if showKey {
                        TextField("Paste API Key here", text: $apiKey)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    } else {
                        SecureField("Paste API Key here", text: $apiKey)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }

                    Button {
                        showKey.toggle()
                    } label: {
                        Image(systemName: showKey ? "eye.slash" : "eye")
                    }
                }
            } header: {
                Text("Google Gemini API Key")
            } footer: {
                Text("Get your free API key at aistudio.google.com/apikey")
            }

            Section {
                Button("Save") {
                    storage.saveAPIKey(apiKey)
                    saved = true
                }
                .disabled(apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

                if storage.hasAPIKey {
                    Button("Delete Key", role: .destructive) {
                        storage.deleteAPIKey()
                        apiKey = ""
                        saved = false
                    }
                }
            }
        }
        .navigationTitle("API Key")
        .onAppear {
            apiKey = storage.getAPIKey() ?? ""
        }
        .overlay {
            if saved {
                SavedToast()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            saved = false
                        }
                    }
            }
        }
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
