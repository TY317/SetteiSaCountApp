//
//  kokakukidotaiTableReplayFlush.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/15.
//

import SwiftUI

struct kokakukidotaiTableReplayFlush: View {
    var body: some View {
        Text("・CZ,AT終了後50G間のリプレイ成立時はフラッシュでモード示唆する場合あり")
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "", stringList: [
                    "ふわっと明滅",
                    "左→右に流れる",
                    "左→右→左に流れる",
                    "左→右→左に流れてから全体的に明滅",
                ],
                maxWidth: 200,
                lineList: [1,1,1,2]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "モードB以上示唆",
                    "モードC以上濃厚",
                    "モードC以上濃厚かつモードD以上に期待",
                ],
                maxWidth: 200,
                lineList: [1,1,1,2]
            )
        }
    }
}

#Preview {
    kokakukidotaiTableReplayFlush()
        .padding(.horizontal)
}
