//
//  neoplaViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/16.
//

import SwiftUI

struct neoplaViewNormal: View {
    @ObservedObject var neopla: Neopla
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // //// レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    neoplaTableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            // 通常時のモード
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・ボーナス確率やボーナス比率、天井ゲーム数を6種類のモードで管理")
                            Text("・ボーナス当選時と有利区間移行時にモード移行抽選")
                            Text("・モードD,モードEへ移行するまでモード転落なし")
                        }
                        .padding(.bottom)
                        neoplaTableMode()
                    }
                }
                unitLinkButtonViewBuilder(sheetTitle: "モード示唆演出") {
                    neoplaTableModeSisa()
                }
                .popoverTip(tipVer3131neoplaNormal())
            } header: {
                Text("モード")
            }
            
            // 状態
            Section {
                unitLinkButtonViewBuilder(
                    sheetTitle: "高確状態") {
                        VStack(alignment: .leading) {
                            Text("・レア役や規定ゲーム数消化で移行するボーナスの高確状態")
                            Text("・移行すればボーナス当選まで転落なし")
                            Text("・滞在中は約1/30でボーナス抽選")
                        }
                    }
                unitLinkButtonViewBuilder(sheetTitle: "状態示唆演出") {
                    neoplaTableStatusSisa()
                }
            } header: {
                Text("状態")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.neoplaMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: neopla.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    neoplaViewNormal(
        neopla: Neopla(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
