//
//  railgunViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/19.
//

import SwiftUI

struct railgunViewNormal: View {
    @ObservedObject var railgun: Railgun
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            // //// レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    railgunTableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            // //// コイン揃いからのCZ
            Section {
                // カウントボタン横並び
                HStack {
                    // コイン揃い
                    unitCountButtonVerticalWithoutRatio(
                        title: "コイン揃い",
                        count: $railgun.coinCount,
                        color: .personalSummerLightBlue,
                        minusBool: $railgun.minusCheck
                    )
                    // CZ当選
                    unitCountButtonVerticalWithoutRatio(
                        title: "CZ当選",
                        count: $railgun.coinCountCzHit,
                        color: .personalSummerLightRed,
                        minusBool: $railgun.minusCheck
                    )
                }
                // CZ当選率
                unitResultRatioPercent2Line(
                    title: "CZ当選",
                    count: $railgun.coinCountCzHit,
                    bigNumber: $railgun.coinCount,
                    numberofDicimal: 0
                )
                // 参考情報）Cz当選率
                unitLinkButtonViewBuilder(sheetTitle: "コイン揃いからのCZ当選率") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・コイン準備状態移行時とコイン揃い時の2段階でCZ当選を抽選")
                            Text("・どちらで当選したかは見抜けないため、実質のCZ当選率のみ記載します")
                        }
                        .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "実質CZ当選率",
                                percentList: railgun.ratioCoinCzHit
                            )
                        }
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        railgunView95Ci(
                            railgun: railgun,
                            selection: 1,
                        )
                    )
                )
            } header: {
                HStack {
                    Text("コイン揃いからのCZ")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "コイン揃いからのCZ",
                            textBody1: "・コイン揃い回数とコイン揃いからのCZ当選回数をカウント",
                            textBody2: "・連続演出中のコイン揃いは演出の可能性あるためカウントから除外",
                        )
                    }
                }
            }
            
            // //// 通常時のモード
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・花火ステージ(超高確orコイン準備示唆)への移行ゲームを4つのモードで管理")
                            Text("・移行ゲームは花火シナリオによって管理")
                        }
                        .padding(.bottom)
                        railgunTableMode()
                    }
                }
            } header: {
                Text("通常時のモード")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: railgun.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $railgun.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: railgun.resetNormal)
            }
        }
    }
}

#Preview {
    railgunViewNormal(
        railgun: Railgun(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
