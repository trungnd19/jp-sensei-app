import SwiftUI

/// Main view for the Share Extension - manages state and navigation
struct ShareExtensionView: View {
    let textProvider: () async -> String?
    let onDismiss: () -> Void

    @StateObject private var viewModel = ResultViewModel()
    @State private var inputText: String?

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
                case .error(let errorInfo):
                    ErrorView(errorInfo: errorInfo, onRetry: {
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
            let text = await textProvider()
            inputText = text
            guard let text, !text.isEmpty else {
                viewModel.state = .empty
                return
            }
            viewModel.analyze(text: text)
        }
    }
}
