//
//  sencole6TableUraMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/04.
//

import SwiftUI

struct sencole6TableUraMode: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・通常時に滞在の可能性がある3種類の裏モードが存在")
                Text("・モンキーのライバルモードみたいな感じかも")
            }
            
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "ぴょんだふるモード",
                        "わんだふるモード",
                        "にゃんだふるモード",
                    ]
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "CZ「振り向かせたいむ」高確率",
                        "毎ゲーム規定周期の短縮抽選",
                        "規定コレポイント222以下",
                    ],
                    maxWidth: 250,
                )
            }
        }
    }
}

#Preview {
    sencole6TableUraMode()
        .padding(.horizontal)
}
