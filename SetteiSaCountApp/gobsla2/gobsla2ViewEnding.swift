//
//  gobsla2ViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/04.
//

import SwiftUI

struct gobsla2ViewEnding: View {
    @ObservedObject var gobsla2: Gobsla2
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            // ---- レア役時のボイス
            Section {
                // 注意書き
                unitLabelCautionText {
                    Text("レア役時にPUSHボタン押すとボイス発生")
                }
                
                // 示唆
                gobsla2TableEnding()
                    .frame(maxWidth: .infinity, alignment: .center)
            } header: {
                Text("レア役時のボイス")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.gobsla2MenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: gobsla2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    gobsla2ViewEnding(
        gobsla2: Gobsla2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
