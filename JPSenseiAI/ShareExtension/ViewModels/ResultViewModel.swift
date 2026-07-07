import SwiftUI

/// ViewModel for the Share Extension result
@MainActor
final class ResultViewModel: ObservableObject {

    enum ViewState {
        case empty
        case loading
        case success(AIResponse)
        case error(ErrorInfo)
    }

    struct ErrorInfo {
        let message: String
        let icon: String
        let isRetryable: Bool
    }

    @Published var state: ViewState = .loading

    private let storage = SharedStorage.shared
    private var retryCount = 0
    private var currentTask: Task<Void, Never>?
    private static let maxRetries = 3

    deinit {
        currentTask?.cancel()
    }

    func analyze(text: String) {
        currentTask?.cancel()
        state = .loading

        currentTask = Task {
            do {
                guard !Task.isCancelled else { return }

                guard let apiKey = storage.getAPIKey(), !apiKey.isEmpty else {
                    throw AIServiceError.noAPIKey
                }

                let provider = storage.getProvider()
                let model = storage.getModel()
                let prompt = PromptBuilder.buildSystemPrompt(customPrompt: storage.getPrompt())

                let service = AIServiceFactory.create(for: provider)
                let response = try await service.analyze(
                    text: text,
                    systemPrompt: prompt,
                    model: model,
                    apiKey: apiKey
                )

                guard !Task.isCancelled else { return }

                retryCount = 0
                state = .success(response)
            } catch is CancellationError {
                // Task was cancelled (user retried), ignore
                return
            } catch let error as AIServiceError {
                retryCount += 1
                state = .error(ErrorInfo(
                    message: error.errorDescription ?? "Unknown error",
                    icon: error.iconName,
                    isRetryable: error.isRetryable && retryCount < Self.maxRetries
                ))
            } catch {
                retryCount += 1
                state = .error(ErrorInfo(
                    message: "Lỗi không xác định: \(error.localizedDescription)",
                    icon: "questionmark.circle",
                    isRetryable: retryCount < Self.maxRetries
                ))
            }
        }
    }
}
