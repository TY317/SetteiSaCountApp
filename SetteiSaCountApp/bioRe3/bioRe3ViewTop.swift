//
//  bioRe3ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/03.
//

import SwiftUI

struct bioRe3ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var bioRe3 = BioRe3()
    @State var isShowAlert: Bool = false
//    @StateObject var bioRe3Memory1 = BioRe3Memory1()
//    @StateObject var bioRe3Memory2 = BioRe3Memory2()
//    @StateObject var bioRe3Memory3 = BioRe3Memory3()
    var body: some View {
        NavigationStack {
            List {
//                Section {
//                    // 注意事項
//                    Text("スロプラNEXTの利用を前提としています\n遊技前にスロプラNEXTを開始してください")
//                        .foregroundStyle(Color.secondary)
//                        .font(.footnote)
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: bioRe3.machineName,
//                        titleFont: .title2,
//                    )
//                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: bioRe3ViewNormal(
                        bioRe3: bioRe3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.bioRe3MenuNormalBadge,
                        )
                    }
                    
//                    // CZ
//                    NavigationLink(destination: bioRe3ViewCz(
//                        bioRe3: bioRe3,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "scope",
//                            textBody: "CZ",
//                            badgeStatus: common.bioRe3MenuCzBadge,
//                        )
//                    }
                    
                    // 初当り
                    NavigationLink(destination: bioRe3ViewFirstHit(
                        bioRe3: bioRe3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.bioRe3MenuFirstHitBadge,
                        )
                    }
                    
                    // フィギュアコレクション
                    NavigationLink(destination: bioRe3ViewFigure(
                        bioRe3: bioRe3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "figure.stand",
                            textBody: "フィギュアコレクション",
                            badgeStatus: common.bioRe3MenuFigureBadge,
                        )
                    }

                    // AT終了画面
//                    NavigationLink(destination: bioRe3ViewScreen(
//                        bioRe3: bioRe3,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "signature",
//                            textBody: "ボーナス・AT終了画面",
//                            badgeStatus: common.bioRe3MenuScreenBadge,
//                        )
//                    }

                    // エンディング
                    NavigationLink(destination: bioRe3ViewFigure(
                        bioRe3: bioRe3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.bioRe3MenuEndingBadge,
                        )
                    }

//                    // おみくじ
//                    NavigationLink(destination: bioRe3ViewOmikuji(
//                        bioRe3: bioRe3,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.bioRe3MenuOmikujiBadge,
//                        )
//                    }
//
                    // トロフィー
                    NavigationLink(destination: commonViewEnteriseTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "エンタトロフィー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: bioRe3.machineName,
                        titleFont: .title2,
                    )
                }
                
                // 設定推測グラフ
                NavigationLink(destination: bioRe3View95Ci(
                    bioRe3: bioRe3,
                    selection: 4,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: bioRe3ViewBayes(
                    bioRe3: bioRe3,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.bioRe3MenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4974")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©CAPCOM")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.bioRe3MachineIconBadge)
//        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "4961")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bioRe3.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(bioRe3SubViewLoadMemory(
//                    bioRe3: bioRe3,
//                    bioRe3Memory1: bioRe3Memory1,
//                    bioRe3Memory2: bioRe3Memory2,
//                    bioRe3Memory3: bioRe3Memory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(bioRe3SubViewSaveMemory(
//                    bioRe3: bioRe3,
//                    bioRe3Memory1: bioRe3Memory1,
//                    bioRe3Memory2: bioRe3Memory2,
//                    bioRe3Memory3: bioRe3Memory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: bioRe3.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    bioRe3ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
