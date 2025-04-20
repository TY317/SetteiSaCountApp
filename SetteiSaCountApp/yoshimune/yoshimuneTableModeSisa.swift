//
//  yoshimuneTableModeSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/19.
//

import SwiftUI

struct yoshimuneTableModeSisa: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "分類",
                stringList: [
                    "前兆\nﾀｲﾐﾝｸﾞ",
                    "流鏑馬"
                ],
                maxWidth: 80,
                lineList: [9,3],
                contentFont: .subheadline,
                colorList: []
            )
            unitTableString(
                columTitle: "演出",
                stringList: [
                    "200G台で前兆発生",
                    "300G台で前兆なし",
                    "42-49Gと98-105G\nの両方で高確率移行",
                    "200Gで夕方ステージ\nに移行しない",
                    "600,800Gの両方で\n前兆発生",
                    "400G台で前兆なし",
                    "的の大きさ 中",
                    "的の大きさ 大"
                ],
                maxWidth: 200,
                lineList: [1,1,2,2,2,1,2,1],
                contentFont: .subheadline,
                colorList: []
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "通常B\n期待度UP",
                    "通常B以上\n期待度UP",
                    "天国準備の\n期待度UP",
                    "天国準備濃厚",
                    "通常B以上\nのチャンス",
                    "通常B以上濃厚"
                ],
                maxWidth: 120,
                lineList: [2,4,2,1,2,1],
                contentFont: .subheadline,
                colorList: []
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    yoshimuneTableModeSisa()
}
