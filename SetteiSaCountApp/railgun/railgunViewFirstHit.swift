//
//  railgunViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/19.
//

import SwiftUI

struct railgunViewFirstHit: View {
    @ObservedObject var railgun: Railgun
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    
    var body: some View {
        List {
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $railgun.normalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                
                // CZ種類の注意書き
                VStack(alignment: .leading) {
                    Text("通常CZ：ガールズジャッジ")
                    Text("上位CZ：婚后光子と知っての挑戦ですの")
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
                
                // カウントボタン横並び
                HStack {
                    // CZ
                    unitCountButtonVerticalDenominate(
                        title: "通常CZ",
                        count: $railgun.czCount,
                        color: .personalSummerLightGreen,
                        bigNumber: $railgun.normalGame,
                        numberofDicimal: 0,
                        minusBool: $railgun.minusCheck
                    )
                    // CZ
                    unitCountButtonVerticalDenominate(
                        title: "上位CZ",
                        count: $railgun.czCountPremium,
                        color: .personalSummerLightPurple,
                        bigNumber: $railgun.normalGame,
                        numberofDicimal: 0,
                        minusBool: $railgun.minusCheck
                    )
                    // AT
                    unitCountButtonVerticalDenominate(
                        title: "AT",
                        count: $railgun.atCount,
                        color: .personalSummerLightRed,
                        bigNumber: $railgun.normalGame,
                        numberofDicimal: 0,
                        minusBool: $railgun.minusCheck
                    )
                }
//                .popoverTip(tipVer3140railgunFirstHit())
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    VStack {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "通常CZ",
                                denominateList: railgun.ratioFirstHitCzNormal
                            )
                            unitTableDenominate(
                                columTitle: "上位CZ",
                                denominateList: railgun.ratioFirstHitCzPremium
                            )
                            unitTableDenominate(
                                columTitle: "AT",
                                denominateList: railgun.ratioFirstHitAt
                            )
                        }
                    }
                }
                
                // 参考情報）エピボ直撃当選率
                unitLinkButtonViewBuilder(sheetTitle: "エピボ直撃当選率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "エピボ直撃",
                            denominateList: [39680,26453,19921,13390,11572,10168]
                        )
                    }
                }
                .popoverTip(tipVer3170railgunEpisode())
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        railgunView95Ci(
                            railgun: railgun,
                            selection: 2,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    railgunViewBayes(
                        railgun: railgun,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("初当り")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.railgunMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: railgun.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $railgun.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: railgun.resetFirstHit)
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: {
                        isFocused = false
                    }, label: {
                        Text("完了")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}

#Preview {
    railgunViewFirstHit(
        railgun: Railgun(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
