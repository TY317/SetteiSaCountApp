//
//  otome5ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/02.
//

import SwiftUI

struct otome5ViewNormal: View {
    @ObservedObject var otome5: Otome5
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // 小役関連
            Section {
                otome5TableKoyakuPattern()
            } header: {
                Text("レア役停止形")
            }
            
            // 乙女アタック当選率
            Section {
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "乙女アタック当選率",
                    count: $otome5.otomeAttackHit,
                    bigNumber: $otome5.otomeAttackSum,
                    numberofDicimal: 0
                )
                
                // 参考情報）乙女アタック当選率
                unitLinkButtonViewBuilder(sheetTitle: "乙女アタック当選率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "乙女アタック当選率",
                            percentList: otome5.ratioOtomeAttack
                        )
                    }
                }
                
                // カウント
                DisclosureGroup {
                    // 説明
                    Text("巫女カウンター到達からの当選有無をカウント")
                    
                    // カウントボタン横並び
                    HStack {
                        // ハズレ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "ハズレ",
                            count: $otome5.otomeAttackMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $otome5.minusCheck) {
                                otome5.attackSumFunc()
                            }
                        // 当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: $otome5.otomeAttackHit,
                            color: .personalSummerLightRed,
                            minusBool: $otome5.minusCheck) {
                                otome5.attackSumFunc()
                            }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            otome5View95Ci(
                                otome5: otome5,
                                selection: 2,
                            )
                        )
                    )
                    
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        otome5ViewBayes(
                            otome5: otome5,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("乙女アタック当選率")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.otome5MenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: otome5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    otome5ViewNormal(
        otome5: Otome5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
