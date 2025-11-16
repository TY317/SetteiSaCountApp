//
//  neoplaViewDuringBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/16.
//

import SwiftUI

struct neoplaViewDuringBonus: View {
    @ObservedObject var neopla: Neopla
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            // ミニゲーム
            Section {
                VStack(alignment: .leading) {
                    Text("・リプレイナビ発生時は下段プラネット狙い")
                    Text("・中or右を最初に狙い、残りのリールを狙う")
                    Text("・成功時の演出で次回モードを示唆！？")
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
                unitLinkButtonViewBuilder(sheetTitle: "モード示唆演出") {
                    neoplaTableModeSisa()
                }
            } header: {
                Text("ミニゲーム")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: neopla.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ボーナス中")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    neoplaViewDuringBonus(
        neopla: Neopla(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
