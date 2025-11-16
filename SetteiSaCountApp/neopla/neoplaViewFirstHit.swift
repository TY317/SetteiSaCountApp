//
//  neoplaViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/16.
//

import SwiftUI

struct neoplaViewFirstHit: View {
    @ObservedObject var neopla: Neopla
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    
    var body: some View {
        List {
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $neopla.normalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                
                // カウントボタン横並び
                HStack {
                    // 赤7
                    unitCountButtonDenominateWithFunc(
                        title: "赤7",
                        count: $neopla.bonusCountBigRed,
                        color: .personalSummerLightRed,
                        bigNumber: $neopla.normalGame,
                        numberofDicimal: 0,
                        minusBool: $neopla.minusCheck) {
                            neopla.bonusSumFunc()
                        }
                    // 青7
                    unitCountButtonDenominateWithFunc(
                        title: "青7",
                        count: $neopla.bonusCountBigBlue,
                        color: .personalSummerLightBlue,
                        bigNumber: $neopla.normalGame,
                        numberofDicimal: 0,
                        minusBool: $neopla.minusCheck) {
                            neopla.bonusSumFunc()
                        }
                    // REG
                    unitCountButtonDenominateWithFunc(
                        title: "REG",
                        count: $neopla.bonusCountReg,
                        color: .personalSummerLightGreen,
                        bigNumber: $neopla.normalGame,
                        numberofDicimal: 0,
                        minusBool: $neopla.minusCheck) {
                            neopla.bonusSumFunc()
                        }
                }
                
                // 合算確率
                HStack {
                    // ビッグ合算
                    unitResultRatioDenomination2Line(
                        title: "BIG合算",
                        count: $neopla.bonusCountBigSum,
                        bigNumber: $neopla.normalGame,
                        numberofDicimal: 0
                    )
                    // ビッグ合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $neopla.bonusCountSum,
                        bigNumber: $neopla.normalGame,
                        numberofDicimal: 0
                    )
                }
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "ボーナス確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [1,2,4,5,6])
                        unitTableDenominate(
                            columTitle: "BIG合算",
                            denominateList: neopla.ratioBigSum
                        )
                        unitTableDenominate(
                            columTitle: "REG",
                            denominateList: neopla.ratioReg
                        )
                        unitTableDenominate(
                            columTitle: "ボーナス合算",
                            denominateList: neopla.ratioBonusSum
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        neoplaView95Ci(
                            neopla: neopla,
                            selection: 1,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    neoplaViewBayes(
                        neopla: neopla,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("ボーナス")
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
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $neopla.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: neopla.resetFirstHit)
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
    neoplaViewFirstHit(
        neopla: Neopla(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
