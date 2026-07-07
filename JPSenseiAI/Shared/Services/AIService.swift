import Foundation

/// Protocol for AI services - makes it easy to add new providers
protocol AIServiceProtocol {
    func analyze(text: String, systemPrompt: String, model: String, apiKey: String) async throws -> AIResponse
}

enum AIServiceError: LocalizedError {
    case noAPIKey
    case noText
    case networkError(Error)
    case timeout
    case noInternet
    case invalidResponse
    case apiError(String)
    case rateLimited
    case decodingError(String)

    var errorDescription: String? {
        switch self {
        case .noAPIKey:
            return "API Key chưa được cấu hình. Vui lòng mở JP Sensei AI để thêm API Key."
        case .noText:
            return "Không có văn bản nào được chọn."
        case .networkError(let error):
            return "Lỗi kết nối: \(error.localizedDescription)"
        case .timeout:
            return "AI đang mất quá lâu để phản hồi. Vui lòng thử lại."
        case .noInternet:
            return "Không có kết nối mạng. Vui lòng kiểm tra WiFi hoặc dữ liệu di động."
        case .invalidResponse:
            return "Phản hồi từ AI không hợp lệ."
        case .apiError(let message):
            return "Lỗi API: \(message)"
        case .rateLimited:
            return "Đã vượt quá giới hạn request. Vui lòng chờ một phút rồi thử lại."
        case .decodingError(let detail):
            return "Không thể đọc phản hồi AI: \(detail)"
        }
    }

    /// Icon name for each error type
    var iconName: String {
        switch self {
        case .noAPIKey: return "key.slash"
        case .noText: return "text.cursor"
        case .networkError, .noInternet: return "wifi.slash"
        case .timeout: return "clock.badge.exclamationmark"
        case .invalidResponse, .decodingError: return "doc.questionmark"
        case .apiError: return "server.rack"
        case .rateLimited: return "hourglass"
        }
    }

    /// Whether this error is retryable
    var isRetryable: Bool {
        switch self {
        case .noAPIKey, .noText:
            return false
        case .networkError, .timeout, .noInternet, .invalidResponse,
             .apiError, .rateLimited, .decodingError:
            return true
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
