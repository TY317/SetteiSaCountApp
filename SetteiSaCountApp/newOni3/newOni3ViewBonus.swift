//
//  newOni3ViewBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/12.
//

import SwiftUI

struct newOni3ViewBonus: View {
    @ObservedObject var newOni3: NewOni3
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var isShowAlert: Bool = false
    var body: some View {
        List {
            Section {
//                Text("[注意！]ボーナス揃え時に図柄を4コマ以内に目押ししないと全てデフォルトになってしまいます！絶対に目押ししましょう！")
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "ボイスキャラ",
                        stringList: [
                            "茜",
                            "蒼鬼",
                            "オールキャスト",
                        ],
                        maxWidth: 120,
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "蒼剣ボーナスのデフォルト",
                            "真蒼剣ボーナスのデフォルト",
                            "高設定示唆",
                        ],
                        maxWidth: 250,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
//                // ボタン横並び
//                HStack {
//                    // 茜・蒼鬼
//                    unitCountButtonPercentWithFunc(
//                        title: "茜・蒼鬼",
//                        count: $newOni3.naviVoiceCountDefault,
//                        color: .personalSummerLightBlue,
//                        bigNumber: $newOni3.naviVoiceCountSum,
//                        numberofDicimal: 0,
//                        minusBool: $newOni3.minusCheck) {
//                            newOni3.naviVoiceCountSum = newOni3.naviVoiceCountDefault + newOni3.naviVoiceCountHigh
//                        }
//                    // オールキャスト
//                    unitCountButtonPercentWithFunc(
//                        title: "オールキャスト",
//                        count: $newOni3.naviVoiceCountHigh,
//                        color: .personalSummerLightRed,
//                        bigNumber: $newOni3.naviVoiceCountSum,
//                        numberofDicimal: 0,
//                        minusBool: $newOni3.minusCheck) {
//                            newOni3.naviVoiceCountSum = newOni3.naviVoiceCountDefault + newOni3.naviVoiceCountHigh
//                        }
//                }
//                
//                // 参考情報）ナビボイス振分け確率
//                unitLinkButtonViewBuilder(sheetTitle: "ナビボイス振分け確率") {
//                    HStack(spacing: 0) {
//                        unitTableSettingIndex()
//                        unitTablePercent(
//                            columTitle: "茜・蒼鬼",
//                            percentList: [
//                                newOni3.ratioNaviVoiceDefault[0],
//                                newOni3.ratioNaviVoiceDefault[1],
//                                newOni3.ratioNaviVoiceDefault[3],
//                            ],
//                            lineList: [1,2,3],
//                        )
//                        unitTablePercent(
//                            columTitle: "オールキャスト",
//                            percentList: [
//                                newOni3.ratioNaviVoiceHigh[0],
//                                newOni3.ratioNaviVoiceHigh[1],
//                                newOni3.ratioNaviVoiceHigh[3],
//                            ],
//                            lineList: [1,2,3],
//                        )
//                    }
//                }
//                
//                // //// 95%信頼区間グラフへのリンク
//                unitNaviLink95Ci(
//                    Ci95view: AnyView(
//                        newOni3View95Ci(
//                            newOni3: newOni3,
//                            selection: 3,
//                        )
//                    )
//                )
//                // //// 設定期待値へのリンク
//                unitNaviLinkBayes {
//                    newOni3ViewBayes(
//                        newOni3: newOni3,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )
//                }
            } header: {
                Text("ナビボイス振り分け")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newOni3.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("蒼剣ボーナス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $newOni3.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: newOni3.resetBonus)
            }
        }
    }
}

#Preview {
    newOni3ViewBonus(
        newOni3: NewOni3(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
