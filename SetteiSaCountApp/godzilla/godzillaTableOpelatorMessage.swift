//
//  godzillaTableOpelatorMessage.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/13.
//

import SwiftUI

struct godzillaTableOpelatorMessage: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "セリフ",
                stringList: [
                    "この台、ゴジラの怒りを秘めているようです",
                    "ゴジラの力強さを感じます",
                    "この台には巨大な力が眠っているようです",
                    "怪獣の世界に足を踏み入れた気分です",
                    "あのゴジラが、最後の一匹とは思えません",
                    "この台、怪獣の力が宿っています",
                    "この台は巨大な怪獣の目覚めを予感させます",
                    "ゴジラは怒りの象徴です",
                    "ゴジラは人間の心の闇を映す鏡です",
                    "ゴジラは地球の守護者です",
                    "ゴジラは私たちの未来を守るために戦っています",
                    "ゴジラの伝説がこの台に息づいているようです",
                    "ゴジラの伝説がこの台に刻まれています"
                ],
                maxWidth: 250,
                contentFont: .caption,
                colorList: [
                    .white,
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
                    .personalSummerLightPurple
                ]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "高設定示唆",
                    "設定2 以上濃厚",
                    "設定3 以上濃厚",
                    "設定4 以上濃厚",
                    "設定5 以上濃厚",
                    "設定6 以上濃厚"
                ],
                maxWidth: 140,
                lineList: [3,2,2,2,2,2],
                contentFont: .body,
                colorList: [
                    .white,
                    .personalSummerLightBlue,
                    .personalSpringLightYellow,
                    .personalSummerLightGreen,
                    .personalSummerLightRed,
                    .personalSummerLightPurple
                ]
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    godzillaTableOpelatorMessage()
}
