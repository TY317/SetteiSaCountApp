//
//  neoplaViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/16.
//

import SwiftUI

struct neoplaViewScreen: View {
    @ObservedObject var neopla: Neopla
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            // 終了画面
            Section {
                VStack(alignment: .leading) {
                    Text("・ボーナス終了後に左リール上にキャラ等が表示される場合あり")
                    Text("・キャラによってモードや設定を示唆！？")
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
                unitLinkButtonViewBuilder(sheetTitle: "モード示唆演出") {
                    neoplaTableModeSisa()
                }
            } header: {
                Text("終了画面")
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
        .navigationTitle("ボーナス終了画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    neoplaViewScreen(
        neopla: Neopla(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
