//
//  symphoViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/19.
//

import SwiftUI

struct symphoViewEnding: View {
    var body: some View {
//        NavigationView {
            List {
                Text("エンディング中　レア役成立時のリール上部のランプ色で設定を示唆")
//                Image("symphoEnding1")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
                HStack(spacing: 0) {
                    Spacer()
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "白",
                            "青",
                            "黄",
                            "緑",
                            "赤",
                            "紫",
                            "虹",
                        ],
                        maxWidth: 100,
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "デフォルト",
                            "奇数示唆",
                            "偶数示唆",
                            "高設定示唆",
                            "設定2 以上濃厚",
                            "設定4 以上濃厚",
                            "設定6 濃厚",
                        ],
                        maxWidth: 200,
                    )
                    Spacer()
                }
                VStack {
                    Text("[🍒・🍉時の振り分け]")
                        .font(.title2)
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "白",
                                "青",
                                "黄",
                                "緑",
                                "赤",
                                "紫",
                                "虹",
                            ],
                            contentFont: .body,
                        )
                        unitTablePercent(
                            columTitle: "設定1",
                            percentList: [49,22,16,13,0,0,0],
                            titleFont: .body,
                            contentFont: .body,
                        )
                        unitTablePercent(
                            columTitle: "設定2",
                            percentList: [44,16,22,15,3,0,0],
                            titleFont: .body,
                            contentFont: .body,
                        )
                        unitTablePercent(
                            columTitle: "設定4",
                            percentList: [42,16,22,16,3,1,0],
                            titleFont: .body,
                            contentFont: .body,
                        )
                        unitTablePercent(
                            columTitle: "設定5",
                            percentList: [40,22,16,18,3,1,0],
                            titleFont: .body,
                            contentFont: .body,
                        )
                        unitTablePercent(
                            columTitle: "設定6",
                            percentList: [37,16,22,20,3,1,1],
                            titleFont: .body,
                            contentFont: .body,
                        )
                    }
                }
//                Image("symphoEnding2")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
                VStack {
                    Text("[ギアフラグ時の振り分け]")
                        .font(.title2)
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "白",
                                "青",
                                "黄",
                                "緑",
                                "赤",
                                "紫",
                                "虹",
                            ],
                            contentFont: .body,
                        )
                        unitTablePercent(
                            columTitle: "設定1",
                            percentList: [49,22,16,13,0,0,0],
                            titleFont: .body,
                            contentFont: .body,
                        )
                        unitTablePercent(
                            columTitle: "設定2",
                            percentList: [43,15,22,15,5,0,0],
                            titleFont: .body,
                            contentFont: .body,
                        )
                        unitTablePercent(
                            columTitle: "設定4",
                            percentList: [39,16,22,16,5,2,0],
                            titleFont: .body,
                            contentFont: .body,
                        )
                        unitTablePercent(
                            columTitle: "設定5",
                            percentList: [37,22,16,18,5,2,0],
                            titleFont: .body,
                            contentFont: .body,
                        )
                        unitTablePercent(
                            columTitle: "設定6",
                            percentList: [33,16,22,20,5,2,2],
                            titleFont: .body,
                            contentFont: .body,
                        )
                    }
                }
//                Image("symphoEnding3")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "シンフォギア 正義の歌",
                screenClass: screenClass
            )
        }
            .navigationTitle("エンディング中の示唆")
            .navigationBarTitleDisplayMode(.inline)
//        }
//        .navigationTitle("エンディング中の示唆")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    symphoViewEnding()
}
