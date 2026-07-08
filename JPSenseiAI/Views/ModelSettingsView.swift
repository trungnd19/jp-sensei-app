import SwiftUI

struct ModelSettingsView: View {
    @StateObject private var storage = SharedStorage.shared
    @State private var selectedProvider: AIProvider = .gemini
    @State private var selectedModel: String = AIProvider.gemini.defaultModel
    @State private var fetchedModels: [String] = []
    @State private var isLoading = false
    @State private var fetchError: String?

    private var displayModels: [String] {
        if !fetchedModels.isEmpty {
            return fetchedModels
        }
        return selectedProvider.availableModels
    }

    var body: some View {
        Form {
            Section("AI Provider") {
                Picker("Provider", selection: $selectedProvider) {
                    ForEach(AIProvider.allCases) { provider in
                        Text(provider.displayName).tag(provider)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedProvider) { _, newValue in
                    selectedModel = newValue.defaultModel
                    save()
                    fetchModels()
                }
            }

            Section {
                if isLoading {
                    HStack {
                        ProgressView()
                            .controlSize(.small)
                        Text("Đang tải danh sách model...")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Picker("Model", selection: $selectedModel) {
                    ForEach(displayModels, id: \.self) { model in
                        Text(model).tag(model)
                    }
                }
                .onChange(of: selectedModel) { _, _ in
                    save()
                }

                if let error = fetchError {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.orange)
                }
            } header: {
                HStack {
                    Text("Model")
                    Spacer()
                    Button("Refresh") {
                        fetchModels()
                    }
                    .font(.caption)
                }
            }

            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Label("Free Tier", systemImage: "gift")
                        .font(.subheadline.weight(.medium))
                    Text(selectedProvider.freeTierDescription)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("AI Model")
        .onAppear {
            selectedProvider = storage.getProvider()
            selectedModel = storage.getModel()
            fetchModels()
        }
    }

    private func save() {
        storage.saveProvider(selectedProvider)
        storage.saveModel(selectedModel)
    }

    private func fetchModels() {
        guard selectedProvider == .gemini,
              let apiKey = storage.getAPIKey(), !apiKey.isEmpty else {
            fetchedModels = []
            return
        }

        isLoading = true
        fetchError = nil

        Task {
            let models = await ModelListService.fetchGeminiModels(apiKey: apiKey)
            await MainActor.run {
                isLoading = false
                if models.isEmpty {
                    fetchError = "Không tải được. Dùng danh sách mặc định."
                    fetchedModels = []
                } else {
                    fetchedModels = models
                    // Nếu model hiện tại không có trong list mới, chuyển về default
                    if !models.contains(selectedModel) {
                        selectedModel = models.first { $0.contains("2.5-flash") } ?? models.first ?? selectedProvider.defaultModel
                        save()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ModelSettingsView()
    }
}
