//
//  azurLaneTableScreenRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/10.
//

import SwiftUI

struct azurLaneTableScreenRatio: View {
    @ObservedObject var azurLane: AzurLane
    let lowerBeltTextList: [String] = [
        "デフォ 奇数示唆 弱",
        "デフォ 奇数示唆 弱",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let maxWidth: CGFloat = 70
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: self.lowerBeltTextList
                )
                unitTablePercent(
                    columTitle: "設定1",
                    percentList: [
                        azurLane.ratioScreenDefaultKisu[0],
                        azurLane.ratioScreenDefaultGusu[0],
                        azurLane.ratioScreenHighJaku[0],
                        azurLane.ratioScreenHighKyo[0],
                        azurLane.ratioScreenOver2[0],
                        azurLane.ratioScreenOver4[0],
                        azurLane.ratioScreenOver6[0],
                    ],
                    numberofDicimal: 1,
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: [
                        azurLane.ratioScreenDefaultKisu[1],
                        azurLane.ratioScreenDefaultGusu[1],
                        azurLane.ratioScreenHighJaku[1],
                        azurLane.ratioScreenHighKyo[1],
                        azurLane.ratioScreenOver2[1],
                        azurLane.ratioScreenOver4[1],
                        azurLane.ratioScreenOver6[1],
                    ],
                    numberofDicimal: 1,
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定3",
                    percentList: [
                        azurLane.ratioScreenDefaultKisu[2],
                        azurLane.ratioScreenDefaultGusu[2],
                        azurLane.ratioScreenHighJaku[2],
                        azurLane.ratioScreenHighKyo[2],
                        azurLane.ratioScreenOver2[2],
                        azurLane.ratioScreenOver4[2],
                        azurLane.ratioScreenOver6[2],
                    ],
                    numberofDicimal: 1,
                    maxWidth: self.maxWidth,
                )
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: self.lowerBeltTextList
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: [
                        azurLane.ratioScreenDefaultKisu[3],
                        azurLane.ratioScreenDefaultGusu[3],
                        azurLane.ratioScreenHighJaku[3],
                        azurLane.ratioScreenHighKyo[3],
                        azurLane.ratioScreenOver2[3],
                        azurLane.ratioScreenOver4[3],
                        azurLane.ratioScreenOver6[3],
                    ],
                    numberofDicimal: 1,
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: [
                        azurLane.ratioScreenDefaultKisu[4],
                        azurLane.ratioScreenDefaultGusu[4],
                        azurLane.ratioScreenHighJaku[4],
                        azurLane.ratioScreenHighKyo[4],
                        azurLane.ratioScreenOver2[4],
                        azurLane.ratioScreenOver4[4],
                        azurLane.ratioScreenOver6[4],
                    ],
                    numberofDicimal: 1,
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: [
                        azurLane.ratioScreenDefaultKisu[5],
                        azurLane.ratioScreenDefaultGusu[5],
                        azurLane.ratioScreenHighJaku[5],
                        azurLane.ratioScreenHighKyo[5],
                        azurLane.ratioScreenOver2[5],
                        azurLane.ratioScreenOver4[5],
                        azurLane.ratioScreenOver6[5],
                    ],
                    numberofDicimal: 1,
                    maxWidth: self.maxWidth,
                )
            }
        }
    }
}

#Preview {
    azurLaneTableScreenRatio(
        azurLane: AzurLane(),
    )
}
