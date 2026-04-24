//
//  jormungandTableChara3.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/23.
//

import SwiftUI

struct jormungandTableChara3: View {
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
                        jormungand.ratioChara3Kisu[0],
                        jormungand.ratioChara3Gusu[0],
                        jormungand.ratioChara3High[0],
                        jormungand.ratioChara3Over2[0],
                        jormungand.ratioChara3Over4[0],
                        jormungand.ratioChara3Over6[0],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: [
                        jormungand.ratioChara3Kisu[1],
                        jormungand.ratioChara3Gusu[1],
                        jormungand.ratioChara3High[1],
                        jormungand.ratioChara3Over2[1],
                        jormungand.ratioChara3Over4[1],
                        jormungand.ratioChara3Over6[1],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70
                )
                unitTablePercent(
                    columTitle: "設定3",
                    percentList: [
                        jormungand.ratioChara3Kisu[2],
                        jormungand.ratioChara3Gusu[2],
                        jormungand.ratioChara3High[2],
                        jormungand.ratioChara3Over2[2],
                        jormungand.ratioChara3Over4[2],
                        jormungand.ratioChara3Over6[2],
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
                        jormungand.ratioChara3Kisu[3],
                        jormungand.ratioChara3Gusu[3],
                        jormungand.ratioChara3High[3],
                        jormungand.ratioChara3Over2[3],
                        jormungand.ratioChara3Over4[3],
                        jormungand.ratioChara3Over6[3],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: [
                        jormungand.ratioChara3Kisu[4],
                        jormungand.ratioChara3Gusu[4],
                        jormungand.ratioChara3High[4],
                        jormungand.ratioChara3Over2[4],
                        jormungand.ratioChara3Over4[4],
                        jormungand.ratioChara3Over6[4],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: [
                        jormungand.ratioChara3Kisu[5],
                        jormungand.ratioChara3Gusu[5],
                        jormungand.ratioChara3High[5],
                        jormungand.ratioChara3Over2[5],
                        jormungand.ratioChara3Over4[5],
                        jormungand.ratioChara3Over6[5],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70
                )
            }
        }
    }
}

#Preview {
    jormungandTableChara3(
        jormungand: Jormungand(),
    )
}
