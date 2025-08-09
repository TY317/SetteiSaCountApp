//
//  reSwordViewFranSleep.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct reSwordViewFranSleep: View {
    @ObservedObject var ver361: Ver361
    @ObservedObject var reSword: ReSword
    @State var isShowAlert = false
    
    var body: some View {
        List {
            // AT当選カウント
            Section {
                // 注意書き
                Text("レア役などでの自力当選は設定差不明のため、カウントから除外を推奨")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // カウントボタン横並び
                HStack {
                    // ハズレ
                    unitCountButtonWithoutRatioWithFunc(
                        title: "ハズレ",
                        count: $reSword.franSleepCountMiss,
                        color: .personalSummerLightBlue,
                        minusBool: $reSword.minusCheck) {
                            reSword.franSleepCountSumFunc()
                        }
                    // AT当選
                    unitCountButtonWithoutRatioWithFunc(
                        title: "AT当選",
                        count: $reSword.franSleepCountHit,
                        color: .personalSummerLightRed,
                        minusBool: $reSword.minusCheck) {
                            reSword.franSleepCountSumFunc()
                        }
                }
                // 確率
                unitResultRatioPercent2Line(
                    title: "AT当選率",
                    count: $reSword.franSleepCountHit,
                    bigNumber: $reSword.franSleepCountSum,
                    numberofDicimal: 0
                )
                // 参考情報）AT当選率
                unitLinkButtonViewBuilder(sheetTitle: "突入時のAT当選率") {
                    VStack {
                        Text("・フランおやすみ中突入時のAT当選率に設定差あり")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("・レア役などでの自力当選があると突入時の当選と見分けがつかないと思われる\n　レア役後の当選の場合はカウントから除外を推奨")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "突入時のAT当選",
                                percentList: reSword.ratioSleepAt
                            )
                        }
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        reSwordView95Ci(
                            reSword: reSword,
                            selection: 1
                        )
                    )
                )
            } header: {
                Text("AT当選率")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver361.reSwordMenuFranSleepBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: reSword.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("フランおやすみ中")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $reSword.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: reSword.resetFranSleepCount)
                }
            }
        }
    }
}

#Preview {
    reSwordViewFranSleep(
        ver361: Ver361(),
        reSword: ReSword(),
    )
}
