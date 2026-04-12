//
//  shinYoshiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/29.
//

import SwiftUI

struct shinYoshiViewNormal: View {
    @ObservedObject var shinYoshi: ShinYoshi
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            // ---- レア役停止系
            Section {
                // 参考情報）レア役停止形
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    shinYoshiTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
            
            // ---- CZモード
            Section {
                // CZモード
                unitLinkButtonViewBuilder(sheetTitle: "CZモードについて") {
                    shinYoshiTableMode()
                }
            } header: {
                Text("CZモード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shinYoshiMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shinYoshi.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    shinYoshiViewNormal(
        shinYoshi: ShinYoshi(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
