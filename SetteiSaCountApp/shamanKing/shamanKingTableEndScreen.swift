//
//  shamanKingTableEndScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct shamanKingTableEndScreen: View {
    let lineList:[Int] = [2,2,2,2,2,2,1,1,1,1,1,1,1]
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "麻倉葉",
                    "道蓮",
                    "ホロホロ",
                    "チョコラブ",
                    "リゼルグ",
                    "恐山アンナ",
                    "X-LAWS",
                    "花組",
                    "ゴーレム",
                    "パッチ族",
                    "葉＋アンナ",
                    "ハオ",
                    "全員集合"
                ],
                maxWidth: 120,
                lineList: self.lineList
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト\n(葉カスタム時)",
                    "デフォルト\n(蓮カスタム時)",
                    "デフォルト\n(ホロホロカスタム時)",
                    "デフォルト\n(チョコラブカスタム時)",
                    "デフォルト\n(リゼルグカスタム時)",
                    "デフォルト\n(アンナモード滞在時)",
                    "設定3or5示唆",
                    "偶数示唆",
                    "高設定示唆",
                    "設定2 以上濃厚",
                    "設定4 以上濃厚",
                    "設定5 以上濃厚",
                    "設定6 濃厚"
                ],
                maxWidth: 230,
                lineList: self.lineList
            )
        }
    }
}

#Preview {
    shamanKingTableEndScreen()
}
