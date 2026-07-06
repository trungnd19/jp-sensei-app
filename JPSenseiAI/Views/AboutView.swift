import SwiftUI

struct AboutView: View {
    var body: some View {
        List {
            Section {
                VStack(spacing: 12) {
                    Image(systemName: "character.book.closed.ja")
                        .font(.system(size: 48))
                        .foregroundStyle(.indigo)
                    Text("JP Sensei AI")
                        .font(.title2.weight(.semibold))
                    Text("AI-powered Japanese learning assistant")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
            }

            Section("How to Use") {
                StepRow(number: 1, text: "Read Japanese in Safari")
                StepRow(number: 2, text: "Highlight a sentence")
                StepRow(number: 3, text: "Tap Share → JP Sensei AI")
                StepRow(number: 4, text: "Read the AI explanation")
                StepRow(number: 5, text: "Tap Done → continue reading")
            }

            Section("About") {
                LabeledContent("Version", value: "1.0.0")
                LabeledContent("AI Provider", value: "Google Gemini")
                LabeledContent("Privacy", value: "No data collected")
            }
        }
        .navigationTitle("About")
    }
}

private struct StepRow: View {
    let number: Int
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Text("\(number)")
                .font(.caption.weight(.bold))
                .frame(width: 24, height: 24)
                .background(Color.indigo.opacity(0.1))
                .clipShape(Circle())
            Text(text)
        }
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
