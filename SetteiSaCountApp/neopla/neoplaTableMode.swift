//
//  neoplaTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/16.
//

import SwiftUI

struct neoplaTableMode: View {
    let lineList: [Int] = [1,2,2,2,2,2]
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "モードA",
                        "モードB",
                        "モードC",
                        "モードD",
                        "モードE",
                        "モードF",
                    ],
                    maxWidth: 70,
                    lineList: self.lineList,
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "・基本のモード",
                        "・モードAよりボーナス確率が高い\n・転落なし\n・モードD移行のチャンス",
                        "・モードAよりボーナス確率が低い\n・転落なし\n・モードE移行の大チャンス",
                        "・ボーナス高確率状態(ループ率 中)\n・転落時はモードA〜Cへ移行",
                        "・ボーナス高確率状態(ループ率 高)\n・転落時はモードDへ移行",
                        "・設定変更時に移行\n・ボーナス後はモードB以上へ移行"
                    ],
                    maxWidth: 250,
                    lineList: self.lineList,
                    contentFont: .caption,
                    textAlignment: .leading,
                )
                unitTableString(
                    columTitle: "天井",
                    stringList: ["777G","500G"],
                    maxWidth: 70,
                    lineList: [9,2],
                )
            }
        }
    }
}

#Preview {
    neoplaTableMode()
        .padding(.horizontal)
}
