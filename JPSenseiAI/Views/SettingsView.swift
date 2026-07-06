import SwiftUI

struct SettingsView: View {
    @StateObject private var storage = SharedStorage.shared

    var body: some View {
        NavigationStack {
            List {
                Section("AI Configuration") {
                    NavigationLink {
                        APIKeySettingsView()
                    } label: {
                        Label("API Key", systemImage: "key")
                    }

                    NavigationLink {
                        ModelSettingsView()
                    } label: {
                        Label("AI Model", systemImage: "cpu")
                    }

                    NavigationLink {
                        PromptSettingsView()
                    } label: {
                        Label("System Prompt", systemImage: "text.bubble")
                    }
                }

                Section("Information") {
                    NavigationLink {
                        AboutView()
                    } label: {
                        Label("About", systemImage: "info.circle")
                    }
                }

                Section {
                    StatusRow(storage: storage)
                }
            }
            .navigationTitle("JP Sensei AI")
        }
    }
}

private struct StatusRow: View {
    @ObservedObject var storage: SharedStorage

    var body: some View {
        HStack {
            Image(systemName: storage.hasAPIKey ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                .foregroundStyle(storage.hasAPIKey ? .green : .orange)
            Text(storage.hasAPIKey ? "Ready to use" : "API Key required")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SettingsView()
}
