//
//  worldDaiStarTableVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/29.
//

import SwiftUI

struct worldDaiStarTableVoice: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "じゅーじゅ、じゅじゅじゅ、じゅ!",
                    "思い込みは真実よりも甘美なるもの",
                    "この世は舞台、人は皆役者だ",
                ],
                maxWidth: 200,
                lineList: [2,2,2]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "高設定示唆 弱",
                    "高設定示唆 強",
                ],
                lineList: [2,2,2]
            )
        }
    }
}

#Preview {
    worldDaiStarTableVoice()
}
