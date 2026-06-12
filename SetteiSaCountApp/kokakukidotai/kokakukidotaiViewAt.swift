//
//  kokakukidotaiViewAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/25.
//

import SwiftUI

struct kokakukidotaiViewAt: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            // 引き戻しストック
            Section {
                // 注意書き
                HStack {
                    Text("⚠️")
                    VStack(alignment: .leading) {
                        Text("・タチコマCZ成功時はストック1個確定のためカウント除外")
                        Text("・AT初当りの最初のREBOOTCHANCEが対象")
                        Text("・1G目ハズレでの成功or失敗をカウント")
                    }
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                }
                
                // カウントボタン横並び
                VStack {
                    Text("[1G目ハズレでの成功or失敗]")
                    HStack {
                        // 失敗
                        unitCountButtonPercentWithFunc(
                            title: "失敗",
                            count: $kokakukidotai.rebootCountMiss,
                            color: .personalSummerLightBlue,
                            bigNumber: $kokakukidotai.rebootCountSum,
                            numberofDicimal: 0,
                            minusBool: $kokakukidotai.minusCheck) {
                                kokakukidotai.rebootSumFunc()
                            }
                        // 成功
                        unitCountButtonPercentWithFunc(
                            title: "成功",
                            count: $kokakukidotai.rebootCountSuccess,
                            color: .personalSummerLightRed,
                            bigNumber: $kokakukidotai.rebootCountSum,
                            numberofDicimal: 0,
                            minusBool: $kokakukidotai.minusCheck) {
                                kokakukidotai.rebootSumFunc()
                            }
                    }
                }
                
                // 参考情報）成功ストック獲得率
                unitLinkButtonViewBuilder(sheetTitle: "成功ストック獲得率") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・⚠️タチコマCZ成功時はストック1個確定のためカウントから除外")
                            Text("・AT当選時に成功ストックを抽選")
                            Text("・成功ストックある場合は1G目に告知される")
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "成功ストック",
                                percentList: kokakukidotai.ratioReboot,
                                numberofDicimal: 1,
                            )
                        }
                        .padding(.bottom)
                        Text("[ストック個数振分け]")
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "1個",
                                percentList: [2.5,3.3,4.2,5,5.8,6.7],
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "2個",
                                percentList: [0.8,1.3,1.6,2.1,2.5,2.9],
                                numberofDicimal: 1,
                            )
                        }
                    }
                }
//                .popoverTip(tipVer3230KokakukidotaiReboot())
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        kokakukidotaiView95Ci(
                            kokakukidotai: kokakukidotai,
                            selection: 2,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    kokakukidotaiViewBayes(
                        kokakukidotai: kokakukidotai,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("REBOOTCHANCE成功ストック")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kokakukidotaiMenuAtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kokakukidotai.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT中")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $kokakukidotai.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kokakukidotai.resetAt)
            }
        }
    }
}

#Preview {
    kokakukidotaiViewAt(
        kokakukidotai: Kokakukidotai(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
