//
//  vvv2ViewAtScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/10.
//

import SwiftUI

struct vvv2ViewAtScreen: View {
    @ObservedObject var vvv2: Vvv2
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            Section {
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // パターン1
                        unitScreenOnlyDisplay(
                            image: Image("vvv2Screen1"),
                            upperBeltText: "写真なし",
                            lowerBeltText: "デフォルト",
                        )
                        // パターン2
                        unitScreenOnlyDisplay(
                            image: Image("vvv2Screen4"),
                            upperBeltText: "写真あり",
                            lowerBeltText: "設定6 濃厚",
                        )
                    }
                }
                .frame(height: 120)
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.vvv2MenuAtScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vvv2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ラッシュ終了画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    vvv2ViewAtScreen(
        vvv2: Vvv2(),
    )
    .environmentObject(commonVar())
}
