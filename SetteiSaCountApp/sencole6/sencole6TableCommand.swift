//
//  sencole6TableCommand.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/02.
//

import SwiftUI

struct sencole6TableCommand: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("上上下下左右左右 → PUSH でボイス発生")
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "私が出るわ",
                        "たーまらんぜよー",
                        "早く小町と遊びましょ?",
                        "楽しくいきましょう",
                        "ニャッハァーン",
                        "お勉強の時間です",
                        "てんかたいへーい",
                        "おっかわりー",
                        "どすこーい",
                    ]
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト",
                        "モードB以上濃厚",
                        "天国濃厚",
                        "次々回までにモードB以上あり",
                        "次々回までに天国あり",
                        "2周期以内にAT当選",
                        "3周期以内にAT当選",
                        "4周期以内にAT当選",
                        "5周期以内にAT当選",
                    ],
                    maxWidth: 200,
                )
            }
        }
    }
}

#Preview {
    sencole6TableCommand()
        .padding(.horizontal)
}
