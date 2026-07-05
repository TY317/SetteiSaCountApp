//
//  otome5TableStrapMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/03.
//

import SwiftUI

struct otome5TableStrapMode: View {
    let lineList: [Int] = [2,2,1,2,1,2]
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・滞在中は通常時が有利となるモード")
                Text("・移行時はAT当選まで滞在")
                Text("・モンキー5のライバルモードのようなもの")
                Text("・ノブナガ、ゴエモン、ヒデヨシには設定差あり")
            }
            
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "ゴエモン",
                        "ノブナガ",
                        "ヒデヨシ",
                        "カンスケ",
                        "ミツヒデ",
                        "ヨシテル",
                    ],
                    maxWidth: 80,
                    lineList: self.lineList,
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "周期の規定ゲーム数が最大200Gになる",
                        "周期の規定ゲーム数が最大200Gになる",
                        "高テーブル滞在",
                        "巫女ポイントからの乙女アタック当選率アップ",
                        "本能寺の変ストックありでAT開始",
                        "AT当選で剣聖チャンス\nor真強カワRUSH突入",
                    ],
                    maxWidth: 300,
                    lineList: self.lineList,
                )
            }
        }
    }
}

#Preview {
    otome5TableStrapMode()
        .padding(.horizontal)
}
