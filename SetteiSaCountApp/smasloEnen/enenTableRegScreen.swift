//
//  enenTableRegScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/17.
//

import SwiftUI

struct enenTableRegScreen: View {
    @ObservedObject var enen: Enen
    let lowerBeltTextList: [String] = [
        "デフォルト\nその他",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let maxWidth: CGFloat = 45
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: self.lowerBeltTextList,
                    lineList: [2,1,1,1,1,1],
                )
                unitTablePercent(
                    columTitle: "設定1",
                    percentList: [
                        enen.ratioRegScreenDefault[0],
                        enen.ratioRegScreenHighJaku[0],
                        enen.ratioRegScreenHighKyo[0],
                        enen.ratioRegScreenOver4[0],
                        enen.ratioRegScreenOver5[0],
                        enen.ratioRegScreenOver6[0],
                    ],
                    maxWidth: self.maxWidth,
                    lineList: [2,1,1,1,1,1],
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: [
                        enen.ratioRegScreenDefault[1],
                        enen.ratioRegScreenHighJaku[1],
                        enen.ratioRegScreenHighKyo[1],
                        enen.ratioRegScreenOver4[1],
                        enen.ratioRegScreenOver5[1],
                        enen.ratioRegScreenOver6[1],
                    ],
                    maxWidth: self.maxWidth,
                    lineList: [2,1,1,1,1,1],
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: [
                        enen.ratioRegScreenDefault[2],
                        enen.ratioRegScreenHighJaku[2],
                        enen.ratioRegScreenHighKyo[2],
                        enen.ratioRegScreenOver4[2],
                        enen.ratioRegScreenOver5[2],
                        enen.ratioRegScreenOver6[2],
                    ],
                    maxWidth: self.maxWidth,
                    lineList: [2,1,1,1,1,1],
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: [
                        enen.ratioRegScreenDefault[3],
                        enen.ratioRegScreenHighJaku[3],
                        enen.ratioRegScreenHighKyo[3],
                        enen.ratioRegScreenOver4[3],
                        enen.ratioRegScreenOver5[3],
                        enen.ratioRegScreenOver6[3],
                    ],
                    maxWidth: self.maxWidth,
                    lineList: [2,1,1,1,1,1],
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: [
                        enen.ratioRegScreenDefault[4],
                        enen.ratioRegScreenHighJaku[4],
                        enen.ratioRegScreenHighKyo[4],
                        enen.ratioRegScreenOver4[4],
                        enen.ratioRegScreenOver5[4],
                        enen.ratioRegScreenOver6[4],
                    ],
                    maxWidth: self.maxWidth,
                    lineList: [2,1,1,1,1,1],
                )
            }
        }
    }
}

#Preview {
    enenTableRegScreen(
        enen: Enen(),
    )
    .padding(.horizontal)
}
