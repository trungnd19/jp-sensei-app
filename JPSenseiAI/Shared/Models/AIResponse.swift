import Foundation

/// AI response model matching the JSON schema
struct AIResponse: Codable {
    let original: String
    let furigana: String
    let vocabulary: [VocabularyItem]
    let grammar: [GrammarItem]
    let translation: String
    let nuance: String
    let examples: [ExampleItem]
}

struct VocabularyItem: Codable, Identifiable {
    var id: String { word + reading }
    let word: String
    let reading: String
    let meaning: String
    let nuance: String?
    let jlpt: String?
}

struct GrammarItem: Codable, Identifiable {
    var id: String { pattern }
    let pattern: String
    let explanation: String
    let whyUsed: String
    let commonMistake: String?
    let similar: String?

    enum CodingKeys: String, CodingKey {
        case pattern, explanation
        case whyUsed = "why_used"
        case commonMistake = "common_mistake"
        case similar
    }
}

struct ExampleItem: Codable, Identifiable {
    var id: String { japanese }
    let japanese: String
    let vietnamese: String
}
