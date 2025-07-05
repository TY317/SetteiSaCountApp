//
//  mt5TableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/22.
//

import SwiftUI

struct mt5TableMode: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "1周期",
                        "2周期",
                        "3周期",
                        "4周期",
                        "5周期",
                        "6周期",
                    ]
                )
                unitTableString(
                    columTitle: "通常A",
                    stringList: [
                        "-",
                        "◎",
                        "◯",
                        "△",
                        "◎",
                        "天井",
                    ]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: [
                        "-",
                        "◎",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: [
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "ヘルメット",
                        "セリフ",
                        "激走チャージ後のセリフ",
                    ],
                    maxWidth: 100,
                    lineList: [3,6,4],
                    contentFont: .subheadline,
                    colorList: [
                        .tableBlue,
                        .tableGreen,
                        .tableRed,
                    ]
                )
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "ロゴ＋V",
                        "ロゴ＋キラキラ",
                        "ロゴ",
                        "(櫛田)今のレース、なかなか楽しかったわ",
                        "(洞口 父)お前がSGなんぞ10年早いわ",
                        "(浜岡)波多野、洞口Jrに負けんなよ",
                        "(蒲生)面白くなってきたのう",
                        "(洞口)青島さんは渡さない",
                        "(榎木)波多野、何か感じないか？",
                        "(青島 赤)ここからが本当の勝負よ",
                        "(波多野 緑)ここは負けられねぇ",
                        "(青島 黄)お互い頑張ろうね",
                        "(波多野 黄)頑張れよ",
                    ],
                    maxWidth: 150,
                    contentFont: .subheadline,
                    colorList: [
                        .tableBlue,
                        .tableBlue,
                        .tableBlue,
                        .tableGreen,
                        .tableGreen,
                        .tableGreen,
                        .tableGreen,
                        .tableGreen,
                        .tableGreen,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                    ]
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "天国濃厚",
                        "通常B or 天国濃厚",
                        "通常Bの期待アップ",
                        "通常B or 天国濃厚",
                        "通常B or 天国濃厚",
                        "通常B示唆",
                        "通常B示唆",
                        "通常B示唆",
                        "通常B示唆",
                        "通常B or 天国濃厚",
                        "通常B or 天国濃厚",
                        "通常B期待度50%",
                        "通常B期待度33%",
                    ],
                    maxWidth: 120,
                    contentFont: .subheadline,
                    colorList: [
                        .tableBlue,
                        .tableBlue,
                        .tableBlue,
                        .tableGreen,
                        .tableGreen,
                        .tableGreen,
                        .tableGreen,
                        .tableGreen,
                        .tableGreen,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                    ]
                )
            }
        }
    }
}

#Preview {
    mt5TableMode()
        .padding(.horizontal)
}
