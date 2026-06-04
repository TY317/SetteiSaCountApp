//
//  otome5ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/30.
//

import SwiftUI

struct otome5ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var otome5 = Otome5()
    @State var isShowAlert: Bool = false
//    @StateObject var otome5Memory1 = otome5Memory1()
//    @StateObject var otome5Memory2 = otome5Memory2()
//    @StateObject var otome5Memory3 = otome5Memory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("打-WINの利用を前提としています\n遊技前に打-WINを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: otome5.machineName,
                        titleFont: .title2,
                    )
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: otome5ViewNormal(
                        otome5: otome5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.otome5MenuNormalBadge,
                        )
                    }
                    
                    // CZ
                    NavigationLink(destination: otome5ViewHistory(
                        otome5: otome5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "周期履歴メモ",
                            badgeStatus: common.otome5MenuHistoryBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: otome5ViewFirstHit(
                        otome5: otome5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.otome5MenuFirstHitBadge,
                        )
                    }

//                    // フィギュアコレクション
//                    NavigationLink(destination: otome5ViewFigure(
//                        otome5: otome5,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "figure.stand",
//                            textBody: "フィギュアコレクション",
//                            badgeStatus: common.otome5MenuFigureBadge,
//                        )
//                    }

                    // AT終了画面
                    NavigationLink(destination: otome5ViewScreen(
                        otome5: otome5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面",
                            badgeStatus: common.otome5MenuScreenBadge,
                        )
                    }

//                    // エンディング
//                    NavigationLink(destination: otome5ViewFigure(
//                        otome5: otome5,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "flag.pattern.checkered",
//                            textBody: "エンディング",
//                            badgeStatus: common.otome5MenuEndingBadge,
//                        )
//                    }

//                    // おみくじ
//                    NavigationLink(destination: otome5ViewOmikuji(
//                        otome5: otome5,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.otome5MenuOmikujiBadge,
//                        )
//                    }
//
//                    // トロフィー
//                    NavigationLink(destination: commonViewEnteriseTrophy()) {
//                        unitLabelMenu(
//                            imageSystemName: "trophy.fill",
//                            textBody: "エンタトロフィー"
//                        )
//                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: otome5.machineName,
//                        titleFont: .title,
//                    )
                }
                
                // 設定推測グラフ
                NavigationLink(destination: otome5View95Ci(
                    otome5: otome5,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: otome5ViewBayes(
                    otome5: otome5,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.otome5MenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5009")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©HEIWA")
                    Text("Character design by SHIROGUMI INC.")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.otome5MachineIconBadge)
//        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "4961")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: otome5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(otome5SubViewLoadMemory(
//                    otome5: otome5,
//                    otome5Memory1: otome5Memory1,
//                    otome5Memory2: otome5Memory2,
//                    otome5Memory3: otome5Memory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(otome5SubViewSaveMemory(
//                    otome5: otome5,
//                    otome5Memory1: otome5Memory1,
//                    otome5Memory2: otome5Memory2,
//                    otome5Memory3: otome5Memory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: otome5.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    otome5ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
