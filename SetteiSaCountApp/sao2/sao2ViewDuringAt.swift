//
//  sao2ViewDuringAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/07.
//

import SwiftUI

struct sao2ViewDuringAt: View {
    @ObservedObject var sao2: Sao2
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // ---- デスガン選択率
            Section {
                Text("・スナイパーチャンス１・２戦目でのデスガン選択率は設定5優遇")
            } header: {
                Text("デスガン選択率")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.sao2MenuDuringAtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sao2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT中")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    sao2ViewDuringAt(
        sao2: Sao2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
