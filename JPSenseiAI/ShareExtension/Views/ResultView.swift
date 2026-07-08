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

                // Translation
                SectionCard(title: "Translation", systemImage: "globe") {
                    Text(response.translation)
                        .font(.body)
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
            }
            .padding()
        }
    }
}

#Preview {
    ResultView(response: AIResponse(
        original: "今日は天気がいいですね。",
        vocabulary: [
            VocabularyItem(word: "今日", reading: "きょう", meaning: "Hôm nay", example: ExampleItem(japanese: "今日は暑いです。", vietnamese: "Hôm nay nóng.")),
            VocabularyItem(word: "天気", reading: "てんき", meaning: "Thời tiết", example: nil)
        ],
        grammar: [
            GrammarItem(pattern: "〜ですね", explanation: "Dùng để xác nhận hoặc chia sẻ cảm nhận", whyUsed: "Người nói muốn đồng cảm với người nghe về thời tiết", example: ExampleItem(japanese: "この本は面白いですね。", vietnamese: "Cuốn sách này hay nhỉ."), commonMistake: "Nhầm với ですか (câu hỏi)", similar: "〜ですよ (thông báo)")
        ],
        translation: "Hôm nay thời tiết đẹp nhỉ."
    ))
}
