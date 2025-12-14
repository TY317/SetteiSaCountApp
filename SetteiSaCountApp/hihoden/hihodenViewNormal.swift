//
//  hihodenViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/13.
//

import SwiftUI

struct hihodenViewNormal: View {
    @ObservedObject var hihoden: Hihoden
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    
    var body: some View {
        List {
            // //// レア役
            Section {
                Text("ダイトモを参考に入力して下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "ゲーム数",
                    inputValue: $hihoden.totalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                // チェリー回数入力
                unitTextFieldNumberInputWithUnit(
                    title: "🍒",
                    inputValue: $hihoden.koyakuCountCherry,
//                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                
                // 確率結果
                unitResultRatioDenomination2Line(
                    title: "🍒",
                    count: $hihoden.koyakuCountCherry,
                    bigNumber: $hihoden.totalGame,
                    numberofDicimal: 0
                )
                
                // 参考情報）チェリー確率
                unitLinkButtonViewBuilder(
                    sheetTitle: "🍒確率") {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "🍒",
                                denominateList: hihoden.ratioKoyakuCherry
                            )
                        }
                    }
                // 参考情報）レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    hihodenTableKoyakuPattern()
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        hihodenView95Ci(
                            hihoden: hihoden,
                            selection: 2,
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
                Text("レア役")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hihodenMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hihoden.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $hihoden.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: hihoden.resetNormal)
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
    hihodenViewNormal(
        hihoden: Hihoden(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
