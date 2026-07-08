import SwiftUI

/// Card displaying a single vocabulary item
struct VocabularyCard: View {
    let item: VocabularyItem

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .firstTextBaseline) {
                Text(item.word)
                    .font(.body.weight(.medium))
                Text(item.reading)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Text(item.meaning)
                .font(.subheadline)

            if let example = item.example {
                VStack(alignment: .leading, spacing: 2) {
                    Text(example.japanese)
                        .font(.caption)
                        .foregroundStyle(.primary.opacity(0.8))
                    Text(example.vietnamese)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 4)
            }
        }
        .padding(10)
        .background(Color(.tertiarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    VocabularyCard(item: VocabularyItem(
        word: "天気",
        reading: "てんき",
        meaning: "Thời tiết",
        example: ExampleItem(japanese: "今日の天気はいいですね。", vietnamese: "Thời tiết hôm nay đẹp nhỉ.")
    ))
    .padding()
}
