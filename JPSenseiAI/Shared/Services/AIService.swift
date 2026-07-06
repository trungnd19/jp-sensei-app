import Foundation

/// Protocol for AI services - makes it easy to add new providers
protocol AIServiceProtocol {
    func analyze(text: String, systemPrompt: String, model: String, apiKey: String) async throws -> AIResponse
}

enum AIServiceError: LocalizedError {
    case noAPIKey
    case noText
    case networkError(Error)
    case invalidResponse
    case apiError(String)
    case decodingError(String)

    var errorDescription: String? {
        switch self {
        case .noAPIKey:
            return "API Key chưa được cấu hình. Vui lòng mở JP Sensei AI để thêm API Key."
        case .noText:
            return "Không có văn bản nào được chọn."
        case .networkError(let error):
            return "Lỗi kết nối: \(error.localizedDescription)"
        case .invalidResponse:
            return "Phản hồi từ AI không hợp lệ."
        case .apiError(let message):
            return "Lỗi API: \(message)"
        case .decodingError(let detail):
            return "Không thể đọc phản hồi AI: \(detail)"
        }
    }
}

/// Factory to create the appropriate AI service
enum AIServiceFactory {
    static func create(for provider: AIProvider) -> AIServiceProtocol {
        switch provider {
        case .gemini:
            return GeminiService()
        case .openai:
            return OpenAIService()
        }
    }
}
