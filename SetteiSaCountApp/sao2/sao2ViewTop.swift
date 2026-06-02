//
//  sao2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/30.
//

import SwiftUI

struct sao2ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var sao2 = Sao2()
    @State var isShowAlert: Bool = false
//    @StateObject var sao2Memory1 = sao2Memory1()
//    @StateObject var sao2Memory2 = sao2Memory2()
//    @StateObject var sao2Memory3 = sao2Memory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ダイトモの利用を前提としています\n遊技前にダイトモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: sao2.machineName,
                        titleFont: .title2,
                    )
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: sao2ViewNormal(
                        sao2: sao2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.sao2MenuNormalBadge,
                        )
                    }
                    
//                    // CZ
//                    NavigationLink(destination: sao2ViewCz(
//                        sao2: sao2,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "scope",
//                            textBody: "CZ",
//                            badgeStatus: common.sao2MenuCzBadge,
//                        )
//                    }
//                    
//                    // 初当り
//                    NavigationLink(destination: sao2ViewFirstHit(
//                        sao2: sao2,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "party.popper.fill",
//                            textBody: "初当り",
//                            badgeStatus: common.sao2MenuFirstHitBadge,
//                        )
//                    }
//                    
//                    // フィギュアコレクション
//                    NavigationLink(destination: sao2ViewFigure(
//                        sao2: sao2,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "figure.stand",
//                            textBody: "フィギュアコレクション",
//                            badgeStatus: common.sao2MenuFigureBadge,
//                        )
//                    }

                    // AT終了画面
//                    NavigationLink(destination: sao2ViewScreen(
//                        sao2: sao2,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "signature",
//                            textBody: "ボーナス・AT終了画面",
//                            badgeStatus: common.sao2MenuScreenBadge,
//                        )
//                    }

//                    // エンディング
//                    NavigationLink(destination: sao2ViewFigure(
//                        sao2: sao2,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "flag.pattern.checkered",
//                            textBody: "エンディング",
//                            badgeStatus: common.sao2MenuEndingBadge,
//                        )
//                    }

//                    // おみくじ
//                    NavigationLink(destination: sao2ViewOmikuji(
//                        sao2: sao2,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.sao2MenuOmikujiBadge,
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
//                        machineName: sao2.machineName,
//                        titleFont: .title,
//                    )
                }
                
                // 設定推測グラフ
                NavigationLink(destination: sao2View95Ci(
                    sao2: sao2,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: sao2ViewBayes(
                    sao2: sao2,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.sao2MenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5025")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©2017 川原 礫／KADOKAWA　アスキー・メディアワークス／SAO-A Project")
                    Text("©DAITO GIKEN,INC.")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.sao2MachineIconBadge)
//        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "4961")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sao2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(sao2SubViewLoadMemory(
//                    sao2: sao2,
//                    sao2Memory1: sao2Memory1,
//                    sao2Memory2: sao2Memory2,
//                    sao2Memory3: sao2Memory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(sao2SubViewSaveMemory(
//                    sao2: sao2,
//                    sao2Memory1: sao2Memory1,
//                    sao2Memory2: sao2Memory2,
//                    sao2Memory3: sao2Memory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: sao2.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    sao2ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
