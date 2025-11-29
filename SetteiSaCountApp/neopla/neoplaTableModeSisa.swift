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
                lineList: [11,4,2,3,6],
                contentFont: .footnote,
            )
            unitTableString(
                columTitle: "",
                stringList: [
                    "うお座",
                    "おひつじ座",
                    "かに座",
                    "おうし座",
                    "こと座",
                    "てんびん座",
                    "ペガサス座",
                    "リノ座(トマト)",
                    "ケロット＆ケロルン",
                    "通常時の全停止時にケロットランプ点灯(サブ液晶下の隠しランプ)",
                    "レバーオン時にプラネットランプ点滅＆ボーナス非当選(リール下の隠しランプ)",
                    "ホワイトホール(プチュンを伴った演出)",
                    "小バウンド",
                    "キラキラ上昇",
                    "ロケット上昇",
                    "Tロケット",
                    "大きなパン",
                    "人工衛星",
                    "宇宙飛行士",
                    "ウィンちゃん",
                ],
                lineList: [1,1,2,2,1,1,1,1,1,2,2,2,1,1,1,1,1,1,2,1],
                contentFont: .footnote,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "モードB期待度UP",
                    "モードB期待度UP\n111/333Gでの高確に期待",
                    "モードB期待度UP 強\n111/333Gでの高確に期待",
                    "モードB以上濃厚",
                    "モードC滞在濃厚",
                    "モードD or E滞在濃厚",
                    "設定4以上濃厚",
                    "設定6濃厚",
                    "モードE滞在濃厚",
                    "モードC滞在濃厚",
                    "次回モードE濃厚",
                    "デフォルト",
                    "調査中",
                    "調査中",
                    "1G連濃厚",
                    "次回モードE示唆",
                    "偶数設定示唆",
                    "設定2以上濃厚\n高設定示唆",
                    "設定6濃厚",
                ],
                lineList: [1,1,2,2,1,1,1,1,1,2,2,2,1,1,1,1,1,1,2,1],
                contentFont: .footnote,
            )
        }
    }
}

#Preview {
    neoplaTableModeSisa()
        .padding(.horizontal)
}
