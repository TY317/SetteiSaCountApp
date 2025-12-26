//
//  hihodenViewDuringBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/18.
//

import SwiftUI

struct hihodenViewDuringBonus: View {
    @ObservedObject var hihoden: Hihoden
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    
    var body: some View {
        List {
            Section {
                Text("ボーナス中ゲーム数：ダイトモを参考に入力して下さい\nハズレ回数：自力カウントして下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // ボーナス中ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "ボーナス中ゲーム数",
                    inputValue: $hihoden.bonusGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                // ハズレ回数カウント
                unitCountButtonVerticalDenominate(
                    title: "ハズレ",
                    count: $hihoden.bonusHazureCount,
                    color: .personalSummerLightRed,
                    bigNumber: $hihoden.bonusGame,
                    numberofDicimal: 0,
                    minusBool: $hihoden.minusCheck
                )
                // 参考情報）ボーナス中ハズレ確率
                unitLinkButtonViewBuilder(sheetTitle: "ボーナス中のハズレ確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "ハズレ",
                            denominateList: hihoden.ratioBonusHazure,
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        hihodenView95Ci(
                            hihoden: hihoden,
                            selection: 3,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    hihodenViewBayes(
                        hihoden: hihoden,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("ボーナス中のハズレ")
            }
            
            // REG中のキャラ紹介
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "REG中のキャラ紹介") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・銀、金背景のキャラに注目")
                            Text("・カードの組み合わせによる役などで伝説モードなどを示唆？")
                        }
                    }
                }
            } header: {
                Text("REG中のキャラ紹介")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hihodenMenuDuringBonusBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hihoden.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ボーナス中")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $hihoden.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: hihoden.resetDuringBonus)
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
    hihodenViewDuringBonus(
        hihoden: Hihoden(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
