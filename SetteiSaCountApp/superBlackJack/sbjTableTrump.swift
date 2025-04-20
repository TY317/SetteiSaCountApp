//
//  sbjTableTrump.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct sbjTableTrump: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "オーリン\nクラーク",
                    "ティファニー\nローザ",
                    "ハワード",
                    "ミント",
                    "リオ",
                    "リナ"
                ],
                lineList: [2,2,1,1,1,1]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "偶数示唆",
                    "高設定示唆 弱",
                    "高設定示唆 弱",
                    "高設定示唆 中",
                    "高設定示唆 強"
                ],
                lineList: [2,2,1,1,1,1]
            )
        }
    }
}

#Preview {
    sbjTableTrump()
}
