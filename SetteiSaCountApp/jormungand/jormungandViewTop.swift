//
//  jormungandViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import SwiftUI

struct jormungandViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var jormungand = Jormungand()
    @State var isShowAlert: Bool = false
//    @StateObject var jormungandMemory1 = JormungandMemory1()
//    @StateObject var jormungandMemory2 = JormungandMemory2()
//    @StateObject var jormungandMemory3 = JormungandMemory3()
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
                        machineName: jormungand.machineName,
                    )
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: jormungandViewNormal(
                        jormungand: jormungand,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.jormungandMenuNormalBadge,
                        )
                    }
                    
//                    // CZ
//                    NavigationLink(destination: jormungandViewCz(
//                        jormungand: jormungand,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "scope",
//                            textBody: "CZ",
//                            badgeStatus: common.jormungandMenuCzBadge,
//                        )
//                    }
                    
                    // 初当り
                    NavigationLink(destination: jormungandViewFirstHit(
                        jormungand: jormungand,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.jormungandMenuFirstHitBadge,
                        )
                    }
                    
//                    // 白洲ビジョン
//                    NavigationLink(destination: jormungandViewOshirasu(
//                        jormungand: jormungand,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "display",
//                            textBody: "御白洲ビジョン",
//                            badgeStatus: common.jormungandMenuOshirasuBadge,
//                        )
//                    }
//                    
//                    // AT終了画面
//                    NavigationLink(destination: jormungandViewScreen(
//                        jormungand: jormungand,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "photo.on.rectangle.angled.fill",
//                            textBody: "AT終了画面",
//                            badgeStatus: common.jormungandMenuScreenBadge,
//                        )
//                    }
//
//                    // ST終了画面
//                    NavigationLink(destination: jormungandViewScreen(
//                        jormungand: jormungand,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "photo.on.rectangle.angled.fill",
//                            textBody: "ST終了画面",
//                            badgeStatus: common.jormungandMenuScreenBadge,
//                        )
//                    }
//
//                    // おみくじ
//                    NavigationLink(destination: jormungandViewOmikuji(
//                        jormungand: jormungand,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.jormungandMenuOmikujiBadge,
//                        )
//                    }
//
//                    // サミートロフィー
//                    NavigationLink(destination: commonViewSammyTrophy()) {
//                        unitLabelMenu(
//                            imageSystemName: "trophy.fill",
//                            textBody: "サミートロフィー"
//                        )
//                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: jormungandView95Ci(
                    jormungand: jormungand,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: jormungandViewBayes(
                    jormungand: jormungand,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.jormungandMenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4970")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©2012 高橋慶太郎・小学館／ヨルムンガンド製作委員会")
                    Text("©YAMASA NEXT")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.jormungandMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: jormungand.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(jormungandSubViewLoadMemory(
//                    jormungand: jormungand,
//                    jormungandMemory1: jormungandMemory1,
//                    jormungandMemory2: jormungandMemory2,
//                    jormungandMemory3: jormungandMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(jormungandSubViewSaveMemory(
//                    jormungand: jormungand,
//                    jormungandMemory1: jormungandMemory1,
//                    jormungandMemory2: jormungandMemory2,
//                    jormungandMemory3: jormungandMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: jormungand.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    jormungandViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
