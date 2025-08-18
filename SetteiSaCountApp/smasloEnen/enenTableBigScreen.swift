//
//  enenTableBigScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/17.
//

import SwiftUI

struct enenTableBigScreen: View {
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
                        enen.ratioBigScreenDefault[0],
                        enen.ratioBigScreenHighJaku[0],
                        enen.ratioBigScreenHighKyo[0],
                        enen.ratioBigScreenOver4[0],
                        enen.ratioBigScreenOver5[0],
                        enen.ratioBigScreenOver6[0],
                    ],
                    maxWidth: self.maxWidth,
                    lineList: [2,1,1,1,1,1],
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: [
                        enen.ratioBigScreenDefault[1],
                        enen.ratioBigScreenHighJaku[1],
                        enen.ratioBigScreenHighKyo[1],
                        enen.ratioBigScreenOver4[1],
                        enen.ratioBigScreenOver5[1],
                        enen.ratioBigScreenOver6[1],
                    ],
                    maxWidth: self.maxWidth,
                    lineList: [2,1,1,1,1,1],
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: [
                        enen.ratioBigScreenDefault[2],
                        enen.ratioBigScreenHighJaku[2],
                        enen.ratioBigScreenHighKyo[2],
                        enen.ratioBigScreenOver4[2],
                        enen.ratioBigScreenOver5[2],
                        enen.ratioBigScreenOver6[2],
                    ],
                    maxWidth: self.maxWidth,
                    lineList: [2,1,1,1,1,1],
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: [
                        enen.ratioBigScreenDefault[3],
                        enen.ratioBigScreenHighJaku[3],
                        enen.ratioBigScreenHighKyo[3],
                        enen.ratioBigScreenOver4[3],
                        enen.ratioBigScreenOver5[3],
                        enen.ratioBigScreenOver6[3],
                    ],
                    maxWidth: self.maxWidth,
                    lineList: [2,1,1,1,1,1],
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: [
                        enen.ratioBigScreenDefault[4],
                        enen.ratioBigScreenHighJaku[4],
                        enen.ratioBigScreenHighKyo[4],
                        enen.ratioBigScreenOver4[4],
                        enen.ratioBigScreenOver5[4],
                        enen.ratioBigScreenOver6[4],
                    ],
                    maxWidth: self.maxWidth,
                    lineList: [2,1,1,1,1,1],
                )
            }
        }
    }
}

#Preview {
    enenTableBigScreen(
        enen: Enen(),
    )
    .padding(.horizontal)
}
