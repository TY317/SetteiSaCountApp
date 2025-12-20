//
//  hihodenViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/13.
//

import SwiftUI

struct hihodenViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var hihoden = Hihoden()
    @State var isShowAlert: Bool = false
//    @StateObject var hihodenMemory1 = HihodenMemory1()
//    @StateObject var hihodenMemory2 = HihodenMemory2()
//    @StateObject var hihodenMemory3 = HihodenMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ダイトモの利用を前提としています\n遊技前にダイトモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: hihoden.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: hihodenViewNormal(
                        hihoden: hihoden,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.hihodenMenuNormalBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: hihodenviewFirstHit(
                        hihoden: hihoden,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.hihodenMenuFirstHitBadge,
                        )
                    }
                    
                    // ボーナス中
                    NavigationLink(destination: hihodenViewDuringBonus(
                        hihoden: hihoden,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "pyramid.fill",
                            textBody: "ボーナス中",
                            badgeStatus: common.hihodenMenuDuringBonusBadge,
                        )
                    }
                    
                    // トロフィー
                    NavigationLink(destination: commonViewKopandaTrophy()) {
                        unitLabelMenu(imageSystemName: "trophy.fill", textBody: "コパンダトロフィー")
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: hihodenView95Ci(
                    hihoden: hihoden,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: hihodenViewBayes(
                    hihoden: hihoden,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.hihodenMenuBayesBadge,
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4929")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎DAITO GIKEN,INC.")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hihodenMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hihoden.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(hihodenSubViewLoadMemory(
//                    hihoden: hihoden,
//                    hihodenMemory1: hihodenMemory1,
//                    hihodenMemory2: hihodenMemory2,
//                    hihodenMemory3: hihodenMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(hihodenSubViewSaveMemory(
//                    hihoden: hihoden,
//                    hihodenMemory1: hihodenMemory1,
//                    hihodenMemory2: hihodenMemory2,
//                    hihodenMemory3: hihodenMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: hihoden.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    hihodenViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
