//
//  goevaTableEndingVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/22.
//

import SwiftUI

struct goevaTableEndingVoice: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "シンジ",
                    "マリ",
                    "アスカ",
                    "レイ",
                    "ミサト",
                    "加持",
                    "カヲル",
                    "ー",
                ],
                maxWidth: 60,
                contentFont: .body,
            )
            unitTableString(
                columTitle: "ボイス",
                stringList: [
                    "僕は、エヴァンゲリオン初号機パイロット、碇シンジです",
                    "自分の目的に大人を巻き込むのは気後れするな",
                    "そっか。私、笑えるんだ",
                    "私が死んでも変わりはいるもの",
                    "奇跡を待つより捨て身の努力よ",
                    "大人はさ、ズルいくらいがちょうどいいんだ",
                    "歌は良いね。歌は心を癒してくれる、リリンが生み出した文化の極みだよ",
                    "(ボイスなし)"
                ],
                maxWidth: 200,
                contentFont: .body,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "高設定示唆 弱",
                    "高設定示唆 強",
                    "偶数示唆",
                    "奇数示唆",
                    "設定4 以上濃厚",
                    "設定6 濃厚",
                    "設定2 以上濃厚",
                ],
                maxWidth: 100,
                contentFont: .body,
            )
        }
    }
}

#Preview {
    goevaTableEndingVoice()
        .padding(.horizontal)
}
