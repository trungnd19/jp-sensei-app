import Foundation

/// OpenAI Chat Completions API Service
final class OpenAIService: AIServiceProtocol {

    func analyze(text: String, systemPrompt: String, model: String, apiKey: String) async throws -> AIResponse {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!

        let requestBody = OpenAIRequest(
            model: model,
            messages: [
                OpenAIMessage(role: "system", content: systemPrompt),
                OpenAIMessage(role: "user", content: PromptBuilder.buildUserMessage(text: text))
            ],
            temperature: 0.3,
            responseFormat: OpenAIResponseFormat(type: "json_object")
        )

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONEncoder().encode(requestBody)
        request.timeoutInterval = 30

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw AIServiceError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            let errorBody = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw AIServiceError.apiError("HTTP \(httpResponse.statusCode): \(errorBody)")
        }

        let openAIResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)

        guard let content = openAIResponse.choices.first?.message.content else {
            throw AIServiceError.invalidResponse
        }

        guard let jsonData = content.data(using: .utf8) else {
            throw AIServiceError.decodingError("Invalid UTF-8 in response")
        }

        do {
            let aiResponse = try JSONDecoder().decode(AIResponse.self, from: jsonData)
            return aiResponse
        } catch {
            throw AIServiceError.decodingError(error.localizedDescription)
        }
    }
}

// MARK: - OpenAI API Models

private struct OpenAIRequest: Encodable {
    let model: String
    let messages: [OpenAIMessage]
    let temperature: Double
    let responseFormat: OpenAIResponseFormat

    enum CodingKeys: String, CodingKey {
        case model, messages, temperature
        case responseFormat = "response_format"
    }
}

private struct OpenAIMessage: Encodable {
    let role: String
    let content: String
}

private struct OpenAIResponseFormat: Encodable {
    let type: String
}

private struct OpenAIResponse: Decodable {
    let choices: [OpenAIChoice]
}

private struct OpenAIChoice: Decodable {
    let message: OpenAIChoiceMessage
}

private struct OpenAIChoiceMessage: Decodable {
    let content: String?
}
