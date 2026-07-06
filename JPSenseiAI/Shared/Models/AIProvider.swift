import Foundation

enum AIProvider: String, Codable, CaseIterable, Identifiable {
    case gemini
    case openai

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .gemini: "Google Gemini"
        case .openai: "OpenAI"
        }
    }

    var defaultModel: String {
        switch self {
        case .gemini: "gemini-2.0-flash"
        case .openai: "gpt-4o-mini"
        }
    }

    var availableModels: [String] {
        switch self {
        case .gemini: ["gemini-2.0-flash", "gemini-2.0-flash-lite", "gemini-1.5-flash"]
        case .openai: ["gpt-4o-mini", "gpt-4o", "gpt-4.1-mini"]
        }
    }

    var freeTierDescription: String {
        switch self {
        case .gemini: "15 requests/phút, 1,500 requests/ngày — Miễn phí"
        case .openai: "Không có free tier. Cần trả phí theo usage."
        }
    }
}
