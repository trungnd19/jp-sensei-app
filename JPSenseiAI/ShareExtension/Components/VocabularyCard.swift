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

                Spacer()

                if let jlpt = item.jlpt, !jlpt.isEmpty {
                    Text(jlpt)
                        .font(.caption2.weight(.medium))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.indigo.opacity(0.1))
                        .clipShape(Capsule())
                }
            }

            Text(item.meaning)
                .font(.subheadline)

            if let nuance = item.nuance, !nuance.isEmpty {
                Text(nuance)
                    .font(.caption)
                    .foregroundStyle(.secondary)
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
        nuance: "Dùng trong cả văn nói và văn viết",
        jlpt: "N5"
    ))
    .padding()
}
