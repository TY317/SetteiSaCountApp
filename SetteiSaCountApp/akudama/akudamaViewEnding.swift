//
//  akudamaViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/07.
//

import SwiftUI

struct akudamaViewEnding: View {
    @ObservedObject var akudama: Akudama
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("・アクダマ目停止時に筐体左右のターゲットランプ色で設定を示唆")
                Text("・アクダマ目が連続して停止するほど示唆の精度がアップする")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.akudamaMenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: akudama.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    akudamaViewEnding(
        akudama: Akudama(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
