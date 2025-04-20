//
//  tokyoGhoulTableCzEndScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct tokyoGhoulTableCzEndScreen: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "枠色",
                stringList: ["白","青","黄","緑","赤","紫","金","虹"],
                maxWidth: 60,
                lineList: [2,2,3,2,4,1,1,1],
                colorList: [
                    .white,
                    .personalSummerLightBlue,
                    .personalSpringLightYellow,
                    .personalSummerLightGreen,
                    .personalSummerLightRed,
                    .personalSummerLightPurple,
                    .orange,
                    .purple
                ]
            )
            unitTableString(
                columTitle: "キャラ",
                stringList: [
                    "金木 研 A",
                    "金木 研 B",
                    "霧嶋 菫香",
                    "笛口 雛実",
                    "亜門 鋼太郎",
                    "真戸 呉緒\n(白髪の人)",
                    "金木 研(喰種)",
                    "霧嶋 菫香(喰種)",
                    "月山 習\n(赤シャツの人)",
                    "鈴谷 什造\n(逆さの人)",
                    "神代 利世",
                    "梟",
                    "有馬 貴将"
                ],
                lineList: [1,1,1,1,1,2,1,1,2,2,1,1,1],
                contentFont: .body,
                colorList: [
                    .white,
                    .white,
                    .personalSummerLightBlue,
                    .personalSummerLightBlue,
                    .personalSpringLightYellow,
                    .personalSpringLightYellow,
                    .personalSummerLightGreen,
                    .personalSummerLightGreen,
                    .personalSummerLightRed,
                    .personalSummerLightRed,
                    .personalSummerLightPurple,
                    .orange,
                    .purple
                ]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "デフォルト",
                    "通常B以上示唆",
                    "通常B以上示唆",
                    "通常B以上示唆",
                    "通常C以上示唆",
                    "チャンス以上示唆",
                    "チャンス以上示唆",
                    "天国準備以上示唆",
                    "偶数設定濃厚",
                    "天国濃厚",
                    "設定4 以上濃厚",
                    "設定6 濃厚"
                ],
                lineList: [1,1,1,1,1,2,1,1,2,2,1,1,1],
                contentFont: .body,
                colorList: [
                    .white,
                    .white,
                    .personalSummerLightBlue,
                    .personalSummerLightBlue,
                    .personalSpringLightYellow,
                    .personalSpringLightYellow,
                    .personalSummerLightGreen,
                    .personalSummerLightGreen,
                    .personalSummerLightRed,
                    .personalSummerLightRed,
                    .personalSummerLightPurple,
                    .orange,
                    .purple
                ]
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    tokyoGhoulTableCzEndScreen()
}
