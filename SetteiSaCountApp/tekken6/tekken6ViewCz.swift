//
//  tekken6ViewCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/04.
//

import SwiftUI

struct tekken6ViewCz: View {
    @ObservedObject var tekken6: Tekken6
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            // ---- 終了後のモード
            Section {
                // 振分け
                tekken6TableAfterCzMode()
                    .frame(maxWidth: .infinity, alignment: .center)
                // モード示唆
                unitLinkButtonViewBuilder(sheetTitle: "CZモード示唆") {
                    tekken6TableStage()
                }
            } header: {
                Text("終了後のCZモード振分け")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.tekken6MenuCzBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tekken6.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("CZ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    tekken6ViewCz(
        tekken6: Tekken6(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
