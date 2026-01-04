//
//  mushotenSectionEndingTable.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/03.
//

import SwiftUI

struct mushotenSectionEndingTable: View {
    var body: some View {
        Section {
            Text("エンディング中のヒロイン役成立時に出現するキャラで設定を示唆")
                .foregroundStyle(Color.secondary)
                .font(.caption)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "白",
                        "青",
                        "緑",
                        "赤",
                        "虹",
                    ],
                    maxWidth: 30,
                    lineList: [4,3,2,3,1],
                    colorList: [
                        .white,
                        .tableBlue,
                        .tableGreen,
                        .tableRed,
                        .tablePurple,
                    ]
                )
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "ルーデウス\n(アクアハーティア)",
                        "ルーデウス\n(ロキシーの杖)",
                        "ロキシー",
                        "シルフィ",
                        "エリス",
                        "ゼニス",
                        "パウロ",
                        "キシリカ",
                        "ヒトガミ",
                        "無職の男",
                        "オルステッド",
                    ],
                    lineList: [2,2],
                    colorList: [
                        .white,
                        .white,
                        .tableBlue,
                        .tableBlue,
                        .tableBlue,
                        .tableGreen,
                        .tableGreen,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tablePurple,
                    ],
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "奇数示唆",
                        "偶数示唆",
                        "設定2 以上濃厚",
                        "設定2 否定",
                        "設定3 否定",
                        "高設定示唆 弱",
                        "高設定示唆 強",
                        "設定3 以上濃厚",
                        "設定4 以上濃厚",
                        "設定5 以上濃厚",
                        "設定6 濃厚",
                    ],
                    lineList: [2,2],
                    colorList: [
                        .white,
                        .white,
                        .tableBlue,
                        .tableBlue,
                        .tableBlue,
                        .tableGreen,
                        .tableGreen,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tablePurple,
                    ],
                )
            }
            .frame(maxWidth: .infinity, alignment: .center)
        } header: {
            Text("レア役時のキャラ")
        }
    }
}

#Preview {
    List {
        mushotenSectionEndingTable()
    }
}
