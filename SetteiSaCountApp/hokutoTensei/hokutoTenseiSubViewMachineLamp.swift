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
                        lineList: [1,3,1]
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "通常時モード示唆",
                            "設定示唆\n(白<白点滅<水色<水色点滅<黄緑<黄緑点滅<金)",
                            "規定あべしの近さ"
                        ],
                        maxWidth: 300,
                        lineList: [1,3,1],
                    )
                }
            }
        }
    }
}

#Preview {
    hokutoTenseiSubViewMachineLamp()
        .padding(.horizontal)
}

