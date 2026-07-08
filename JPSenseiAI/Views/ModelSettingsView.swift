import SwiftUI

struct ModelSettingsView: View {
    @StateObject private var storage = SharedStorage.shared
    @State private var selectedProvider: AIProvider = .gemini
    @State private var selectedModel: String = AIProvider.gemini.defaultModel

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
                }
            }

            Section("Model") {
                Picker("Model", selection: $selectedModel) {
                    ForEach(selectedProvider.availableModels, id: \.self) { model in
                        Text(model).tag(model)
                    }
                }
                .onChange(of: selectedModel) { _, _ in
                    save()
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
        }
    }

    private func save() {
        storage.saveProvider(selectedProvider)
        storage.saveModel(selectedModel)
    }
}

#Preview {
    NavigationStack {
        ModelSettingsView()
    }
}
