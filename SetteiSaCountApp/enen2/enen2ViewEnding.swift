//
//  enen2ViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/19.
//

import SwiftUI

struct enen2ViewEnding: View {
    @ObservedObject var enen2: Enen2
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // ミニキャラ示唆
            Section {
                // 注意書き
                Text("レア役成立時のミニキャラで設定を示唆")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // 示唆
                enen2TableEnding()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報）振分け
                unitLinkButtonViewBuilder(sheetTitle: "キャラ振分け") {
                    enen2TableEndingRatio()
                }
            } header: {
                Text("ミニキャラ示唆")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.enen2MenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    enen2ViewEnding(
        enen2: Enen2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
