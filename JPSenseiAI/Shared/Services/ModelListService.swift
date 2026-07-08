import Foundation

/// Fetches available models from Gemini API
enum ModelListService {

    /// Fetch models that support generateContent
    static func fetchGeminiModels(apiKey: String) async -> [String] {
        guard let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models?key=\(apiKey)") else {
            return []
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 10

        guard let (data, response) = try? await URLSession.shared.data(for: request),
              let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            return []
        }

        guard let json = try? JSONDecoder().decode(ModelListResponse.self, from: data) else {
            return []
        }

        return json.models
            .filter { $0.supportedGenerationMethods.contains("generateContent") }
            .map { $0.name.replacingOccurrences(of: "models/", with: "") }
            .filter { $0.contains("gemini") && !$0.contains("embedding") }
            .sorted()
    }
}

// MARK: - Response Models

private struct ModelListResponse: Decodable {
    let models: [ModelInfo]
}

private struct ModelInfo: Decodable {
    let name: String
    let supportedGenerationMethods: [String]
}
