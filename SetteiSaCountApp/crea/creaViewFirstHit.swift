//
//  creaViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/25.
//

import SwiftUI

struct creaViewFirstHit: View {
    @ObservedObject var crea: Crea
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    var body: some View {
        List {
            // //// 初当りカウント
            Section {
                // 総ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在ゲーム数",
                    inputValue: $crea.gameNumberCurrent,
                    unitText: "Ｇ"
                )
                .focused(self.$isFocused)
                .onChange(of: crea.gameNumberCurrent) {
                    let playGame = crea.gameNumberCurrent - crea.gameNumberStart
                    crea.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // カウントボタン横並び
                HStack {
                    // ビッグ
                    unitCountButtonDenominateWithFunc(
                        title: "BIG",
                        count: $crea.bonusCountBig,
                        color: .personalSummerLightRed,
                        bigNumber: $crea.gameNumberCurrent,
                        numberofDicimal: 0,
                        minusBool: $crea.minusCheck) {
                            crea.bonusCountSumFunc()
                        }
                    // REG
                    unitCountButtonDenominateWithFunc(
                        title: "REG",
                        count: $crea.bonusCountReg,
                        color: .personalSummerLightBlue,
                        bigNumber: $crea.gameNumberCurrent,
                        numberofDicimal: 0,
                        minusBool: $crea.minusCheck) {
                            crea.bonusCountSumFunc()
                        }
                }
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "BIG",
                            denominateList: crea.ratioBonusBig,
                        )
                        unitTableDenominate(
                            columTitle: "REG",
                            denominateList: crea.ratioBonusReg,
                        )
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        creaView95Ci(
                            crea: crea,
                            selection: 5,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    creaViewBayes(
                        crea: crea,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                HStack {
                    Text("ボーナス回数")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "ボーナス回数",
                            textBody1: "・ゲーム数は現在の総ゲーム数を入力して下さい",
                            textBody2: "・前任者分含めた総ボーナス回数でカウントして下さい",
                        )
                    }
                }
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: crea.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $crea.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: crea.resetBonus)
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
    creaViewFirstHit(
        crea: Crea(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
