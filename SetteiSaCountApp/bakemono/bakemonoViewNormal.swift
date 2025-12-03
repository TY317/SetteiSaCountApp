//
//  bakemonoViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/30.
//

import SwiftUI

struct bakemonoViewNormal: View {
    @ObservedObject var bakemono: Bakemono
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // //// レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    bakemonoTableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.bakemonoMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bakemono.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    bakemonoViewNormal(
        bakemono: Bakemono(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
