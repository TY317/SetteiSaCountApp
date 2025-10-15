//
//  azurLaneTableKagaRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/07.
//

import SwiftUI

struct azurLaneTableKagaRatio: View {
    @ObservedObject var azurLane: AzurLane
    let sisaList: [String] = [
        "デフォ 奇数示唆 弱",
        "デフォ 偶数示唆 弱",
        "奇数示唆",
        "偶数示唆",
        "設定4・6示唆",
        "設定5・6示唆",
    ]
    let maxWidth: CGFloat = 70
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
                        azurLane.ratioKagaDefaultKisu[0],
                        azurLane.ratioKagaDefaultGusu[0],
                        azurLane.ratioKagaKisu[0],
                        azurLane.ratioKagaGusu[0],
                        azurLane.ratioKaga46Sisa[0],
                        azurLane.ratioKaga56Sisa[0],
                    ],
                    numberofDicimal: 1,
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: [
                        azurLane.ratioKagaDefaultKisu[1],
                        azurLane.ratioKagaDefaultGusu[1],
                        azurLane.ratioKagaKisu[1],
                        azurLane.ratioKagaGusu[1],
                        azurLane.ratioKaga46Sisa[1],
                        azurLane.ratioKaga56Sisa[1],
                    ],
                    numberofDicimal: 1,
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定3",
                    percentList: [
                        azurLane.ratioKagaDefaultKisu[2],
                        azurLane.ratioKagaDefaultGusu[2],
                        azurLane.ratioKagaKisu[2],
                        azurLane.ratioKagaGusu[2],
                        azurLane.ratioKaga46Sisa[2],
                        azurLane.ratioKaga56Sisa[2],
                    ],
                    numberofDicimal: 1,
                    maxWidth: self.maxWidth,
                )
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: self.sisaList
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: [
                        azurLane.ratioKagaDefaultKisu[3],
                        azurLane.ratioKagaDefaultGusu[3],
                        azurLane.ratioKagaKisu[3],
                        azurLane.ratioKagaGusu[3],
                        azurLane.ratioKaga46Sisa[3],
                        azurLane.ratioKaga56Sisa[3],
                    ],
                    numberofDicimal: 1,
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: [
                        azurLane.ratioKagaDefaultKisu[4],
                        azurLane.ratioKagaDefaultGusu[4],
                        azurLane.ratioKagaKisu[4],
                        azurLane.ratioKagaGusu[4],
                        azurLane.ratioKaga46Sisa[4],
                        azurLane.ratioKaga56Sisa[4],
                    ],
                    numberofDicimal: 1,
                    maxWidth: self.maxWidth,
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: [
                        azurLane.ratioKagaDefaultKisu[5],
                        azurLane.ratioKagaDefaultGusu[5],
                        azurLane.ratioKagaKisu[5],
                        azurLane.ratioKagaGusu[5],
                        azurLane.ratioKaga46Sisa[5],
                        azurLane.ratioKaga56Sisa[5],
                    ],
                    numberofDicimal: 1,
                    maxWidth: self.maxWidth,
                )
            }
        }
    }
}

#Preview {
    azurLaneTableKagaRatio(
        azurLane: AzurLane(),
    )
    .padding(.horizontal)
}
