//
//  dmc5ViewFristHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/01.
//

import SwiftUI

struct dmc5ViewFristHit: View {
    @ObservedObject var dmc5: Dmc5
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    
    var body: some View {
        List {
            Section {
                // 通常ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $dmc5.normalGame,
                    unitText: "Ｇ"
                )
                .focused($isFocused)
                .toolbar {
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
                // //// カウント横並び
                HStack {
                    // ボーナス
                    unitCountButtonVerticalDenominate(
                        title: "ボーナス",
                        count: $dmc5.bonusCount,
                        color: .personalSummerLightRed,
                        bigNumber: $dmc5.normalGame,
                        numberofDicimal: 0,
                        minusBool: $dmc5.minusCheck
                    )
                    // ST
                    unitCountButtonVerticalDenominate(
                        title: "ST",
                        count: $dmc5.stCount,
                        color: .personalSummerLightPurple,
                        bigNumber: $dmc5.normalGame,
                        numberofDicimal: 0,
                        minusBool: $dmc5.minusCheck
                    )
                }
                
                // //// 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(
                                dmc5TableFirstHit(
                                    dmc5: dmc5
                                )
                            )
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        dmc5View95Ci(
                            dmc5: dmc5,
                            selection: 1
                        )
                    )
                )
            } header: {
                Text("初当りカウント")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dmc5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $dmc5.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: dmc5.resetFirstHit)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    dmc5ViewFristHit(
        dmc5: Dmc5()
    )
}
