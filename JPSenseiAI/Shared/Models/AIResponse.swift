import Foundation

/// AI response model matching the JSON schema
struct AIResponse: Codable {
    let original: String
    let vocabulary: [VocabularyItem]
    let grammar: [GrammarItem]
    let translation: String
}

struct VocabularyItem: Codable, Identifiable {
    var id: String { word + reading + meaning }
    let word: String
    let reading: String
    let meaning: String
    let example: ExampleItem?
}

struct GrammarItem: Codable, Identifiable {
    var id: String { pattern + explanation }
    let pattern: String
    let explanation: String
    let whyUsed: String
    let example: ExampleItem?
    let commonMistake: String?
    let similar: String?

    enum CodingKeys: String, CodingKey {
        case pattern, explanation, example
        case whyUsed = "why_used"
        case commonMistake = "common_mistake"
        case similar
    }
}

struct ExampleItem: Codable, Identifiable {
    var id: String { japanese + vietnamese }
    let japanese: String
    let vietnamese: String
}
