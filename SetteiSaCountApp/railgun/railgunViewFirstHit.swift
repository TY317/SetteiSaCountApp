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
                
                // カウントボタン横並び
                HStack {
                    // CZ
                    unitCountButtonVerticalDenominate(
                        title: "CZ",
                        count: $railgun.czCount,
                        color: .personalSummerLightGreen,
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
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    VStack {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "CZ",
                                denominateList: railgun.ratioFirstHitCz
                            )
                            unitTableDenominate(
                                columTitle: "AT",
                                denominateList: railgun.ratioFirstHitAt
                            )
                        }
                    }
                }
                
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
