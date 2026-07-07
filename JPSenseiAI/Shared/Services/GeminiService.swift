import Foundation

/// Google Gemini API Service
final class GeminiService: AIServiceProtocol {

    func analyze(text: String, systemPrompt: String, model: String, apiKey: String) async throws -> AIResponse {
        let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/\(model):generateContent?key=\(apiKey)")!

        let requestBody = GeminiRequest(
            systemInstruction: GeminiContent(parts: [GeminiPart(text: systemPrompt)]),
            contents: [
                GeminiContent(parts: [GeminiPart(text: PromptBuilder.buildUserMessage(text: text))])
            ],
            generationConfig: GeminiGenerationConfig(
                temperature: 0.3,
                responseMimeType: "application/json"
            )
        )

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(requestBody)
        request.timeoutInterval = 30

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch let error as URLError {
            throw Self.mapURLError(error)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw AIServiceError.invalidResponse
        }

        // Handle specific HTTP status codes
        switch httpResponse.statusCode {
        case 200:
            break
        case 429:
            throw AIServiceError.rateLimited
        case 401, 403:
            throw AIServiceError.apiError("API Key không hợp lệ hoặc đã hết hạn.")
        default:
            let errorBody = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw AIServiceError.apiError("HTTP \(httpResponse.statusCode): \(errorBody)")
        }

        let geminiResponse = try JSONDecoder().decode(GeminiResponse.self, from: data)

        guard let textContent = geminiResponse.candidates?.first?.content?.parts?.first?.text else {
            throw AIServiceError.invalidResponse
        }

        // Parse the JSON from AI response
        guard let jsonData = textContent.data(using: .utf8) else {
            throw AIServiceError.decodingError("Invalid UTF-8 in response")
        }

        do {
            let aiResponse = try JSONDecoder().decode(AIResponse.self, from: jsonData)
            return aiResponse
        } catch {
            throw AIServiceError.decodingError(error.localizedDescription)
        }
    }

    /// Map URLError to specific AIServiceError
    private static func mapURLError(_ error: URLError) -> AIServiceError {
        switch error.code {
        case .timedOut:
            return .timeout
        case .notConnectedToInternet, .networkConnectionLost, .dataNotAllowed:
            return .noInternet
        default:
            return .networkError(error)
        }
    }
}

// MARK: - Gemini API Models

private struct GeminiRequest: Encodable {
    let systemInstruction: GeminiContent
    let contents: [GeminiContent]
    let generationConfig: GeminiGenerationConfig

    enum CodingKeys: String, CodingKey {
        case systemInstruction = "system_instruction"
        case contents
        case generationConfig = "generation_config"
    }
}

private struct GeminiContent: Codable {
    let parts: [GeminiPart]
}

private struct GeminiPart: Codable {
    let text: String
}

private struct GeminiGenerationConfig: Encodable {
    let temperature: Double
    let responseMimeType: String

    enum CodingKeys: String, CodingKey {
        case temperature
        case responseMimeType = "response_mime_type"
    }
}

private struct GeminiResponse: Decodable {
    let candidates: [GeminiCandidate]?
}

private struct GeminiCandidate: Decodable {
    let content: GeminiResponseContent?
}

private struct GeminiResponseContent: Decodable {
    let parts: [GeminiResponsePart]?
}

private struct GeminiResponsePart: Decodable {
    let text: String?
}
