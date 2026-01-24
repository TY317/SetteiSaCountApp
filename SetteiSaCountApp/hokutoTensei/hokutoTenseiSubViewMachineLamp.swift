//
//  hokutoTenseiSubViewMachineLamp.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/02.
//

import SwiftUI

struct hokutoTenseiSubViewMachineLamp: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・100G消化ごとに台枠ランプで示唆")
                Text("・当該遊戯の停止操作終わらせた際に光っているランプに注目")
            }
            .padding(.bottom)
            HStack {
                Image("hokutoTenseiMachineLamp")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140)
                    .cornerRadius(15)
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: ["A","B","C",],
                        maxWidth: 20,
                        lineList: [2,3,1]
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "通常時モード示唆\n(一部矛盾で設定示唆)",
                            "設定示唆\n(白<白点滅<水色<水色点滅<黄緑<黄緑点滅<金)",
                            "規定あべしの近さ"
                        ],
                        maxWidth: 300,
                        lineList: [2,3,1],
                    )
                }
            }
            .padding(.bottom)
            Text("[Aランプでの示唆]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "白",
                        "白点滅",
                        "水色",
                        "水色点滅",
                        "水色＋白流れる",
                        "水色点滅＋白流れる",
                        "黄緑",
                        "黄緑点滅",
                        "金",
                        "金点滅",
                        "紫",
                        "紫点滅",
                    ],
                    lineList: [1,1,1,1,1,1,2,2,2,2,2,2,]
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "1280あべし以内示唆 弱",
                        "1280あべし以内示唆 強",
                        "896あべし以内示唆 弱",
                        "576あべし以内示唆 弱",
                        "896あべし以内示唆 強",
                        "576あべし以内示唆 強",
                        "モードB以上濃厚\n(否定で設定2以上濃厚)",
                        "モードC以上濃厚\n(否定で設定2以上濃厚)",
                        "モードB以上濃厚\n(否定で設定4以上濃厚)",
                        "モードC以上濃厚\n(否定で設定4以上濃厚)",
                        "モードB以上濃厚\n(否定で設定4以上濃厚)",
                        "モードC以上濃厚\n(否定で設定4以上濃厚)",
                    ],
                    maxWidth: 200,
                    lineList: [1,1,1,1,1,1,2,2,2,2,2,2,]
                )
            }
        }
    }
}

#Preview {
    ScrollView {
        hokutoTenseiSubViewMachineLamp()
    }
        .padding(.horizontal)
}

