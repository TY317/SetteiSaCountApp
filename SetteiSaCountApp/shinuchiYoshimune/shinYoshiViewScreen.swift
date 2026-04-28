//
//  shinYoshiViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import SwiftUI

struct shinYoshiViewScreen: View {
    @ObservedObject var shinYoshi: ShinYoshi
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // 参考情報）終了画面示唆
            shinYoshiTableScreen()
                .frame(maxWidth: .infinity, alignment: .center)
                .popoverTip(tipVer3241ShinYoshiScreen())
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shinYoshiMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shinYoshi.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    shinYoshiViewScreen(
        shinYoshi: ShinYoshi(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
