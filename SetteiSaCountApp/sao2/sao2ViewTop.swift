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
    @StateObject var sao2Memory1 = Sao2Memory1()
    @StateObject var sao2Memory2 = Sao2Memory2()
    @StateObject var sao2Memory3 = Sao2Memory3()
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
                    
                    // CZ
                    NavigationLink(destination: sao2ViewCz(
                        sao2: sao2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "scope",
                            textBody: "CZ",
                            badgeStatus: common.sao2MenuCzBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: sao2ViewFirstHit(
                        sao2: sao2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.sao2MenuFirstHitBadge,
                        )
                    }
                    
                    // AT中
                    NavigationLink(destination: sao2ViewDuringAt(
                        sao2: sao2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "figure.hunting",
                            textBody: "AT中",
                            badgeStatus: common.sao2MenuDuringAtBadge,
                        )
                    }
                    
                    // AT終了画面
                    NavigationLink(destination: sao2ViewScreen(
                        sao2: sao2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面",
                            badgeStatus: common.sao2MenuScreenBadge,
                        )
                    }
                    
                    // 引き戻し
                    NavigationLink(destination: sao2ViewComeBack(
                        sao2: sao2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arrow.trianglehead.2.counterclockwise",
                            textBody: "引き戻し",
                            badgeStatus: common.sao2MenuComeBackBadge,
                        )
                    }

                    // マザーズ・ロザリオ
                    NavigationLink(destination: sao2ViewMothers(
                        sao2: sao2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "figure.hunting",
                            textBody: "マザーズ・ロザリオ",
                            badgeStatus: common.sao2MenuMothersBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: sao2ViewEnding(
                        sao2: sao2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.sao2MenuEndingBadge,
                        )
                    }

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
                    // トロフィー
                    NavigationLink(destination: commonViewKopandaTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "コパンダトロフィー"
                        )
                    }
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
//        .resetBadgeOnAppear($common.sao2MachineIconBadge)
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5025")
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
                unitButtonLoadMemory(loadView: AnyView(sao2SubViewLoadMemory(
                    sao2: sao2,
                    sao2Memory1: sao2Memory1,
                    sao2Memory2: sao2Memory2,
                    sao2Memory3: sao2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(sao2SubViewSaveMemory(
                    sao2: sao2,
                    sao2Memory1: sao2Memory1,
                    sao2Memory2: sao2Memory2,
                    sao2Memory3: sao2Memory3
                )))
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

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct sao2SubViewSaveMemory: View {
    @ObservedObject var sao2: Sao2
    @ObservedObject var sao2Memory1: Sao2Memory1
    @ObservedObject var sao2Memory2: Sao2Memory2
    @ObservedObject var sao2Memory3: Sao2Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: sao2.machineName,
            selectedMemory: $sao2.selectedMemory,
            memoMemory1: $sao2Memory1.memo,
            dateDoubleMemory1: $sao2Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $sao2Memory2.memo,
            dateDoubleMemory2: $sao2Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $sao2Memory3.memo,
            dateDoubleMemory3: $sao2Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        sao2Memory1.lowSuikaCount = sao2.lowSuikaCount
        sao2Memory1.lowSuikaCountShootingHit = sao2.lowSuikaCountShootingHit
        sao2Memory1.kyoCherryCount = sao2.kyoCherryCount
        sao2Memory1.kyoCherryCountCzHit = sao2.kyoCherryCountCzHit
        sao2Memory1.highKyoCherryCount = sao2.highKyoCherryCount
        sao2Memory1.highKyoCherryCountCzHit = sao2.highKyoCherryCountCzHit
        sao2Memory1.czItemCountMiss = sao2.czItemCountMiss
        sao2Memory1.czItemCountHit = sao2.czItemCountHit
        sao2Memory1.czItemCountSum = sao2.czItemCountSum
        sao2Memory1.czKettouCountMiss = sao2.czKettouCountMiss
        sao2Memory1.czKettouCountHit = sao2.czKettouCountHit
        sao2Memory1.czKettouCountSum = sao2.czKettouCountSum
        sao2Memory1.normalGame = sao2.normalGame
        sao2Memory1.firstHitCountCz = sao2.firstHitCountCz
        sao2Memory1.firstHitCountAt = sao2.firstHitCountAt
        sao2Memory1.screenCount1 = sao2.screenCount1
        sao2Memory1.screenCount2 = sao2.screenCount2
        sao2Memory1.screenCount3 = sao2.screenCount3
        sao2Memory1.screenCount4 = sao2.screenCount4
        sao2Memory1.screenCount5 = sao2.screenCount5
        sao2Memory1.screenCount6 = sao2.screenCount6
        sao2Memory1.screenCount7 = sao2.screenCount7
        sao2Memory1.screenCount8 = sao2.screenCount8
        sao2Memory1.screenCount9 = sao2.screenCount9
        sao2Memory1.screenCount10 = sao2.screenCount10
        sao2Memory1.screenCountSum = sao2.screenCountSum
        sao2Memory1.comeBackCountMiss = sao2.comeBackCountMiss
        sao2Memory1.comeBackCountHit = sao2.comeBackCountHit
        sao2Memory1.comeBackCountSum = sao2.comeBackCountSum
        sao2Memory1.miniCharaCount1 = sao2.miniCharaCount1
        sao2Memory1.miniCharaCount2 = sao2.miniCharaCount2
        sao2Memory1.miniCharaCount3 = sao2.miniCharaCount3
        sao2Memory1.miniCharaCount4 = sao2.miniCharaCount4
        sao2Memory1.miniCharaCount5 = sao2.miniCharaCount5
        sao2Memory1.miniCharaCount6 = sao2.miniCharaCount6
        sao2Memory1.miniCharaCount7 = sao2.miniCharaCount7
        sao2Memory1.miniCharaCount8 = sao2.miniCharaCount8
        sao2Memory1.miniCharaCountSum = sao2.miniCharaCountSum
        sao2Memory1.motherMiniCharaCount1 = sao2.motherMiniCharaCount1
        sao2Memory1.motherMiniCharaCount2 = sao2.motherMiniCharaCount2
        sao2Memory1.motherMiniCharaCount3 = sao2.motherMiniCharaCount3
        sao2Memory1.motherMiniCharaCount4 = sao2.motherMiniCharaCount4
        sao2Memory1.motherMiniCharaCount5 = sao2.motherMiniCharaCount5
        sao2Memory1.motherMiniCharaCount6 = sao2.motherMiniCharaCount6
        sao2Memory1.motherMiniCharaCount7 = sao2.motherMiniCharaCount7
        sao2Memory1.motherMiniCharaCount8 = sao2.motherMiniCharaCount8
        sao2Memory1.motherMiniCharaCountSum = sao2.motherMiniCharaCountSum
    }
    func saveMemory2() {
        sao2Memory2.lowSuikaCount = sao2.lowSuikaCount
        sao2Memory2.lowSuikaCountShootingHit = sao2.lowSuikaCountShootingHit
        sao2Memory2.kyoCherryCount = sao2.kyoCherryCount
        sao2Memory2.kyoCherryCountCzHit = sao2.kyoCherryCountCzHit
        sao2Memory2.highKyoCherryCount = sao2.highKyoCherryCount
        sao2Memory2.highKyoCherryCountCzHit = sao2.highKyoCherryCountCzHit
        sao2Memory2.czItemCountMiss = sao2.czItemCountMiss
        sao2Memory2.czItemCountHit = sao2.czItemCountHit
        sao2Memory2.czItemCountSum = sao2.czItemCountSum
        sao2Memory2.czKettouCountMiss = sao2.czKettouCountMiss
        sao2Memory2.czKettouCountHit = sao2.czKettouCountHit
        sao2Memory2.czKettouCountSum = sao2.czKettouCountSum
        sao2Memory2.normalGame = sao2.normalGame
        sao2Memory2.firstHitCountCz = sao2.firstHitCountCz
        sao2Memory2.firstHitCountAt = sao2.firstHitCountAt
        sao2Memory2.screenCount1 = sao2.screenCount1
        sao2Memory2.screenCount2 = sao2.screenCount2
        sao2Memory2.screenCount3 = sao2.screenCount3
        sao2Memory2.screenCount4 = sao2.screenCount4
        sao2Memory2.screenCount5 = sao2.screenCount5
        sao2Memory2.screenCount6 = sao2.screenCount6
        sao2Memory2.screenCount7 = sao2.screenCount7
        sao2Memory2.screenCount8 = sao2.screenCount8
        sao2Memory2.screenCount9 = sao2.screenCount9
        sao2Memory2.screenCount10 = sao2.screenCount10
        sao2Memory2.screenCountSum = sao2.screenCountSum
        sao2Memory2.comeBackCountMiss = sao2.comeBackCountMiss
        sao2Memory2.comeBackCountHit = sao2.comeBackCountHit
        sao2Memory2.comeBackCountSum = sao2.comeBackCountSum
        sao2Memory2.miniCharaCount1 = sao2.miniCharaCount1
        sao2Memory2.miniCharaCount2 = sao2.miniCharaCount2
        sao2Memory2.miniCharaCount3 = sao2.miniCharaCount3
        sao2Memory2.miniCharaCount4 = sao2.miniCharaCount4
        sao2Memory2.miniCharaCount5 = sao2.miniCharaCount5
        sao2Memory2.miniCharaCount6 = sao2.miniCharaCount6
        sao2Memory2.miniCharaCount7 = sao2.miniCharaCount7
        sao2Memory2.miniCharaCount8 = sao2.miniCharaCount8
        sao2Memory2.miniCharaCountSum = sao2.miniCharaCountSum
        sao2Memory2.motherMiniCharaCount1 = sao2.motherMiniCharaCount1
        sao2Memory2.motherMiniCharaCount2 = sao2.motherMiniCharaCount2
        sao2Memory2.motherMiniCharaCount3 = sao2.motherMiniCharaCount3
        sao2Memory2.motherMiniCharaCount4 = sao2.motherMiniCharaCount4
        sao2Memory2.motherMiniCharaCount5 = sao2.motherMiniCharaCount5
        sao2Memory2.motherMiniCharaCount6 = sao2.motherMiniCharaCount6
        sao2Memory2.motherMiniCharaCount7 = sao2.motherMiniCharaCount7
        sao2Memory2.motherMiniCharaCount8 = sao2.motherMiniCharaCount8
        sao2Memory2.motherMiniCharaCountSum = sao2.motherMiniCharaCountSum
    }
    func saveMemory3() {
        sao2Memory3.lowSuikaCount = sao2.lowSuikaCount
        sao2Memory3.lowSuikaCountShootingHit = sao2.lowSuikaCountShootingHit
        sao2Memory3.kyoCherryCount = sao2.kyoCherryCount
        sao2Memory3.kyoCherryCountCzHit = sao2.kyoCherryCountCzHit
        sao2Memory3.highKyoCherryCount = sao2.highKyoCherryCount
        sao2Memory3.highKyoCherryCountCzHit = sao2.highKyoCherryCountCzHit
        sao2Memory3.czItemCountMiss = sao2.czItemCountMiss
        sao2Memory3.czItemCountHit = sao2.czItemCountHit
        sao2Memory3.czItemCountSum = sao2.czItemCountSum
        sao2Memory3.czKettouCountMiss = sao2.czKettouCountMiss
        sao2Memory3.czKettouCountHit = sao2.czKettouCountHit
        sao2Memory3.czKettouCountSum = sao2.czKettouCountSum
        sao2Memory3.normalGame = sao2.normalGame
        sao2Memory3.firstHitCountCz = sao2.firstHitCountCz
        sao2Memory3.firstHitCountAt = sao2.firstHitCountAt
        sao2Memory3.screenCount1 = sao2.screenCount1
        sao2Memory3.screenCount2 = sao2.screenCount2
        sao2Memory3.screenCount3 = sao2.screenCount3
        sao2Memory3.screenCount4 = sao2.screenCount4
        sao2Memory3.screenCount5 = sao2.screenCount5
        sao2Memory3.screenCount6 = sao2.screenCount6
        sao2Memory3.screenCount7 = sao2.screenCount7
        sao2Memory3.screenCount8 = sao2.screenCount8
        sao2Memory3.screenCount9 = sao2.screenCount9
        sao2Memory3.screenCount10 = sao2.screenCount10
        sao2Memory3.screenCountSum = sao2.screenCountSum
        sao2Memory3.comeBackCountMiss = sao2.comeBackCountMiss
        sao2Memory3.comeBackCountHit = sao2.comeBackCountHit
        sao2Memory3.comeBackCountSum = sao2.comeBackCountSum
        sao2Memory3.miniCharaCount1 = sao2.miniCharaCount1
        sao2Memory3.miniCharaCount2 = sao2.miniCharaCount2
        sao2Memory3.miniCharaCount3 = sao2.miniCharaCount3
        sao2Memory3.miniCharaCount4 = sao2.miniCharaCount4
        sao2Memory3.miniCharaCount5 = sao2.miniCharaCount5
        sao2Memory3.miniCharaCount6 = sao2.miniCharaCount6
        sao2Memory3.miniCharaCount7 = sao2.miniCharaCount7
        sao2Memory3.miniCharaCount8 = sao2.miniCharaCount8
        sao2Memory3.miniCharaCountSum = sao2.miniCharaCountSum
        sao2Memory3.motherMiniCharaCount1 = sao2.motherMiniCharaCount1
        sao2Memory3.motherMiniCharaCount2 = sao2.motherMiniCharaCount2
        sao2Memory3.motherMiniCharaCount3 = sao2.motherMiniCharaCount3
        sao2Memory3.motherMiniCharaCount4 = sao2.motherMiniCharaCount4
        sao2Memory3.motherMiniCharaCount5 = sao2.motherMiniCharaCount5
        sao2Memory3.motherMiniCharaCount6 = sao2.motherMiniCharaCount6
        sao2Memory3.motherMiniCharaCount7 = sao2.motherMiniCharaCount7
        sao2Memory3.motherMiniCharaCount8 = sao2.motherMiniCharaCount8
        sao2Memory3.motherMiniCharaCountSum = sao2.motherMiniCharaCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct sao2SubViewLoadMemory: View {
    @ObservedObject var sao2: Sao2
    @ObservedObject var sao2Memory1: Sao2Memory1
    @ObservedObject var sao2Memory2: Sao2Memory2
    @ObservedObject var sao2Memory3: Sao2Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: sao2.machineName,
            selectedMemory: $sao2.selectedMemory,
            memoMemory1: sao2Memory1.memo,
            dateDoubleMemory1: sao2Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: sao2Memory2.memo,
            dateDoubleMemory2: sao2Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: sao2Memory3.memo,
            dateDoubleMemory3: sao2Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        sao2.lowSuikaCount = sao2Memory1.lowSuikaCount
        sao2.lowSuikaCountShootingHit = sao2Memory1.lowSuikaCountShootingHit
        sao2.kyoCherryCount = sao2Memory1.kyoCherryCount
        sao2.kyoCherryCountCzHit = sao2Memory1.kyoCherryCountCzHit
        sao2.highKyoCherryCount = sao2Memory1.highKyoCherryCount
        sao2.highKyoCherryCountCzHit = sao2Memory1.highKyoCherryCountCzHit
        sao2.czItemCountMiss = sao2Memory1.czItemCountMiss
        sao2.czItemCountHit = sao2Memory1.czItemCountHit
        sao2.czItemCountSum = sao2Memory1.czItemCountSum
        sao2.czKettouCountMiss = sao2Memory1.czKettouCountMiss
        sao2.czKettouCountHit = sao2Memory1.czKettouCountHit
        sao2.czKettouCountSum = sao2Memory1.czKettouCountSum
        sao2.normalGame = sao2Memory1.normalGame
        sao2.firstHitCountCz = sao2Memory1.firstHitCountCz
        sao2.firstHitCountAt = sao2Memory1.firstHitCountAt
        sao2.screenCount1 = sao2Memory1.screenCount1
        sao2.screenCount2 = sao2Memory1.screenCount2
        sao2.screenCount3 = sao2Memory1.screenCount3
        sao2.screenCount4 = sao2Memory1.screenCount4
        sao2.screenCount5 = sao2Memory1.screenCount5
        sao2.screenCount6 = sao2Memory1.screenCount6
        sao2.screenCount7 = sao2Memory1.screenCount7
        sao2.screenCount8 = sao2Memory1.screenCount8
        sao2.screenCount9 = sao2Memory1.screenCount9
        sao2.screenCount10 = sao2Memory1.screenCount10
        sao2.screenCountSum = sao2Memory1.screenCountSum
        sao2.comeBackCountMiss = sao2Memory1.comeBackCountMiss
        sao2.comeBackCountHit = sao2Memory1.comeBackCountHit
        sao2.comeBackCountSum = sao2Memory1.comeBackCountSum
        sao2.miniCharaCount1 = sao2Memory1.miniCharaCount1
        sao2.miniCharaCount2 = sao2Memory1.miniCharaCount2
        sao2.miniCharaCount3 = sao2Memory1.miniCharaCount3
        sao2.miniCharaCount4 = sao2Memory1.miniCharaCount4
        sao2.miniCharaCount5 = sao2Memory1.miniCharaCount5
        sao2.miniCharaCount6 = sao2Memory1.miniCharaCount6
        sao2.miniCharaCount7 = sao2Memory1.miniCharaCount7
        sao2.miniCharaCount8 = sao2Memory1.miniCharaCount8
        sao2.miniCharaCountSum = sao2Memory1.miniCharaCountSum
        sao2.motherMiniCharaCount1 = sao2Memory1.motherMiniCharaCount1
        sao2.motherMiniCharaCount2 = sao2Memory1.motherMiniCharaCount2
        sao2.motherMiniCharaCount3 = sao2Memory1.motherMiniCharaCount3
        sao2.motherMiniCharaCount4 = sao2Memory1.motherMiniCharaCount4
        sao2.motherMiniCharaCount5 = sao2Memory1.motherMiniCharaCount5
        sao2.motherMiniCharaCount6 = sao2Memory1.motherMiniCharaCount6
        sao2.motherMiniCharaCount7 = sao2Memory1.motherMiniCharaCount7
        sao2.motherMiniCharaCount8 = sao2Memory1.motherMiniCharaCount8
        sao2.motherMiniCharaCountSum = sao2Memory1.motherMiniCharaCountSum
    }
    func loadMemory2() {
        sao2.lowSuikaCount = sao2Memory2.lowSuikaCount
        sao2.lowSuikaCountShootingHit = sao2Memory2.lowSuikaCountShootingHit
        sao2.kyoCherryCount = sao2Memory2.kyoCherryCount
        sao2.kyoCherryCountCzHit = sao2Memory2.kyoCherryCountCzHit
        sao2.highKyoCherryCount = sao2Memory2.highKyoCherryCount
        sao2.highKyoCherryCountCzHit = sao2Memory2.highKyoCherryCountCzHit
        sao2.czItemCountMiss = sao2Memory2.czItemCountMiss
        sao2.czItemCountHit = sao2Memory2.czItemCountHit
        sao2.czItemCountSum = sao2Memory2.czItemCountSum
        sao2.czKettouCountMiss = sao2Memory2.czKettouCountMiss
        sao2.czKettouCountHit = sao2Memory2.czKettouCountHit
        sao2.czKettouCountSum = sao2Memory2.czKettouCountSum
        sao2.normalGame = sao2Memory2.normalGame
        sao2.firstHitCountCz = sao2Memory2.firstHitCountCz
        sao2.firstHitCountAt = sao2Memory2.firstHitCountAt
        sao2.screenCount1 = sao2Memory2.screenCount1
        sao2.screenCount2 = sao2Memory2.screenCount2
        sao2.screenCount3 = sao2Memory2.screenCount3
        sao2.screenCount4 = sao2Memory2.screenCount4
        sao2.screenCount5 = sao2Memory2.screenCount5
        sao2.screenCount6 = sao2Memory2.screenCount6
        sao2.screenCount7 = sao2Memory2.screenCount7
        sao2.screenCount8 = sao2Memory2.screenCount8
        sao2.screenCount9 = sao2Memory2.screenCount9
        sao2.screenCount10 = sao2Memory2.screenCount10
        sao2.screenCountSum = sao2Memory2.screenCountSum
        sao2.comeBackCountMiss = sao2Memory2.comeBackCountMiss
        sao2.comeBackCountHit = sao2Memory2.comeBackCountHit
        sao2.comeBackCountSum = sao2Memory2.comeBackCountSum
        sao2.miniCharaCount1 = sao2Memory2.miniCharaCount1
        sao2.miniCharaCount2 = sao2Memory2.miniCharaCount2
        sao2.miniCharaCount3 = sao2Memory2.miniCharaCount3
        sao2.miniCharaCount4 = sao2Memory2.miniCharaCount4
        sao2.miniCharaCount5 = sao2Memory2.miniCharaCount5
        sao2.miniCharaCount6 = sao2Memory2.miniCharaCount6
        sao2.miniCharaCount7 = sao2Memory2.miniCharaCount7
        sao2.miniCharaCount8 = sao2Memory2.miniCharaCount8
        sao2.miniCharaCountSum = sao2Memory2.miniCharaCountSum
        sao2.motherMiniCharaCount1 = sao2Memory2.motherMiniCharaCount1
        sao2.motherMiniCharaCount2 = sao2Memory2.motherMiniCharaCount2
        sao2.motherMiniCharaCount3 = sao2Memory2.motherMiniCharaCount3
        sao2.motherMiniCharaCount4 = sao2Memory2.motherMiniCharaCount4
        sao2.motherMiniCharaCount5 = sao2Memory2.motherMiniCharaCount5
        sao2.motherMiniCharaCount6 = sao2Memory2.motherMiniCharaCount6
        sao2.motherMiniCharaCount7 = sao2Memory2.motherMiniCharaCount7
        sao2.motherMiniCharaCount8 = sao2Memory2.motherMiniCharaCount8
        sao2.motherMiniCharaCountSum = sao2Memory2.motherMiniCharaCountSum
    }
    func loadMemory3() {
        sao2.lowSuikaCount = sao2Memory3.lowSuikaCount
        sao2.lowSuikaCountShootingHit = sao2Memory3.lowSuikaCountShootingHit
        sao2.kyoCherryCount = sao2Memory3.kyoCherryCount
        sao2.kyoCherryCountCzHit = sao2Memory3.kyoCherryCountCzHit
        sao2.highKyoCherryCount = sao2Memory3.highKyoCherryCount
        sao2.highKyoCherryCountCzHit = sao2Memory3.highKyoCherryCountCzHit
        sao2.czItemCountMiss = sao2Memory3.czItemCountMiss
        sao2.czItemCountHit = sao2Memory3.czItemCountHit
        sao2.czItemCountSum = sao2Memory3.czItemCountSum
        sao2.czKettouCountMiss = sao2Memory3.czKettouCountMiss
        sao2.czKettouCountHit = sao2Memory3.czKettouCountHit
        sao2.czKettouCountSum = sao2Memory3.czKettouCountSum
        sao2.normalGame = sao2Memory3.normalGame
        sao2.firstHitCountCz = sao2Memory3.firstHitCountCz
        sao2.firstHitCountAt = sao2Memory3.firstHitCountAt
        sao2.screenCount1 = sao2Memory3.screenCount1
        sao2.screenCount2 = sao2Memory3.screenCount2
        sao2.screenCount3 = sao2Memory3.screenCount3
        sao2.screenCount4 = sao2Memory3.screenCount4
        sao2.screenCount5 = sao2Memory3.screenCount5
        sao2.screenCount6 = sao2Memory3.screenCount6
        sao2.screenCount7 = sao2Memory3.screenCount7
        sao2.screenCount8 = sao2Memory3.screenCount8
        sao2.screenCount9 = sao2Memory3.screenCount9
        sao2.screenCount10 = sao2Memory3.screenCount10
        sao2.screenCountSum = sao2Memory3.screenCountSum
        sao2.comeBackCountMiss = sao2Memory3.comeBackCountMiss
        sao2.comeBackCountHit = sao2Memory3.comeBackCountHit
        sao2.comeBackCountSum = sao2Memory3.comeBackCountSum
        sao2.miniCharaCount1 = sao2Memory3.miniCharaCount1
        sao2.miniCharaCount2 = sao2Memory3.miniCharaCount2
        sao2.miniCharaCount3 = sao2Memory3.miniCharaCount3
        sao2.miniCharaCount4 = sao2Memory3.miniCharaCount4
        sao2.miniCharaCount5 = sao2Memory3.miniCharaCount5
        sao2.miniCharaCount6 = sao2Memory3.miniCharaCount6
        sao2.miniCharaCount7 = sao2Memory3.miniCharaCount7
        sao2.miniCharaCount8 = sao2Memory3.miniCharaCount8
        sao2.miniCharaCountSum = sao2Memory3.miniCharaCountSum
        sao2.motherMiniCharaCount1 = sao2Memory3.motherMiniCharaCount1
        sao2.motherMiniCharaCount2 = sao2Memory3.motherMiniCharaCount2
        sao2.motherMiniCharaCount3 = sao2Memory3.motherMiniCharaCount3
        sao2.motherMiniCharaCount4 = sao2Memory3.motherMiniCharaCount4
        sao2.motherMiniCharaCount5 = sao2Memory3.motherMiniCharaCount5
        sao2.motherMiniCharaCount6 = sao2Memory3.motherMiniCharaCount6
        sao2.motherMiniCharaCount7 = sao2Memory3.motherMiniCharaCount7
        sao2.motherMiniCharaCount8 = sao2Memory3.motherMiniCharaCount8
        sao2.motherMiniCharaCountSum = sao2Memory3.motherMiniCharaCountSum
    }
}

#Preview {
    sao2ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
