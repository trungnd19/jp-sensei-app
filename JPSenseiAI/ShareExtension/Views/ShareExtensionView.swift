import SwiftUI

/// Main view for the Share Extension - manages state and navigation
struct ShareExtensionView: View {
    let inputText: String?
    let onDismiss: () -> Void

    @StateObject private var viewModel = ResultViewModel()

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .empty:
                    EmptyStateView()
                case .loading:
                    LoadingView()
                case .success(let response):
                    ResultView(response: response)
                case .error(let message):
                    ErrorView(message: message, onRetry: {
                        if let text = inputText {
                            viewModel.analyze(text: text)
                        }
                    })
                }
            }
            .navigationTitle("JP Sensei AI")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        onDismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
        .task {
            guard let text = inputText, !text.isEmpty else {
                viewModel.state = .empty
                return
            }
            viewModel.analyze(text: text)
        }
    }
}
