//
//  godeaterTableVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/21.
//

import SwiftUI

struct godeaterTableVoice: View {
    @ObservedObject var godeater: Godeater
    
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "キャラ",
                stringList: [
                    "コウタ",
                    "アリサ",
                    "ヒバリ",
                    "サクヤ",
                    "ソーマ",
                    "レン",
                    "ユウ",
                    "エリナ",
                    "リンドウ",
                    "シオ",
                ],
                maxWidth: 60,
                contentFont: .body,
            )
            unitTableString(
                columTitle: "ボイス",
                stringList: godeater.selectListVoice,
                maxWidth: 200,
                contentFont: .body,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "デフォルト",
                    "偶数示唆 弱",
                    "偶数示唆 強",
                    "高設定示唆 弱",
                    "高設定示唆 強",
                    "設定2,3否定",
                    "偶数濃厚",
                    "設定2 以上濃厚",
                    "設定5 以上濃厚",
                ],
                maxWidth: 100,
                contentFont: .body,
            )
        }
    }
}

#Preview {
    godeaterTableVoice(
        godeater: Godeater(),
    )
        .padding(.horizontal)
}
