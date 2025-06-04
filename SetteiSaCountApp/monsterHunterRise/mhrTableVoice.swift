//
//  mhrTableVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/27.
//

import SwiftUI

struct mhrTableVoice: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "ウツシ",
                    "ヒノエ",
                    "ｴﾝﾀﾗｲｵﾝ"
                ],
                maxWidth: 80,
                lineList: [3,3,2],
                contentFont: .body
            )
            unitTableString(
                columTitle: "ボイス",
                stringList: [
                    "(第1停止)うぉぉぉぉぉ！\n(第2停止)愛弟子とのスロット\n(第3停止)最高〜！",
                    "(第1停止)うふふ！このことは〜\n(第2停止)ミノトに\n(第3停止)内緒ですよ",
                    "(紫7の1確ボイスでエンタライオン)"
                ],
                maxWidth: 200,
                lineList: [3,3,2],
                contentFont: .subheadline
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "設定5\n以上濃厚",
                    "設定6\n濃厚",
                    "設定6\n濃厚"
                ],
                maxWidth: 80,
                lineList: [3,3,2],
                contentFont: .body
            )
        }
    }
}

#Preview {
    mhrTableVoice()
        .padding(.horizontal)
}
