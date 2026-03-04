//
//  gobsla2TableEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/04.
//

import SwiftUI

struct gobsla2TableEnding: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "大したものだな",
                    "やりおるのう",
                    "おお、甘露甘露",
                    "まあまあってとこかしら",
                    "すごいです",
                    "つーかこりゃ案外と悪くねえわな",
                    "なかなかの調子ではござらぬかな",
                    "ううーん、いいわねー",
                    "今日は絶好調です",
                    "いいことありそうだね",
                    "堂々としていればいいんですよ、堂々と",
                    "剣の君よ守りの加護を",
                ],
                maxWidth: 200,
                lineList: [1,1,1,1,1,2,2,1,1,2,2,1,]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "高設定示唆 弱",
                    "高設定示唆 強",
                    "設定2 以上濃厚\n＋高設定示唆 弱",
                    "設定2 以上濃厚\n＋高設定示唆 強",
                    "設定3 以上濃厚",
                    "設定4 以上濃厚",
                    "設定5 以上濃厚\n設定6示唆 弱",
                    "設定5 以上濃厚\n設定6示唆 強",
                    "設定6 以上濃厚",
                ],
                maxWidth: 150,
                lineList: [1,2,2,2,2,1,1,2,2,1,]
            )
        }
    }
}

#Preview {
    gobsla2TableEnding()
        .padding(.horizontal)
}
