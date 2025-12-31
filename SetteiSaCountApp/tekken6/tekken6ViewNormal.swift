//
//  tekken6ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/31.
//

import SwiftUI

struct tekken6ViewNormal: View {
    @ObservedObject var tekken6: Tekken6
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            // ----- レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    tekken6TableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            // ---- モード
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    tekkenTableMode()
                }
            } header: {
                Text("通常時のモード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.tekken6MenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tekken6.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    tekken6ViewNormal(
        tekken6: Tekken6(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
