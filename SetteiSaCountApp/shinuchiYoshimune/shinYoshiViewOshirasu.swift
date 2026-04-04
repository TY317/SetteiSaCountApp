//
//  shinYoshiViewOshirasu.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import SwiftUI

struct shinYoshiViewOshirasu: View {
    @ObservedObject var shinYoshi: ShinYoshi
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            // 注意書き
            unitLabelCautionText {
                Text("・AT、CZ終了後などでPUSHボタン")
                Text("・一部の画面で設定を示唆")
            }
            
            // 参考情報）お白洲ビジョンでの示唆
            shinYoshiTableOshirasu()
                .frame(maxWidth: .infinity, alignment: .center)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shinYoshiMenuOshirasuBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shinYoshi.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("御白洲ビジョン")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    shinYoshiViewOshirasu(
        shinYoshi: ShinYoshi(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
