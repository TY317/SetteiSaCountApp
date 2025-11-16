//
//  neoplaTableModeSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/16.
//

import SwiftUI

struct neoplaTableModeSisa: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "サブ液晶\n星座",
                    "筐体ランプ",
                    "告知演出",
                    "ボーナス中\nミニゲーム\n演出",
                    "ボーナス\n終了画面",
                ],
                maxWidth: 80,
                lineList: [2,4,2,3,3],
                contentFont: .footnote,
            )
            unitTableString(
                columTitle: "",
                stringList: [
                    "詳細調査中",
                    "通常時の全停止時にケロットランプ点灯(サブ液晶下の隠しランプ)",
                    "レバーオン時にプラネットランプ点滅＆ボーナス非当選(リール下の隠しランプ)",
                    "ホワイトホール(プチュンを伴った演出)",
                    "小バウンド",
                    "キラキラ上昇",
                    "ロケット上昇",
                    "人工衛星",
                    "宇宙飛行士",
                    "大きなパン",
                ],
                lineList: [2,2,2,2,1,1,1,1,1,1],
                contentFont: .footnote,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "滞在モード示唆",
                    "モードE滞在濃厚",
                    "モードC滞在濃厚",
                    "次回モードE濃厚",
                    "デフォルト",
                    "調査中",
                    "調査中",
                    "調査中",
                    "調査中",
                    "次回モードE示唆",
                ],
                lineList: [2,2,2,2,1,1,1,1,1,1],
                contentFont: .footnote,
            )
        }
    }
}

#Preview {
    neoplaTableModeSisa()
        .padding(.horizontal)
}
