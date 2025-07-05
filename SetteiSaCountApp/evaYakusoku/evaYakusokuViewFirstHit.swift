//
//  evaYakusokuViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/29.
//

import SwiftUI

struct evaYakusokuViewFirstHit: View {
    @ObservedObject var evaYakusoku: EvaYakusoku
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    
    var body: some View {
        List {
            // //// ボーナス回数カウント
            Section {
                // //// カウントボタン横並び
                HStack {
                    // BB
                    unitCountButtonDenominateWithFunc(
                        title: "BB",
                        count: $evaYakusoku.bonusCountBig,
                        color: .personalSpringLightYellow,
                        bigNumber: $evaYakusoku.gameNumberPlay,
                        numberofDicimal: 0,
                        minusBool: $evaYakusoku.minusCheck,
                        action: evaYakusoku.bonusSumFunc
                    )
                    // SBB
                    unitCountButtonDenominateWithFunc(
                        title: "SBB",
                        count: $evaYakusoku.bonusCountSBig,
                        color: .personalSummerLightRed,
                        bigNumber: $evaYakusoku.gameNumberPlay,
                        numberofDicimal: 0,
                        minusBool: $evaYakusoku.minusCheck,
                        action: evaYakusoku.bonusSumFunc
                    )
                    // REG
                    unitCountButtonDenominateWithFunc(
                        title: "REG",
                        count: $evaYakusoku.bonusCountReg,
                        color: .personalSummerLightBlue,
                        bigNumber: $evaYakusoku.gameNumberPlay,
                        numberofDicimal: 0,
                        minusBool: $evaYakusoku.minusCheck,
                        action: evaYakusoku.bonusSumFunc
                    )
                }
                // //// 確率結果横並び
                HStack {
                    // BB合算
                    unitResultRatioDenomination2Line(
                        title: "BIG合算",
                        count: $evaYakusoku.bonusCountBigSum,
                        bigNumber: $evaYakusoku.gameNumberPlay,
                        numberofDicimal: 0
                    )
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $evaYakusoku.bonusCountAllSum,
                        bigNumber: $evaYakusoku.gameNumberPlay,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(
                                evaYakusokuTableFirstHit(
                                    evaYakusoku: evaYakusoku
                                )
                            )
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        evaYakusokuView95Ci(
                            evaYakusoku: evaYakusoku,
                            selection: 1
                        )
                    )
                )
                
            } header: {
                Text("初当り")
            }
            
            Section {
                // //// ゲーム数入力
                // 打ち始め入力
                unitTextFieldNumberInputWithUnit(
                    title: "打ち始め",
                    inputValue: $evaYakusoku.gameNumberStart,
                    unitText: "Ｇ"
                )
                .keyboardDoneToolbar(focus: self.$isFocused)
                .onChange(of: evaYakusoku.gameNumberStart) {
                    let playGame = evaYakusoku.gameNumberCurrent - evaYakusoku.gameNumberStart
                    evaYakusoku.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // 現在入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在",
                    inputValue: $evaYakusoku.gameNumberCurrent,
                    unitText: "Ｇ"
                )
//                .keyboardDoneToolbar(focus: self.$isFocused)    // 同じページで2つ使うとバグ発生
                .focused(self.$isFocused)
                .onChange(of: evaYakusoku.gameNumberCurrent) {
                    let playGame = evaYakusoku.gameNumberCurrent - evaYakusoku.gameNumberStart
                    evaYakusoku.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // プレイ数
                unitTextGameNumberWithoutInput(
                    gameNumber: evaYakusoku.gameNumberPlay
                )
                
            } header: {
                Text("ゲーム数入力")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: evaYakusoku.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $evaYakusoku.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: evaYakusoku.resetFirstHit)
                }
            }
        }
    }
}

#Preview {
    evaYakusokuViewFirstHit(
        evaYakusoku: EvaYakusoku(),
    )
}
