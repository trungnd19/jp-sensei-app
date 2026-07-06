import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "character.book.closed.ja")
                .font(.system(size: 44))
                .foregroundStyle(.indigo)

            ProgressView()
                .controlSize(.large)

            Text("Analyzing Japanese...")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    LoadingView()
}
