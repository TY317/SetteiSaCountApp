//
//  kaguyaTableScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/14.
//

import SwiftUI

struct kaguyaTableScreen: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "デフォルト",
                    "設定2 以上示唆",
                    "設定2 以上濃厚",
                    "引き戻し期待度60%",
                    "1G連or引き戻し濃厚",
                    "1G連or引き戻し\n(否定で4以上濃厚)",
                    "設定4 以上濃厚",
                    "設定4 以上濃厚\n引き戻し期待度70%",
                    "設定6 濃厚",
                ],
                maxWidth: 200,
                lineList: [1,1,1,1,1,2,1,2,1],
            )
            unitTablePercent(
                columTitle: "設定1",
                percentList: [96,1,0,1,1,1,0,0,0],
                maxWidth: 70,
                lineList: [1,1,1,1,1,2,1,2,1],
            )
            unitTablePercent(
                columTitle: "設定2",
                percentList: [92,2,3,1,1,1,0,0,0],
                maxWidth: 70,
                lineList: [1,1,1,1,1,2,1,2,1],
            )
            unitTablePercent(
                columTitle: "設定3",
                percentList: [92,2,3,1,1,1,0,0,0],
                maxWidth: 70,
                lineList: [1,1,1,1,1,2,1,2,1],
            )
//            unitTablePercent(
//                columTitle: "設定4",
//                percentList: [90,2,3,1,1,1,1,1,0],
//                lineList: [1,1,1,1,1,2,1,2,1],
//            )
//            unitTablePercent(
//                columTitle: "設定5",
//                percentList: [90,2,3,1,1,1,1,1,0],
//                lineList: [1,1,1,1,1,2,1,2,1],
//            )
//            unitTablePercent(
//                columTitle: "設定6",
//                percentList: [89,2,3,1,1,1,1,1,1],
//                lineList: [1,1,1,1,1,2,1,2,1],
//            )
        }
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "デフォルト",
                    "設定2 以上示唆",
                    "設定2 以上濃厚",
                    "引き戻し期待度60%",
                    "1G連or引き戻し濃厚",
                    "1G連or引き戻し\n(否定で4以上濃厚)",
                    "設定4 以上濃厚",
                    "設定4 以上濃厚\n引き戻し期待度70%",
                    "設定6 濃厚",
                ],
                maxWidth: 200,
                lineList: [1,1,1,1,1,2,1,2,1],
            )
//            unitTablePercent(
//                columTitle: "設定1",
//                percentList: [96,1,0,1,1,1,0,0,0],
//                lineList: [1,1,1,1,1,2,1,2,1],
//            )
//            unitTablePercent(
//                columTitle: "設定2",
//                percentList: [92,2,3,1,1,1,0,0,0],
//                lineList: [1,1,1,1,1,2,1,2,1],
//            )
//            unitTablePercent(
//                columTitle: "設定3",
//                percentList: [92,2,3,1,1,1,0,0,0],
//                lineList: [1,1,1,1,1,2,1,2,1],
//            )
            unitTablePercent(
                columTitle: "設定4",
                percentList: [90,2,3,1,1,1,1,1,0],
                maxWidth: 70,
                lineList: [1,1,1,1,1,2,1,2,1],
            )
            unitTablePercent(
                columTitle: "設定5",
                percentList: [90,2,3,1,1,1,1,1,0],
                maxWidth: 70,
                lineList: [1,1,1,1,1,2,1,2,1],
            )
            unitTablePercent(
                columTitle: "設定6",
                percentList: [89,2,3,1,1,1,1,1,1],
                maxWidth: 70,
                lineList: [1,1,1,1,1,2,1,2,1],
            )
        }
    }
}

#Preview {
    kaguyaTableScreen()
        .padding(.horizontal)
}
