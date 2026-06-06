//
//  otome5ViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/04.
//

import SwiftUI

struct otome5ViewEnding: View {
    @ObservedObject var otome5: Otome5
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // ---- キャラ紹介
            Section {
                Text("キャラ紹介の左のキャラで設定を示唆")
            } header: {
                Text("キャラ紹介")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.otome5MenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: otome5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    otome5ViewEnding(
        otome5: Otome5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
