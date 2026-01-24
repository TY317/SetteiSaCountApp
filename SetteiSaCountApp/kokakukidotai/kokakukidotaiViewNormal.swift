//
//  kokakukidotaiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/13.
//

import SwiftUI

struct kokakukidotaiViewNormal: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    kokakukidotaiTableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kokakukidotaiMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kokakukidotai.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    kokakukidotaiViewNormal(
        kokakukidotai: Kokakukidotai(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
