import SwiftUI

/// Card displaying a grammar explanation
struct GrammarCard: View {
    let item: GrammarItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.pattern)
                .font(.body.weight(.medium))

            Text(item.explanation)
                .font(.subheadline)

            if !item.whyUsed.isEmpty {
                HStack(alignment: .top, spacing: 6) {
                    Image(systemName: "questionmark.circle")
                        .font(.caption)
                        .foregroundStyle(.indigo)
                    Text(item.whyUsed)
                        .font(.caption)
                }
            }

            if let mistake = item.commonMistake, !mistake.isEmpty {
                HStack(alignment: .top, spacing: 6) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.caption)
                        .foregroundStyle(.orange)
                    Text(mistake)
                        .font(.caption)
                }
            }

            if let similar = item.similar, !similar.isEmpty {
                HStack(alignment: .top, spacing: 6) {
                    Image(systemName: "arrow.left.arrow.right")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(similar)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(Color(.tertiarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    GrammarCard(item: GrammarItem(
        pattern: "〜ですね",
        explanation: "Dùng để xác nhận hoặc chia sẻ cảm nhận với người nghe",
        whyUsed: "Người nói muốn tạo sự đồng cảm về thời tiết",
        commonMistake: "Nhầm với ですか (câu hỏi)",
        similar: "〜ですよ (thông báo thông tin mới)"
    ))
    .padding()
}
