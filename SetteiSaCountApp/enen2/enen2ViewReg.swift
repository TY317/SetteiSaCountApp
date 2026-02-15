//
//  enen2ViewReg.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/02.
//

import SwiftUI

struct enen2ViewReg: View {
    @ObservedObject var enen2: Enen2
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // ---- キャラ紹介
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "キャラ紹介シナリオでの示唆", detent: .large) {
                    enen2TableRegSenario()
                }
                .popoverTip(tipVer3190EnenSenarioSisa())
//                Text("本作もキャラ紹介のパターンで設定を示唆")
//                Text("デフォルト：青文字のシンラ→アーサー→タマキ→マキ→ヒナワ")
//                unitTableString(
//                    columTitle: "注目ポイント",
//                    stringList: [
//                        "赤キャラの人数＆出現箇所",
//                        "全部赤キャラなら!?",
//                        "5人中1人だけ青キャラなら!?",
//                        "金キャラ出現なら!?",
//                    ],
//                    maxWidth: 300,
//                )
//                .frame(maxWidth: .infinity, alignment: .center)
            } header: {
                Text("キャラ紹介")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.enen2MenuRegBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("REG")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    enen2ViewReg(
        enen2: Enen2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
