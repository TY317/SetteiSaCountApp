//
//  enenTableCharaRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/17.
//

import SwiftUI

struct enenTableCharaRatio: View {
    @ObservedObject var enen: Enen
    let sisaList: [String] = [
        "デフォルト",
        "1・4・6 示唆",
        "2・5 示唆",
        "1 否定",
        "2 否定",
        "4 否定",
        "5 否定",
        "4 以上濃厚",
        "5 以上濃厚",
        "6 濃厚",
    ]
    let maxWidth: CGFloat = 50
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: self.sisaList
                )
                unitTablePercent(
                    columTitle: "設定1",
                    percentList: [
                        enen.ratioCharaDefault[0],
                        enen.ratioChara146Sisa[0],
                        enen.ratioChara25Sisa[0],
                        enen.ratioCharaNegate1[0],
                        enen.ratioCharaNegate2[0],
                        enen.ratioCharaNegate4[0],
                        enen.ratioCharaNegate5[0],
                        enen.ratioCharaOver4[0],
                        enen.ratioCharaOver5[0],
                        enen.ratioCharaOver6[0],
                    ],
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: [
                        enen.ratioCharaDefault[1],
                        enen.ratioChara146Sisa[1],
                        enen.ratioChara25Sisa[1],
                        enen.ratioCharaNegate1[1],
                        enen.ratioCharaNegate2[1],
                        enen.ratioCharaNegate4[1],
                        enen.ratioCharaNegate5[1],
                        enen.ratioCharaOver4[1],
                        enen.ratioCharaOver5[1],
                        enen.ratioCharaOver6[1],
                    ],
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: [
                        enen.ratioCharaDefault[2],
                        enen.ratioChara146Sisa[2],
                        enen.ratioChara25Sisa[2],
                        enen.ratioCharaNegate1[2],
                        enen.ratioCharaNegate2[2],
                        enen.ratioCharaNegate4[2],
                        enen.ratioCharaNegate5[2],
                        enen.ratioCharaOver4[2],
                        enen.ratioCharaOver5[2],
                        enen.ratioCharaOver6[2],
                    ],
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: [
                        enen.ratioCharaDefault[3],
                        enen.ratioChara146Sisa[3],
                        enen.ratioChara25Sisa[3],
                        enen.ratioCharaNegate1[3],
                        enen.ratioCharaNegate2[3],
                        enen.ratioCharaNegate4[3],
                        enen.ratioCharaNegate5[3],
                        enen.ratioCharaOver4[3],
                        enen.ratioCharaOver5[3],
                        enen.ratioCharaOver6[3],
                    ],
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: [
                        enen.ratioCharaDefault[4],
                        enen.ratioChara146Sisa[4],
                        enen.ratioChara25Sisa[4],
                        enen.ratioCharaNegate1[4],
                        enen.ratioCharaNegate2[4],
                        enen.ratioCharaNegate4[4],
                        enen.ratioCharaNegate5[4],
                        enen.ratioCharaOver4[4],
                        enen.ratioCharaOver5[4],
                        enen.ratioCharaOver6[4],
                    ],
                    maxWidth: self.maxWidth,
                )
            }
//            HStack(spacing: 0) {
//                unitTableString(
//                    columTitle: "",
//                    stringList: self.sisaList
//                )
//                unitTablePercent(
//                    columTitle: "設定5",
//                    percentList: [
//                        enen.ratioCharaDefault[3],
//                        enen.ratioChara146Sisa[3],
//                        enen.ratioChara25Sisa[3],
//                        enen.ratioCharaNegate1[3],
//                        enen.ratioCharaNegate2[3],
//                        enen.ratioCharaNegate4[3],
//                        enen.ratioCharaNegate5[3],
//                        enen.ratioCharaOver4[3],
//                        enen.ratioCharaOver5[3],
//                        enen.ratioCharaOver6[3],
//                    ],
//                    maxWidth: self.maxWidth,
//                )
//                unitTablePercent(
//                    columTitle: "設定6",
//                    percentList: [
//                        enen.ratioCharaDefault[4],
//                        enen.ratioChara146Sisa[4],
//                        enen.ratioChara25Sisa[4],
//                        enen.ratioCharaNegate1[4],
//                        enen.ratioCharaNegate2[4],
//                        enen.ratioCharaNegate4[4],
//                        enen.ratioCharaNegate5[4],
//                        enen.ratioCharaOver4[4],
//                        enen.ratioCharaOver5[4],
//                        enen.ratioCharaOver6[4],
//                    ],
//                    maxWidth: self.maxWidth,
//                )
//            }
        }
    }
}

#Preview {
    enenTableCharaRatio(
        enen: Enen(),
    )
    .padding(.horizontal)
}
