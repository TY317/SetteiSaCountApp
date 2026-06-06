//
//  sao2TableGGOMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/06.
//

import SwiftUI

struct sao2TableGGOMode: View {
    let lineList: [Int] = [2,1,1,2]
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・設定変更後、CZ終了時、AT終了時に移行を抽選")
                Text("・当選したモードはAT当選まで継続")
                Text("・複数モードに重複して滞在する可能性あり")
            }
            
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "キリト",
                        "詩乃",
                        "シノン",
                        "死銃",
                    ],
                    maxWidth: 80,
                    lineList: self.lineList,
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "規定液晶ゲーム数の天井を最大500Gに短縮",
                        "CZ当選をAT直撃に変換",
                        "常時スナイパーチャンスの高確率状態",
                        "AT中のスナイパーチャンス1戦目の対戦相手がデス・ガン",
                    ],
                    maxWidth: 300,
                    lineList: self.lineList,
                )
            }
            VStack {
                Text("[アイテムでの示唆]")
                    .font(.title2)
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "光剣",
                            "アミュスフィア",
                            "へカートⅡ",
                            "黒星",
                            "バギー",
                        ]
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "キリトモード滞在示唆",
                            "詩乃滞在示唆",
                            "シノン滞在示唆",
                            "死銃滞在示唆",
                            "いずれかのモード滞在示唆",
                        ],
                        maxWidth: 250,
                    )
                }
            }
        }
    }
}

#Preview {
    sao2TableGGOMode()
        .padding(.horizontal)
}
