//
//  shinYoshiTableOshirasu.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/03.
//

import SwiftUI

struct shinYoshiTableOshirasu: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "キャラ\n一枚絵",
                    "夜回り\n気配",
                    "おみくじ",
                    "浮世絵",
                    "人相書",
                    "号外",
                    "大奥",
                ],
                maxWidth: 80,
                lineList: [3,3,4,4,4,3,5]
            )
            unitTableString(
                columTitle: "",
                stringList: [
                    "吉宗",
                    "大岡越前",
                    "天英院",
                    "ほどなく",
                    "間もなく",
                    "近くに",
                    "末吉",
                    "小吉",
                    "中吉",
                    "大吉",
                    "橋",
                    "町",
                    "夕方",
                    "夜",
                    "悪人?(黒)",
                    "極悪人?(黒)",
                    "悪人!(緑)",
                    "極悪人!(赤)",
                    "事件の香りでぇい！",
                    "特ダネでぇい！",
                    "号外！号外でぇい！",
                    "1人",
                    "2人",
                    "3人",
                    "4人",
                    "5人",
                ],
                lineList: [1,1,1],
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "設定示唆",
                    "夜回りポイント示唆",
                    "周期モード示唆",
                    "5回先までの天国有無示唆",
                    "次回CZの対戦相手示唆",
                    "5回先までのCZ対戦相手示唆",
                    "CZ当選までの周期数示唆",
                ],
                lineList: [3,3,4,4,4,3,5],
            )
        }
    }
}

#Preview {
    shinYoshiTableOshirasu()
        .padding(.horizontal)
}
