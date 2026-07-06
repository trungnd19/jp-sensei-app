import SwiftUI

/// ViewModel for the Share Extension result
@MainActor
final class ResultViewModel: ObservableObject {

    enum ViewState {
        case empty
        case loading
        case success(AIResponse)
        case error(String)
    }

    @Published var state: ViewState = .loading

    private let storage = SharedStorage.shared

    func analyze(text: String) {
        state = .loading

        Task {
            do {
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

                state = .success(response)
            } catch let error as AIServiceError {
                state = .error(error.errorDescription ?? "Unknown error")
            } catch {
                state = .error("Lỗi không xác định: \(error.localizedDescription)")
            }
        }
    }
}
