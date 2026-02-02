//
//  kokakukidotaiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/13.
//

import SwiftUI

struct kokakukidotaiViewNormal: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // タチコマの家出
            Section {
                // 注意書き
                HStack {
                    Text("⚠️")
                    VStack(alignment: .leading) {
                        Text("・AT終了時200or400Gでの当否がカウント対象")
                        Text("・リセット時、CZ終了時の200or400Gは対象外")
                    }
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                }
                
                // カウントボタン横並び
                HStack {
                    // ハズレ
                    unitCountButtonPercentWithFunc(
                        title: "ハズレ",
                        count: $kokakukidotai.iedeCountMiss,
                        color: .personalSummerLightBlue,
                        bigNumber: $kokakukidotai.iedeCountSum,
                        numberofDicimal: 0,
                        minusBool: $kokakukidotai.minusCheck) {
                            kokakukidotai.iedeSumFunc()
                        }
                    // 当選
                    unitCountButtonPercentWithFunc(
                        title: "当選",
                        count: $kokakukidotai.iedeCountSuccess,
                        color: .personalSummerLightRed,
                        bigNumber: $kokakukidotai.iedeCountSum,
                        numberofDicimal: 0,
                        minusBool: $kokakukidotai.minusCheck) {
                            kokakukidotai.iedeSumFunc()
                        }
                }
                
                // 参考情報）200or400GでのCZ当選率
                unitLinkButtonViewBuilder(sheetTitle: "200or400GでのCZ期待度") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・AT終了時の200or400G時にタチコマの家出を抽選")
                            Text("・CZ合算の期待度に設定")
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "合算期待度",
                                percentList: kokakukidotai.ratioIede
                            )
                        }
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        kokakukidotaiView95Ci(
                            kokakukidotai: kokakukidotai,
                            selection: 3,
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
                Text("AT終了時200or400GでのCZ当選")
            }
            
            // レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    kokakukidotaiTableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            // モード
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "モードについて") {
                    kokakukidotaiTableMode()
                }
            } header: {
                Text("通常時のモード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kokakukidotaiMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kokakukidotai.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    kokakukidotaiViewNormal(
        kokakukidotai: Kokakukidotai(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
