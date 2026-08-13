//
//  dropkickTableLinePoint.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/13.
//

import SwiftUI

struct dropkickTableLinePoint: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "ラインポイント",
                    stringList: [
                        "右下がり、上段、中段、下段、右上がりの5ラインそれぞれに規定ポイントあり",
                        "50pt到達すると周期抽選でCZ抽選",
                        "周期天井は5周期",
                    ],
                    maxWidth: 300,
                    lineList: [2,]
                )
            }
            Text("・非ちゃんすラインのリプ・ベルは+1pt以上")
                .padding(.top)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "+1pt",
                        "+5pt",
                        "+10pt",
                        "+25pt",
                        "+50pt",
                        "+100pt",
                    ],
                    maxWidth: 70,
                    titleLine: 2,
                )
                unitTablePercent(
                    columTitle: "ちゃんすライン\nリプレイ・🔔",
                    percentList: [0,71.09,24.22,4.69,0,0],
                    numberofDicimal: 1,
                    titleLine: 2,
                    titleFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "非ちゃんすライン\n🍉",
                    percentList: [0,76.56,20.31,3.13,0,0],
                    numberofDicimal: 1,
                    titleLine: 2,
                    titleFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "ちゃんすライン\n🍉",
                    percentList: [0,0,0,0,75,25],
                    titleLine: 2,
                    titleFont: .subheadline,
                )
            }
        }
    }
}

#Preview {
    dropkickTableLinePoint()
        .padding(.horizontal)
}
