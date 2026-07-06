import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "text.cursor")
                .font(.system(size: 44))
                .foregroundStyle(.secondary)

            Text("No selected text")
                .font(.headline)

            Text("Please highlight Japanese text in Safari before opening JP Sensei AI.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    EmptyStateView()
}
