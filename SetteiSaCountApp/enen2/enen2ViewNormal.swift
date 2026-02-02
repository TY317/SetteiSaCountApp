//
//  enen2ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/11.
//

import SwiftUI

struct enen2ViewNormal: View {
    @ObservedObject var enen2: Enen2
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            // ----- レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    enen2TableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            // ---- 通常時のモード
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "モードについて") {
                    enen2TableMode()
                }
            } header: {
                Text("通常時モード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.enen2MenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    enen2ViewNormal(
        enen2: Enen2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
