//
//  symphoViewGearv.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/19.
//

import SwiftUI

struct symphoViewGearv: View {
    var body: some View {
//        NavigationView {
            List {
                Text("クリスのギアVアタックで赤PUSH連打中の枚数表示で設定示唆パターンあり")
//                Image("symphoGearV")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "表示回数",
                        stringList: [
                            "20",
                            "7",
                            "6",
                        ],
                        maxWidth: 100,
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "設定2 以上濃厚",
                            "設定4 以上濃厚",
                            "設定6 濃厚",
                        ],
                        maxWidth: 200,
                    )
                }
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "シンフォギア 正義の歌",
                screenClass: screenClass
            )
        }
            .navigationTitle("ギアVアタック中の示唆")
            .navigationBarTitleDisplayMode(.inline)
//        }
//        .navigationTitle("ギアVアタック中の示唆")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    symphoViewGearv()
}
