//
//  rioAceViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/02.
//

import SwiftUI

struct rioAceViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var rioAce = RioAce()
    @State var isShowAlert: Bool = false
//    @StateObject var rioAceMemory1 = RioAceMemory1()
//    @StateObject var rioAceMemory2 = RioAceMemory2()
//    @StateObject var rioAceMemory3 = RioAceMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("スロプラNEXTの利用を前提としています\n遊技前にスロプラNEXTを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: rioAce.machineName,
                        titleFont: .title2,
                    )
                }
                
                Section {
                    // 通常時
//                    NavigationLink(destination: rioAceViewNormal(
//                        rioAce: rioAce,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "bell.fill",
//                            textBody: "通常時",
//                            badgeStatus: common.rioAceMenuNormalBadge,
//                        )
//                    }
                    
//                    // CZ
//                    NavigationLink(destination: rioAceViewCz(
//                        rioAce: rioAce,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "scope",
//                            textBody: "CZ",
//                            badgeStatus: common.rioAceMenuCzBadge,
//                        )
//                    }
                    
                    // 初当り
//                    NavigationLink(destination: rioAceViewFirstHit(
//                        rioAce: rioAce,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "party.popper.fill",
//                            textBody: "初当り",
//                            badgeStatus: common.rioAceMenuFirstHitBadge,
//                        )
//                    }
                    
//                    // REG
//                    NavigationLink(destination: rioAceViewReg(
//                        rioAce: rioAce,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "person.2.fill",
//                            textBody: "REG",
//                            badgeStatus: common.rioAceMenuRegBadge,
//                        )
//                    }
//
//                    // AT終了画面
//                    NavigationLink(destination: rioAceViewScreen(
//                        rioAce: rioAce,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "photo.on.rectangle.angled.fill",
//                            textBody: "ボーナス終了画面",
//                            badgeStatus: common.rioAceMenuScreenBadge,
//                        )
//                    }
//
//                    // エンディング
//                    NavigationLink(destination: rioAceViewEnding(
//                        rioAce: rioAce,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "flag.pattern.checkered",
//                            textBody: "エンディング",
//                            badgeStatus: common.rioAceMenuEndingBadge,
//                        )
//                    }
//
//                    // おみくじ
//                    NavigationLink(destination: rioAceViewOmikuji(
//                        rioAce: rioAce,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.rioAceMenuOmikujiBadge,
//                        )
//                    }
//
                    // ケロッとトロフィー
                    NavigationLink(destination: commonViewKerottoTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ケロットトロフィー"
                        )
                    }
                }
                
                // 設定推測グラフ
//                NavigationLink(destination: rioAceView95Ci(
//                    rioAce: rioAce,
//                    selection: 2,
//                )) {
//                    unitLabelMenu(
//                        imageSystemName: "chart.bar.xaxis",
//                        textBody: "設定推測グラフ"
//                    )
//                }

                // 設定期待値計算
//                NavigationLink(destination: rioAceViewBayes(
//                    rioAce: rioAce,
//                    bayes: bayes,
//                    viewModel: viewModel,
//                )) {
//                    unitLabelMenu(
//                        imageSystemName: "gauge.open.with.lines.needle.33percent",
//                        textBody: "設定期待値",
//                        badgeStatus: common.rioAceMenuBayesBadge
//                    )
//                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4984")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©コーエーテクモウェーブ All rights reserved.")
                    Text("©YAMASA NEXT")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.rioAceMachineIconBadge)
//        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "4961")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: rioAce.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(rioAceSubViewLoadMemory(
//                    rioAce: rioAce,
//                    rioAceMemory1: rioAceMemory1,
//                    rioAceMemory2: rioAceMemory2,
//                    rioAceMemory3: rioAceMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(rioAceSubViewSaveMemory(
//                    rioAce: rioAce,
//                    rioAceMemory1: rioAceMemory1,
//                    rioAceMemory2: rioAceMemory2,
//                    rioAceMemory3: rioAceMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: rioAce.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    rioAceViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
