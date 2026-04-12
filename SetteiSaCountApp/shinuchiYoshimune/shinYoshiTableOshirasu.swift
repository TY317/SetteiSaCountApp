//
//  shinYoshiTableOshirasu.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/03.
//

import SwiftUI

struct shinYoshiTableOshirasu: View {
    let lineList: [Int] = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,2,1,2,1,1,1,1,1,1]
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
                maxWidth: 70,
                lineList: [3,3,4,4,6,4,5]
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
                maxWidth: 120,
                lineList: self.lineList,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "偶数示唆",
                    "高設定示唆",
                    "夜回りpt 300以内示唆",
                    "夜回りpt 200以内示唆",
                    "夜回りpt 100以内示唆",
                    "CZモードB以上示唆",
                    "CZモードC以上示唆",
                    "CZモードD以上示唆",
                    "天国濃厚",
                    "5回中2回天国",
                    "3回目までに天国",
                    "2回目までに天国",
                    "5回中3回天国",
                    "次回 50%で武器商人or姉御or柳生",
                    "次回 50%で柳生",
                    "次回 武器商人or姉御or柳生 濃厚",
                    "次回 柳生 濃厚",
                    "この先3回は武器商人or姉御or柳生",
                    "3回目までに柳生",
                    "2回目までに柳生",
                    "6周期否定",
                    "1・3・5周期がチャンス",
                    "1・2・4周期がチャンス",
                    "当該or次周期でCZ濃厚",
                    "当該周期でCZ濃厚",
                ],
                maxWidth: 300,
                lineList: self.lineList,
                contentFont: .subheadline,
            )
        }
    }
}

#Preview {
    ScrollView {
        shinYoshiTableOshirasu()
    }
        .padding(.horizontal)
}
