//
//  jormungandTableChara12.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/23.
//

import SwiftUI

struct jormungandTableChara12: View {
    @ObservedObject var jormungand: Jormungand
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "奇数示唆",
                        "偶数示唆",
                        "高設定示唆",
                        "設定2 以上濃厚",
                        "設定4 以上濃厚",
                        "設定6 濃厚",
                    ]
                )
                unitTablePercent(
                    columTitle: "設定1",
                    percentList: [
                        jormungand.ratioCharaKisu[0],
                        jormungand.ratioCharaGusu[0],
                        jormungand.ratioCharaHigh[0],
                        jormungand.ratioCharaOver2[0],
                        jormungand.ratioCharaOver4[0],
                        jormungand.ratioCharaOver6[0],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: [
                        jormungand.ratioCharaKisu[1],
                        jormungand.ratioCharaGusu[1],
                        jormungand.ratioCharaHigh[1],
                        jormungand.ratioCharaOver2[1],
                        jormungand.ratioCharaOver4[1],
                        jormungand.ratioCharaOver6[1],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70
                )
                unitTablePercent(
                    columTitle: "設定3",
                    percentList: [
                        jormungand.ratioCharaKisu[2],
                        jormungand.ratioCharaGusu[2],
                        jormungand.ratioCharaHigh[2],
                        jormungand.ratioCharaOver2[2],
                        jormungand.ratioCharaOver4[2],
                        jormungand.ratioCharaOver6[2],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70
                )
            }
            
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "奇数示唆",
                        "偶数示唆",
                        "高設定示唆",
                        "設定2 以上濃厚",
                        "設定4 以上濃厚",
                        "設定6 濃厚",
                    ]
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: [
                        jormungand.ratioCharaKisu[3],
                        jormungand.ratioCharaGusu[3],
                        jormungand.ratioCharaHigh[3],
                        jormungand.ratioCharaOver2[3],
                        jormungand.ratioCharaOver4[3],
                        jormungand.ratioCharaOver6[3],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: [
                        jormungand.ratioCharaKisu[4],
                        jormungand.ratioCharaGusu[4],
                        jormungand.ratioCharaHigh[4],
                        jormungand.ratioCharaOver2[4],
                        jormungand.ratioCharaOver4[4],
                        jormungand.ratioCharaOver6[4],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: [
                        jormungand.ratioCharaKisu[5],
                        jormungand.ratioCharaGusu[5],
                        jormungand.ratioCharaHigh[5],
                        jormungand.ratioCharaOver2[5],
                        jormungand.ratioCharaOver4[5],
                        jormungand.ratioCharaOver6[5],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70
                )
            }
        }
    }
}

#Preview {
    jormungandTableChara12(
        jormungand: Jormungand(),
    )
    .padding(.horizontal)
}
