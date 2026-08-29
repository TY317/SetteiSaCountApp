//
//  tonskillTableCzPoint.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/17.
//

import SwiftUI

struct tonskillTableCzPoint: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text("[ポイント加算抽選]")
                    .font(.title2)
                HStack(spacing: 0){
                    unitTableString(
                        columTitle: "",
                        stringList: ["通常状態", "好機状態"]
                    )
                    unitTableString(
                        columTitle: "獲得ポイント",
                        stringList: ["3pt以上", "15pt以上"]
                    )
                }
            }
            
            VStack {
                Text("[ポイント概要]")
                    .font(.title2)
                unitTableString(
                    columTitle: "概要",
                    stringList: [
                        "150pt到達でCZ当選",
                        "チャンス役停止時の演出エフェクトで獲得ptを示唆\nエフェクトは弱・中・強の3種類",
                        "ポイントはST終了後も持ち越し\nただし、女神降臨後はポイントリセット濃厚"
                    ],
                    maxWidth: 350,
                    lineList: [1,2,2]
                )
            }
        }
    }
}

#Preview {
    tonskillTableCzPoint()
}
