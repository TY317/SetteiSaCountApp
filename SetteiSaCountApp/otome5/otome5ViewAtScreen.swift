//
//  otome5ViewAtScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/13.
//

import SwiftUI

struct otome5ViewAtScreen: View {
    @ObservedObject var otome5: Otome5
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            // 説明書き
            VStack(alignment: .leading) {
                Text("・基本はモード示唆")
                Text("・一部法則矛盾で設定示唆")
            }
            
            // 終了画面リスト
            otome5TableAtScreen()
                .frame(maxWidth: .infinity, alignment: .center)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.otome5MenuAtScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: otome5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    otome5ViewAtScreen(
        otome5: Otome5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
