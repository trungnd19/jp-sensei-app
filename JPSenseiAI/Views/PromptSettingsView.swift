import SwiftUI

struct PromptSettingsView: View {
    @StateObject private var storage = SharedStorage.shared
    @State private var prompt: String = ""
    @State private var saved = false

    var body: some View {
        VStack(spacing: 0) {
            TextEditor(text: $prompt)
                .font(.system(.body, design: .monospaced))
                .padding(4)

            Divider()

            HStack {
                Button("Reset to Default") {
                    prompt = PromptBuilder.defaultPrompt
                    storage.savePrompt(prompt)
                    saved = true
                }
                .font(.subheadline)

                Spacer()

                Button("Save") {
                    storage.savePrompt(prompt)
                    saved = true
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle("System Prompt")
        .onAppear {
            prompt = storage.getPrompt()
        }
        .overlay {
            if saved {
                VStack {
                    Spacer()
                    Text("✓ Saved")
                        .font(.subheadline.weight(.medium))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial, in: Capsule())
                        .padding(.bottom, 32)
                }
                .task {
                    try? await Task.sleep(for: .seconds(1.5))
                    saved = false
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PromptSettingsView()
    }
}
