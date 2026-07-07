import SwiftUI

struct ErrorView: View {
    let errorInfo: ResultViewModel.ErrorInfo
    let onRetry: () -> Void
    let onOpenSettings: (() -> Void)?

    init(errorInfo: ResultViewModel.ErrorInfo, onRetry: @escaping () -> Void, onOpenSettings: (() -> Void)? = nil) {
        self.errorInfo = errorInfo
        self.onRetry = onRetry
        self.onOpenSettings = onOpenSettings
    }

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: errorInfo.icon)
                .font(.system(size: 44))
                .foregroundStyle(.orange)

            Text("Unable to analyze")
                .font(.headline)

            Text(errorInfo.message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            VStack(spacing: 12) {
                if errorInfo.isRetryable {
                    Button("Retry") {
                        onRetry()
                    }
                    .buttonStyle(.borderedProminent)
                }

                if !errorInfo.isRetryable && errorInfo.icon == "key.slash" {
                    Text("Mở app JP Sensei AI để thêm API Key")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview("Network Error") {
    ErrorView(
        errorInfo: ResultViewModel.ErrorInfo(
            message: "Không có kết nối mạng.",
            icon: "wifi.slash",
            isRetryable: true
        ),
        onRetry: {}
    )
}

#Preview("No API Key") {
    ErrorView(
        errorInfo: ResultViewModel.ErrorInfo(
            message: "API Key chưa được cấu hình.",
            icon: "key.slash",
            isRetryable: false
        ),
        onRetry: {}
    )
}
