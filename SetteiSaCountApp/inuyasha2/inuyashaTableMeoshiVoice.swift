//
//  inuyashaTableMeoshiVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/13.
//

import SwiftUI

struct inuyashaTableMeoshiVoice: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "ボイス",
                stringList: [
                    "さすがだな",
                    "ふん、当然だ",
                    "おすわりぃ",
                    "もうっだいっきらい",
                    "信じて撃つのよ！あたしの矢は四魂の玉を貫く",
                    "この殺生丸に斬れぬものは無い",
                    "俺は命を懸けてお前を守る"
                ],
                maxWidth: 250,
                lineList: [1,1,1,1,1,1,1],
                contentFont: .body,
                colorList: [.white,.white,.tableBlue,.tableBlue,.personalSummerLightGreen,.personalSummerLightGreen,.personalSummerLightRed]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "高設定示唆 弱",
                    "高設定示唆 中",
                    "高設定示唆 強"
                ],
                lineList: [2,2,2,1],
                colorList: [.white,.tableBlue,.personalSummerLightGreen,.personalSummerLightRed]
            )
        }
    }
}

#Preview {
    inuyashaTableMeoshiVoice()
        .padding(.horizontal)
}
