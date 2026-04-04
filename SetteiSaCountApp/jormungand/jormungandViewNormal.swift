//
//  jormungandViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import SwiftUI

struct jormungandViewNormal: View {
    @ObservedObject var jormungand: Jormungand
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // ---- レア役停止系
            Section {
                // 参考情報）レア役停止形
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    jormungandTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.jormungandMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: jormungand.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    jormungandViewNormal(
        jormungand: Jormungand(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
