//
//  symphoTableScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/15.
//

import SwiftUI

struct symphoTableScreen: View {
    let maxWidth: CGFloat = 50
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "デフォルト",
                        "奇数示唆",
                        "偶数示唆",
                        "高設定示唆 弱",
                        "高設定示唆 強",
                        "設定1 否定",
                        "設定2 否定",
                        "設定4 否定\n高設定示唆",
                        "偶数濃厚",
                        "設定4 以上濃厚",
                        "設定6 濃厚",
                    ],
                    maxWidth: 150,
                    lineList: [1,1,1,1,1,1,1,2,1,1,1],
                    contentFont: .body,
                )
                unitTablePercent(
                    columTitle: "設定1",
                    percentList: [27,22,18,23,5,0,4,1,0,0,0],
                    maxWidth: self.maxWidth,
                    lineList: [1,1,1,1,1,1,1,2,1,1,1],
                    titleFont: .body,
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: [27,14,20,24,6,6,0,1,2,0,0],
                    maxWidth: self.maxWidth,
                    lineList: [1,1,1,1,1,1,1,2,1,1,1],
                    titleFont: .body,
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: [27,12,17,25,8,3,2,0,2,4,0],
                    maxWidth: self.maxWidth,
                    lineList: [1,1,1,1,1,1,1,2,1,1,1],
                    titleFont: .body,
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: [26,17,11,26,9,2,2,4,0,3,0],
                    maxWidth: self.maxWidth,
                    lineList: [1,1,1,1,1,1,1,2,1,1,1],
                    titleFont: .body,
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: [26,14,17,26,8,1,2,3,1,1,1],
                    maxWidth: self.maxWidth,
                    lineList: [1,1,1,1,1,1,1,2,1,1,1],
                    titleFont: .body,
                )
            }
        }
    }
}

#Preview {
    symphoTableScreen()
        .padding(.horizontal)
}
