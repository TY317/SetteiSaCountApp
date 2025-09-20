//
//  enenTableAdoraRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/17.
//

import SwiftUI

struct enenTableAdoraRatio: View {
    @ObservedObject var enen: Enen
    let sisaList: [String] = [
        "2・5 示唆",
        "1・4・6 示唆",
        "2 以上濃厚",
        "1・4・6 濃厚",
        "4 以上濃厚",
        "5 以上濃厚",
    ]
    let maxWidth: CGFloat = 45
    
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
                        enen.ratioAdora25Sisa[0],
                        enen.ratioAdora146Sisa[0],
                        enen.ratioAdoraOver2[0],
                        enen.ratioAdora146Fix[0],
                        enen.ratioAdoraOver4[0],
                        enen.ratioAdoraOver5[0],
                    ],
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: [
                        enen.ratioAdora25Sisa[1],
                        enen.ratioAdora146Sisa[1],
                        enen.ratioAdoraOver2[1],
                        enen.ratioAdora146Fix[1],
                        enen.ratioAdoraOver4[1],
                        enen.ratioAdoraOver5[1],
                    ],
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: [
                        enen.ratioAdora25Sisa[2],
                        enen.ratioAdora146Sisa[2],
                        enen.ratioAdoraOver2[2],
                        enen.ratioAdora146Fix[2],
                        enen.ratioAdoraOver4[2],
                        enen.ratioAdoraOver5[2],
                    ],
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: [
                        enen.ratioAdora25Sisa[3],
                        enen.ratioAdora146Sisa[3],
                        enen.ratioAdoraOver2[3],
                        enen.ratioAdora146Fix[3],
                        enen.ratioAdoraOver4[3],
                        enen.ratioAdoraOver5[3],
                    ],
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: [
                        enen.ratioAdora25Sisa[4],
                        enen.ratioAdora146Sisa[4],
                        enen.ratioAdoraOver2[4],
                        enen.ratioAdora146Fix[4],
                        enen.ratioAdoraOver4[4],
                        enen.ratioAdoraOver5[4],
                    ],
                    maxWidth: self.maxWidth,
                )
            }
        }
    }
}

#Preview {
    enenTableAdoraRatio(
        enen: Enen(),
    )
    .padding(.horizontal)
}
