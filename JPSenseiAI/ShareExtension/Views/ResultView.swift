import SwiftUI

struct ResultView: View {
    let response: AIResponse

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Original
                SectionCard(title: "Original", systemImage: "text.quote") {
                    Text(response.original)
                        .font(.title3)
                }

                // Furigana
                if !response.furigana.isEmpty {
                    SectionCard(title: "Furigana", systemImage: "textformat.abc") {
                        Text(response.furigana)
                            .font(.body)
                    }
                }

                // Vocabulary
                if !response.vocabulary.isEmpty {
                    SectionCard(title: "Vocabulary", systemImage: "character.book.closed") {
                        VStack(spacing: 10) {
                            ForEach(response.vocabulary) { item in
                                VocabularyCard(item: item)
                            }
                        }
                    }
                }

                // Grammar
                if !response.grammar.isEmpty {
                    SectionCard(title: "Grammar", systemImage: "text.book.closed") {
                        VStack(spacing: 10) {
                            ForEach(response.grammar) { item in
                                GrammarCard(item: item)
                            }
                        }
                    }
                }

                // Translation
                SectionCard(title: "Translation", systemImage: "globe") {
                    Text(response.translation)
                        .font(.body)
                }

                // Nuance
                if !response.nuance.isEmpty {
                    SectionCard(title: "Nuance", systemImage: "lightbulb") {
                        Text(response.nuance)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }

                // Examples
                if !response.examples.isEmpty {
                    SectionCard(title: "Examples", systemImage: "text.badge.plus") {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(response.examples) { example in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(example.japanese)
                                        .font(.body)
                                    Text(example.vietnamese)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                if example.id != response.examples.last?.id {
                                    Divider()
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ResultView(response: AIResponse(
        original: "今日は天気がいいですね。",
        furigana: "今日[きょう]は天気[てんき]がいいですね。",
        vocabulary: [
            VocabularyItem(word: "今日", reading: "きょう", meaning: "Hôm nay", nuance: "Dùng trong cả văn nói và văn viết", jlpt: "N5"),
            VocabularyItem(word: "天気", reading: "てんき", meaning: "Thời tiết", nuance: nil, jlpt: "N5")
        ],
        grammar: [
            GrammarItem(pattern: "〜ですね", explanation: "Dùng để xác nhận hoặc chia sẻ cảm nhận", whyUsed: "Người nói muốn đồng cảm với người nghe về thời tiết", commonMistake: "Nhầm với ですか (câu hỏi)", similar: "〜ですよ (thông báo)")
        ],
        translation: "Hôm nay thời tiết đẹp nhỉ.",
        nuance: "Câu giao tiếp nhẹ nhàng, thường dùng khi chào hỏi. Phong cách lịch sự (です/ます).",
        examples: [
            ExampleItem(japanese: "この本は面白いですね。", vietnamese: "Cuốn sách này hay nhỉ."),
            ExampleItem(japanese: "日本語は難しいですね。", vietnamese: "Tiếng Nhật khó nhỉ.")
        ]
    ))
}
