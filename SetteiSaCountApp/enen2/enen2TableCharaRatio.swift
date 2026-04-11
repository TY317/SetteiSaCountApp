//
//  enen2TableCharaRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/11.
//

import SwiftUI

struct enen2TableCharaRatio: View {
    @ObservedObject var enen2: Enen2
    let sisaList: [String] = [
        "デフォルト",
        "奇数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定1 否定",
        "設定2 否定",
        "設定3 否定",
        "設定4 否定",
        "設定5 否定",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: self.sisaList,
                )
                unitTablePercent(
                    columTitle: "設定1",
                    percentList: [
                        enen2.ratioCharaDefault[0],
                        enen2.ratioCharaKisu[0],
                        enen2.ratioCharaGusu[0],
                        enen2.ratioCharaHighJaku[0],
                        enen2.ratioCharaHighKyo[0],
                        enen2.ratioCharaNegate1[0],
                        enen2.ratioCharaNegate2[0],
                        enen2.ratioCharaNegate3[0],
                        enen2.ratioCharaNegate4[0],
                        enen2.ratioCharaNegate5[0],
                        enen2.ratioCharaOver4[0],
                        enen2.ratioCharaOver5[0],
                        enen2.ratioCharaOver6[0],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70,
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: [
                        enen2.ratioCharaDefault[1],
                        enen2.ratioCharaKisu[1],
                        enen2.ratioCharaGusu[1],
                        enen2.ratioCharaHighJaku[1],
                        enen2.ratioCharaHighKyo[1],
                        enen2.ratioCharaNegate1[1],
                        enen2.ratioCharaNegate2[1],
                        enen2.ratioCharaNegate3[1],
                        enen2.ratioCharaNegate4[1],
                        enen2.ratioCharaNegate5[1],
                        enen2.ratioCharaOver4[1],
                        enen2.ratioCharaOver5[1],
                        enen2.ratioCharaOver6[1],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70,
                )
                unitTablePercent(
                    columTitle: "設定3",
                    percentList: [
                        enen2.ratioCharaDefault[2],
                        enen2.ratioCharaKisu[2],
                        enen2.ratioCharaGusu[2],
                        enen2.ratioCharaHighJaku[2],
                        enen2.ratioCharaHighKyo[2],
                        enen2.ratioCharaNegate1[2],
                        enen2.ratioCharaNegate2[2],
                        enen2.ratioCharaNegate3[2],
                        enen2.ratioCharaNegate4[2],
                        enen2.ratioCharaNegate5[2],
                        enen2.ratioCharaOver4[2],
                        enen2.ratioCharaOver5[2],
                        enen2.ratioCharaOver6[2],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70,
                )
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: self.sisaList,
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: [
                        enen2.ratioCharaDefault[3],
                        enen2.ratioCharaKisu[3],
                        enen2.ratioCharaGusu[3],
                        enen2.ratioCharaHighJaku[3],
                        enen2.ratioCharaHighKyo[3],
                        enen2.ratioCharaNegate1[3],
                        enen2.ratioCharaNegate2[3],
                        enen2.ratioCharaNegate3[3],
                        enen2.ratioCharaNegate4[3],
                        enen2.ratioCharaNegate5[3],
                        enen2.ratioCharaOver4[3],
                        enen2.ratioCharaOver5[3],
                        enen2.ratioCharaOver6[3],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70,
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: [
                        enen2.ratioCharaDefault[4],
                        enen2.ratioCharaKisu[4],
                        enen2.ratioCharaGusu[4],
                        enen2.ratioCharaHighJaku[4],
                        enen2.ratioCharaHighKyo[4],
                        enen2.ratioCharaNegate1[4],
                        enen2.ratioCharaNegate2[4],
                        enen2.ratioCharaNegate3[4],
                        enen2.ratioCharaNegate4[4],
                        enen2.ratioCharaNegate5[4],
                        enen2.ratioCharaOver4[4],
                        enen2.ratioCharaOver5[4],
                        enen2.ratioCharaOver6[4],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70,
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: [
                        enen2.ratioCharaDefault[5],
                        enen2.ratioCharaKisu[5],
                        enen2.ratioCharaGusu[5],
                        enen2.ratioCharaHighJaku[5],
                        enen2.ratioCharaHighKyo[5],
                        enen2.ratioCharaNegate1[5],
                        enen2.ratioCharaNegate2[5],
                        enen2.ratioCharaNegate3[5],
                        enen2.ratioCharaNegate4[5],
                        enen2.ratioCharaNegate5[5],
                        enen2.ratioCharaOver4[5],
                        enen2.ratioCharaOver5[5],
                        enen2.ratioCharaOver6[5],
                    ],
                    numberofDicimal: 1,
                    maxWidth: 70,
                )
            }
        }
    }
}

#Preview {
    enen2TableCharaRatio(
        enen2: Enen2(),
    )
    .padding(.horizontal)
}
