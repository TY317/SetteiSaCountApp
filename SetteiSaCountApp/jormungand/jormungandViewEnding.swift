//
//  jormungandViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/11.
//

import SwiftUI

struct jormungandViewEnding: View {
    @ObservedObject var jormungand: Jormungand
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            Section {
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: ["白","青","黄","緑","赤","紫","虹"],
                        maxWidth: 80,
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
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } header: {
                Text("レア役時のランプ色")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.jormungandMenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: jormungand.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    jormungandViewEnding(
        jormungand: Jormungand(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
