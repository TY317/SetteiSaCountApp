//
//  karakuri2TableSenario.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/01.
//

import SwiftUI

struct karakuri2TableSenario: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "1回目",
                    "2回目",
                    "3回目",
                    "4回目",
                    "5回目",
                    "6回目",
                ],
                maxWidth: 60,
                contentFont: .subheadline,
            )
            unitTableString(
                columTitle: "シナリオ1",
                stringList: [
                    "ミンシア",
                    "ヴィルマ",
                    "ギィ",
                    "ジョージ",
                    "リーゼロッテ",
                    "阿紫花",
                ],
                titleFont: .subheadline,
                contentFont: .subheadline,
            )
            unitTableString(
                columTitle: "シナリオ2",
                stringList: [
                    "リーゼロッテ",
                    "ジョージ",
                    "阿紫花",
                    "ヴィルマ",
                    "ミンシア",
                    "ギィ",
                ],
                titleFont: .subheadline,
                contentFont: .subheadline,
            )
            unitTableString(
                columTitle: "シナリオ3",
                stringList: [
                    "ヴィルマ",
                    "ミンシア",
                    "ギィ",
                    "リーゼロッテ",
                    "ジョージ",
                    "阿紫花",
                ],
                titleFont: .subheadline,
                contentFont: .subheadline,
            )
            unitTableString(
                columTitle: "シナリオ3",
                stringList: [
                    "ジョージ",
                    "リーゼロッテ",
                    "阿紫花",
                    "ミンシア",
                    "ヴィルマ",
                    "ギィ",
                ],
                titleFont: .subheadline,
                contentFont: .subheadline,
            )
        }
    }
}

#Preview {
    karakuri2TableSenario()
        .padding(.horizontal)
}
