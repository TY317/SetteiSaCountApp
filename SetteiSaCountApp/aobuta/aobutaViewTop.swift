//
//  aobutaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct aobutaViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var aobuta = Aobuta()
    @State var isShowAlert: Bool = false
    @StateObject var aobutaMemory1 = AobutaMemory1()
    @StateObject var aobutaMemory2 = AobutaMemory2()
    @StateObject var aobutaMemory3 = AobutaMemory3()
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
                        machineName: aobuta.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: aobutaViewNormal(
                        aobuta: aobuta,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.aobutaMenuNormalBadge,
                        )
                    }

                    // CZ
                    NavigationLink(destination: aobutaViewCz(
                        aobuta: aobuta,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "scope",
                            textBody: "CZ",
                            badgeStatus: common.aobutaMenuCzBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: aobutaViewFirstHit(
                        aobuta: aobuta,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.aobutaMenuFirstHitBadge,
                        )
                    }

                    // ST中
                    NavigationLink(destination: aobutaViewDuringSt(
                        aobuta: aobuta,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "hare.fill",
                            textBody: "ST中",
                            badgeStatus: common.aobutaMenuDuringStBadge,
                        )
                    }

                    // ST終了画面
                    NavigationLink(destination: aobutaViewScreen(
                        aobuta: aobuta,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ST終了画面",
                            badgeStatus: common.aobutaMenuScreenBadge,
                        )
                    }

                    // 隠れ凪
                    NavigationLink(destination: commonViewKakureNagi()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "隠れ凪"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: aobuta.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: aobutaView95Ci(
                    aobuta: aobuta,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: aobutaViewBayes(
                    aobuta: aobuta,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.aobutaMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5064")

                // コピーライト
                unitSectionCopyright {
                    Text("©2022 鴨志田 一/KADOKAWA/青ブタ Project")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5064")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: aobuta.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(aobutaSubViewLoadMemory(
                    aobuta: aobuta,
                    aobutaMemory1: aobutaMemory1,
                    aobutaMemory2: aobutaMemory2,
                    aobutaMemory3: aobutaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(aobutaSubViewSaveMemory(
                    aobuta: aobuta,
                    aobutaMemory1: aobutaMemory1,
                    aobutaMemory2: aobutaMemory2,
                    aobutaMemory3: aobutaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: aobuta.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct aobutaSubViewSaveMemory: View {
    @ObservedObject var aobuta: Aobuta
    @ObservedObject var aobutaMemory1: AobutaMemory1
    @ObservedObject var aobutaMemory2: AobutaMemory2
    @ObservedObject var aobutaMemory3: AobutaMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: aobuta.machineName,
            selectedMemory: $aobuta.selectedMemory,
            memoMemory1: $aobutaMemory1.memo,
            dateDoubleMemory1: $aobutaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $aobutaMemory2.memo,
            dateDoubleMemory2: $aobutaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $aobutaMemory3.memo,
            dateDoubleMemory3: $aobutaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        aobutaMemory1.aoharuCount = aobuta.aoharuCount
        aobutaMemory1.aoharuGame = aobuta.aoharuGame
        aobutaMemory1.aoharuCherryCount = aobuta.aoharuCherryCount
        aobutaMemory1.aoharuCherryCountHit = aobuta.aoharuCherryCountHit
        aobutaMemory1.aoharuChanceCount = aobuta.aoharuChanceCount
        aobutaMemory1.aoharuChanceCountHit = aobuta.aoharuChanceCountHit
        aobutaMemory1.normalGame = aobuta.normalGame
        aobutaMemory1.firstHitCountSt = aobuta.firstHitCountSt
        aobutaMemory1.czKogaReplayCountMiss = aobuta.czKogaReplayCountMiss
        aobutaMemory1.czKogaReplayCountHit = aobuta.czKogaReplayCountHit
        aobutaMemory1.czKogaReplayCountSum = aobuta.czKogaReplayCountSum
        aobutaMemory1.czKogaBellCountMiss = aobuta.czKogaBellCountMiss
        aobutaMemory1.czKogaBellCountHit = aobuta.czKogaBellCountHit
        aobutaMemory1.czKogaBellCountSum = aobuta.czKogaBellCountSum
        aobutaMemory1.czKogaCherryCountMiss = aobuta.czKogaCherryCountMiss
        aobutaMemory1.czKogaCherryCountHit = aobuta.czKogaCherryCountHit
        aobutaMemory1.czKogaCherryCountSum = aobuta.czKogaCherryCountSum
        aobutaMemory1.czKogaChanceCountMiss = aobuta.czKogaChanceCountMiss
        aobutaMemory1.czKogaChanceCountHit = aobuta.czKogaChanceCountHit
        aobutaMemory1.czKogaChanceCountSum = aobuta.czKogaChanceCountSum
        aobutaMemory1.czNodokaReplayCountMiss = aobuta.czNodokaReplayCountMiss
        aobutaMemory1.czNodokaReplayCountHit = aobuta.czNodokaReplayCountHit
        aobutaMemory1.czNodokaReplayCountSum = aobuta.czNodokaReplayCountSum
        aobutaMemory1.czNodokaBellCountMiss = aobuta.czNodokaBellCountMiss
        aobutaMemory1.czNodokaBellCountHit = aobuta.czNodokaBellCountHit
        aobutaMemory1.czNodokaBellCountSum = aobuta.czNodokaBellCountSum
        aobutaMemory1.czNodokaSuikaCherryCountMiss = aobuta.czNodokaSuikaCherryCountMiss
        aobutaMemory1.czNodokaSuikaCherryCountHit = aobuta.czNodokaSuikaCherryCountHit
        aobutaMemory1.czNodokaSuikaCherryCountSum = aobuta.czNodokaSuikaCherryCountSum
        aobutaMemory1.czNodokaChanceCountMiss = aobuta.czNodokaChanceCountMiss
        aobutaMemory1.czNodokaChanceCountHit = aobuta.czNodokaChanceCountHit
        aobutaMemory1.czNodokaChanceCountSum = aobuta.czNodokaChanceCountSum
        aobutaMemory1.czRioReplayCountMiss = aobuta.czRioReplayCountMiss
        aobutaMemory1.czRioReplayCountHit = aobuta.czRioReplayCountHit
        aobutaMemory1.czRioReplayCountSum = aobuta.czRioReplayCountSum
        aobutaMemory1.czRioBellCountMiss = aobuta.czRioBellCountMiss
        aobutaMemory1.czRioBellCountHit = aobuta.czRioBellCountHit
        aobutaMemory1.czRioBellCountSum = aobuta.czRioBellCountSum
        aobutaMemory1.czRioSuikaCountMiss = aobuta.czRioSuikaCountMiss
        aobutaMemory1.czRioSuikaCountHit = aobuta.czRioSuikaCountHit
        aobutaMemory1.czRioSuikaCountSum = aobuta.czRioSuikaCountSum
        aobutaMemory1.czRioChanceCountMiss = aobuta.czRioChanceCountMiss
        aobutaMemory1.czRioChanceCountHit = aobuta.czRioChanceCountHit
        aobutaMemory1.czRioChanceCountSum = aobuta.czRioChanceCountSum
        aobutaMemory1.czMaiReplayCountMiss = aobuta.czMaiReplayCountMiss
        aobutaMemory1.czMaiReplayCountHit = aobuta.czMaiReplayCountHit
        aobutaMemory1.czMaiReplayCountSum = aobuta.czMaiReplayCountSum
        aobutaMemory1.czMaiBellCountMiss = aobuta.czMaiBellCountMiss
        aobutaMemory1.czMaiBellCountHit = aobuta.czMaiBellCountHit
        aobutaMemory1.czMaiBellCountSum = aobuta.czMaiBellCountSum
        aobutaMemory1.czMaiSuikaCountMiss = aobuta.czMaiSuikaCountMiss
        aobutaMemory1.czMaiSuikaCountHit = aobuta.czMaiSuikaCountHit
        aobutaMemory1.czMaiSuikaCountSum = aobuta.czMaiSuikaCountSum
        aobutaMemory1.czMaiCherryCountMiss = aobuta.czMaiCherryCountMiss
        aobutaMemory1.czMaiCherryCountHit = aobuta.czMaiCherryCountHit
        aobutaMemory1.czMaiCherryCountSum = aobuta.czMaiCherryCountSum
        aobutaMemory1.czKaedeReplayCountMiss = aobuta.czKaedeReplayCountMiss
        aobutaMemory1.czKaedeReplayCountHit = aobuta.czKaedeReplayCountHit
        aobutaMemory1.czKaedeReplayCountSum = aobuta.czKaedeReplayCountSum
        aobutaMemory1.czKaedeBellCountMiss = aobuta.czKaedeBellCountMiss
        aobutaMemory1.czKaedeBellCountHit = aobuta.czKaedeBellCountHit
        aobutaMemory1.czKaedeBellCountSum = aobuta.czKaedeBellCountSum
        aobutaMemory1.czShokoReplayCountMiss = aobuta.czShokoReplayCountMiss
        aobutaMemory1.czShokoReplayCountHit = aobuta.czShokoReplayCountHit
        aobutaMemory1.czShokoReplayCountSum = aobuta.czShokoReplayCountSum
        aobutaMemory1.czShokoBellCountMiss = aobuta.czShokoBellCountMiss
        aobutaMemory1.czShokoBellCountHit = aobuta.czShokoBellCountHit
        aobutaMemory1.czShokoBellCountSum = aobuta.czShokoBellCountSum
        aobutaMemory1.screenCount1 = aobuta.screenCount1
        aobutaMemory1.screenCount2 = aobuta.screenCount2
        aobutaMemory1.screenCount3 = aobuta.screenCount3
        aobutaMemory1.screenCount4 = aobuta.screenCount4
        aobutaMemory1.screenCount5 = aobuta.screenCount5
        aobutaMemory1.screenCountSum = aobuta.screenCountSum
        aobutaMemory1.syndromeCountMiss = aobuta.syndromeCountMiss
        aobutaMemory1.syndromeCountHit = aobuta.syndromeCountHit
        aobutaMemory1.syndromeCountSum = aobuta.syndromeCountSum
    }
    func saveMemory2() {
        aobutaMemory2.aoharuCount = aobuta.aoharuCount
        aobutaMemory2.aoharuGame = aobuta.aoharuGame
        aobutaMemory2.aoharuCherryCount = aobuta.aoharuCherryCount
        aobutaMemory2.aoharuCherryCountHit = aobuta.aoharuCherryCountHit
        aobutaMemory2.aoharuChanceCount = aobuta.aoharuChanceCount
        aobutaMemory2.aoharuChanceCountHit = aobuta.aoharuChanceCountHit
        aobutaMemory2.normalGame = aobuta.normalGame
        aobutaMemory2.firstHitCountSt = aobuta.firstHitCountSt
        aobutaMemory2.czKogaReplayCountMiss = aobuta.czKogaReplayCountMiss
        aobutaMemory2.czKogaReplayCountHit = aobuta.czKogaReplayCountHit
        aobutaMemory2.czKogaReplayCountSum = aobuta.czKogaReplayCountSum
        aobutaMemory2.czKogaBellCountMiss = aobuta.czKogaBellCountMiss
        aobutaMemory2.czKogaBellCountHit = aobuta.czKogaBellCountHit
        aobutaMemory2.czKogaBellCountSum = aobuta.czKogaBellCountSum
        aobutaMemory2.czKogaCherryCountMiss = aobuta.czKogaCherryCountMiss
        aobutaMemory2.czKogaCherryCountHit = aobuta.czKogaCherryCountHit
        aobutaMemory2.czKogaCherryCountSum = aobuta.czKogaCherryCountSum
        aobutaMemory2.czKogaChanceCountMiss = aobuta.czKogaChanceCountMiss
        aobutaMemory2.czKogaChanceCountHit = aobuta.czKogaChanceCountHit
        aobutaMemory2.czKogaChanceCountSum = aobuta.czKogaChanceCountSum
        aobutaMemory2.czNodokaReplayCountMiss = aobuta.czNodokaReplayCountMiss
        aobutaMemory2.czNodokaReplayCountHit = aobuta.czNodokaReplayCountHit
        aobutaMemory2.czNodokaReplayCountSum = aobuta.czNodokaReplayCountSum
        aobutaMemory2.czNodokaBellCountMiss = aobuta.czNodokaBellCountMiss
        aobutaMemory2.czNodokaBellCountHit = aobuta.czNodokaBellCountHit
        aobutaMemory2.czNodokaBellCountSum = aobuta.czNodokaBellCountSum
        aobutaMemory2.czNodokaSuikaCherryCountMiss = aobuta.czNodokaSuikaCherryCountMiss
        aobutaMemory2.czNodokaSuikaCherryCountHit = aobuta.czNodokaSuikaCherryCountHit
        aobutaMemory2.czNodokaSuikaCherryCountSum = aobuta.czNodokaSuikaCherryCountSum
        aobutaMemory2.czNodokaChanceCountMiss = aobuta.czNodokaChanceCountMiss
        aobutaMemory2.czNodokaChanceCountHit = aobuta.czNodokaChanceCountHit
        aobutaMemory2.czNodokaChanceCountSum = aobuta.czNodokaChanceCountSum
        aobutaMemory2.czRioReplayCountMiss = aobuta.czRioReplayCountMiss
        aobutaMemory2.czRioReplayCountHit = aobuta.czRioReplayCountHit
        aobutaMemory2.czRioReplayCountSum = aobuta.czRioReplayCountSum
        aobutaMemory2.czRioBellCountMiss = aobuta.czRioBellCountMiss
        aobutaMemory2.czRioBellCountHit = aobuta.czRioBellCountHit
        aobutaMemory2.czRioBellCountSum = aobuta.czRioBellCountSum
        aobutaMemory2.czRioSuikaCountMiss = aobuta.czRioSuikaCountMiss
        aobutaMemory2.czRioSuikaCountHit = aobuta.czRioSuikaCountHit
        aobutaMemory2.czRioSuikaCountSum = aobuta.czRioSuikaCountSum
        aobutaMemory2.czRioChanceCountMiss = aobuta.czRioChanceCountMiss
        aobutaMemory2.czRioChanceCountHit = aobuta.czRioChanceCountHit
        aobutaMemory2.czRioChanceCountSum = aobuta.czRioChanceCountSum
        aobutaMemory2.czMaiReplayCountMiss = aobuta.czMaiReplayCountMiss
        aobutaMemory2.czMaiReplayCountHit = aobuta.czMaiReplayCountHit
        aobutaMemory2.czMaiReplayCountSum = aobuta.czMaiReplayCountSum
        aobutaMemory2.czMaiBellCountMiss = aobuta.czMaiBellCountMiss
        aobutaMemory2.czMaiBellCountHit = aobuta.czMaiBellCountHit
        aobutaMemory2.czMaiBellCountSum = aobuta.czMaiBellCountSum
        aobutaMemory2.czMaiSuikaCountMiss = aobuta.czMaiSuikaCountMiss
        aobutaMemory2.czMaiSuikaCountHit = aobuta.czMaiSuikaCountHit
        aobutaMemory2.czMaiSuikaCountSum = aobuta.czMaiSuikaCountSum
        aobutaMemory2.czMaiCherryCountMiss = aobuta.czMaiCherryCountMiss
        aobutaMemory2.czMaiCherryCountHit = aobuta.czMaiCherryCountHit
        aobutaMemory2.czMaiCherryCountSum = aobuta.czMaiCherryCountSum
        aobutaMemory2.czKaedeReplayCountMiss = aobuta.czKaedeReplayCountMiss
        aobutaMemory2.czKaedeReplayCountHit = aobuta.czKaedeReplayCountHit
        aobutaMemory2.czKaedeReplayCountSum = aobuta.czKaedeReplayCountSum
        aobutaMemory2.czKaedeBellCountMiss = aobuta.czKaedeBellCountMiss
        aobutaMemory2.czKaedeBellCountHit = aobuta.czKaedeBellCountHit
        aobutaMemory2.czKaedeBellCountSum = aobuta.czKaedeBellCountSum
        aobutaMemory2.czShokoReplayCountMiss = aobuta.czShokoReplayCountMiss
        aobutaMemory2.czShokoReplayCountHit = aobuta.czShokoReplayCountHit
        aobutaMemory2.czShokoReplayCountSum = aobuta.czShokoReplayCountSum
        aobutaMemory2.czShokoBellCountMiss = aobuta.czShokoBellCountMiss
        aobutaMemory2.czShokoBellCountHit = aobuta.czShokoBellCountHit
        aobutaMemory2.czShokoBellCountSum = aobuta.czShokoBellCountSum
        aobutaMemory2.screenCount1 = aobuta.screenCount1
        aobutaMemory2.screenCount2 = aobuta.screenCount2
        aobutaMemory2.screenCount3 = aobuta.screenCount3
        aobutaMemory2.screenCount4 = aobuta.screenCount4
        aobutaMemory2.screenCount5 = aobuta.screenCount5
        aobutaMemory2.screenCountSum = aobuta.screenCountSum
        aobutaMemory2.syndromeCountMiss = aobuta.syndromeCountMiss
        aobutaMemory2.syndromeCountHit = aobuta.syndromeCountHit
        aobutaMemory2.syndromeCountSum = aobuta.syndromeCountSum
    }
    func saveMemory3() {
        aobutaMemory3.aoharuCount = aobuta.aoharuCount
        aobutaMemory3.aoharuGame = aobuta.aoharuGame
        aobutaMemory3.aoharuCherryCount = aobuta.aoharuCherryCount
        aobutaMemory3.aoharuCherryCountHit = aobuta.aoharuCherryCountHit
        aobutaMemory3.aoharuChanceCount = aobuta.aoharuChanceCount
        aobutaMemory3.aoharuChanceCountHit = aobuta.aoharuChanceCountHit
        aobutaMemory3.normalGame = aobuta.normalGame
        aobutaMemory3.firstHitCountSt = aobuta.firstHitCountSt
        aobutaMemory3.czKogaReplayCountMiss = aobuta.czKogaReplayCountMiss
        aobutaMemory3.czKogaReplayCountHit = aobuta.czKogaReplayCountHit
        aobutaMemory3.czKogaReplayCountSum = aobuta.czKogaReplayCountSum
        aobutaMemory3.czKogaBellCountMiss = aobuta.czKogaBellCountMiss
        aobutaMemory3.czKogaBellCountHit = aobuta.czKogaBellCountHit
        aobutaMemory3.czKogaBellCountSum = aobuta.czKogaBellCountSum
        aobutaMemory3.czKogaCherryCountMiss = aobuta.czKogaCherryCountMiss
        aobutaMemory3.czKogaCherryCountHit = aobuta.czKogaCherryCountHit
        aobutaMemory3.czKogaCherryCountSum = aobuta.czKogaCherryCountSum
        aobutaMemory3.czKogaChanceCountMiss = aobuta.czKogaChanceCountMiss
        aobutaMemory3.czKogaChanceCountHit = aobuta.czKogaChanceCountHit
        aobutaMemory3.czKogaChanceCountSum = aobuta.czKogaChanceCountSum
        aobutaMemory3.czNodokaReplayCountMiss = aobuta.czNodokaReplayCountMiss
        aobutaMemory3.czNodokaReplayCountHit = aobuta.czNodokaReplayCountHit
        aobutaMemory3.czNodokaReplayCountSum = aobuta.czNodokaReplayCountSum
        aobutaMemory3.czNodokaBellCountMiss = aobuta.czNodokaBellCountMiss
        aobutaMemory3.czNodokaBellCountHit = aobuta.czNodokaBellCountHit
        aobutaMemory3.czNodokaBellCountSum = aobuta.czNodokaBellCountSum
        aobutaMemory3.czNodokaSuikaCherryCountMiss = aobuta.czNodokaSuikaCherryCountMiss
        aobutaMemory3.czNodokaSuikaCherryCountHit = aobuta.czNodokaSuikaCherryCountHit
        aobutaMemory3.czNodokaSuikaCherryCountSum = aobuta.czNodokaSuikaCherryCountSum
        aobutaMemory3.czNodokaChanceCountMiss = aobuta.czNodokaChanceCountMiss
        aobutaMemory3.czNodokaChanceCountHit = aobuta.czNodokaChanceCountHit
        aobutaMemory3.czNodokaChanceCountSum = aobuta.czNodokaChanceCountSum
        aobutaMemory3.czRioReplayCountMiss = aobuta.czRioReplayCountMiss
        aobutaMemory3.czRioReplayCountHit = aobuta.czRioReplayCountHit
        aobutaMemory3.czRioReplayCountSum = aobuta.czRioReplayCountSum
        aobutaMemory3.czRioBellCountMiss = aobuta.czRioBellCountMiss
        aobutaMemory3.czRioBellCountHit = aobuta.czRioBellCountHit
        aobutaMemory3.czRioBellCountSum = aobuta.czRioBellCountSum
        aobutaMemory3.czRioSuikaCountMiss = aobuta.czRioSuikaCountMiss
        aobutaMemory3.czRioSuikaCountHit = aobuta.czRioSuikaCountHit
        aobutaMemory3.czRioSuikaCountSum = aobuta.czRioSuikaCountSum
        aobutaMemory3.czRioChanceCountMiss = aobuta.czRioChanceCountMiss
        aobutaMemory3.czRioChanceCountHit = aobuta.czRioChanceCountHit
        aobutaMemory3.czRioChanceCountSum = aobuta.czRioChanceCountSum
        aobutaMemory3.czMaiReplayCountMiss = aobuta.czMaiReplayCountMiss
        aobutaMemory3.czMaiReplayCountHit = aobuta.czMaiReplayCountHit
        aobutaMemory3.czMaiReplayCountSum = aobuta.czMaiReplayCountSum
        aobutaMemory3.czMaiBellCountMiss = aobuta.czMaiBellCountMiss
        aobutaMemory3.czMaiBellCountHit = aobuta.czMaiBellCountHit
        aobutaMemory3.czMaiBellCountSum = aobuta.czMaiBellCountSum
        aobutaMemory3.czMaiSuikaCountMiss = aobuta.czMaiSuikaCountMiss
        aobutaMemory3.czMaiSuikaCountHit = aobuta.czMaiSuikaCountHit
        aobutaMemory3.czMaiSuikaCountSum = aobuta.czMaiSuikaCountSum
        aobutaMemory3.czMaiCherryCountMiss = aobuta.czMaiCherryCountMiss
        aobutaMemory3.czMaiCherryCountHit = aobuta.czMaiCherryCountHit
        aobutaMemory3.czMaiCherryCountSum = aobuta.czMaiCherryCountSum
        aobutaMemory3.czKaedeReplayCountMiss = aobuta.czKaedeReplayCountMiss
        aobutaMemory3.czKaedeReplayCountHit = aobuta.czKaedeReplayCountHit
        aobutaMemory3.czKaedeReplayCountSum = aobuta.czKaedeReplayCountSum
        aobutaMemory3.czKaedeBellCountMiss = aobuta.czKaedeBellCountMiss
        aobutaMemory3.czKaedeBellCountHit = aobuta.czKaedeBellCountHit
        aobutaMemory3.czKaedeBellCountSum = aobuta.czKaedeBellCountSum
        aobutaMemory3.czShokoReplayCountMiss = aobuta.czShokoReplayCountMiss
        aobutaMemory3.czShokoReplayCountHit = aobuta.czShokoReplayCountHit
        aobutaMemory3.czShokoReplayCountSum = aobuta.czShokoReplayCountSum
        aobutaMemory3.czShokoBellCountMiss = aobuta.czShokoBellCountMiss
        aobutaMemory3.czShokoBellCountHit = aobuta.czShokoBellCountHit
        aobutaMemory3.czShokoBellCountSum = aobuta.czShokoBellCountSum
        aobutaMemory3.screenCount1 = aobuta.screenCount1
        aobutaMemory3.screenCount2 = aobuta.screenCount2
        aobutaMemory3.screenCount3 = aobuta.screenCount3
        aobutaMemory3.screenCount4 = aobuta.screenCount4
        aobutaMemory3.screenCount5 = aobuta.screenCount5
        aobutaMemory3.screenCountSum = aobuta.screenCountSum
        aobutaMemory3.syndromeCountMiss = aobuta.syndromeCountMiss
        aobutaMemory3.syndromeCountHit = aobuta.syndromeCountHit
        aobutaMemory3.syndromeCountSum = aobuta.syndromeCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct aobutaSubViewLoadMemory: View {
    @ObservedObject var aobuta: Aobuta
    @ObservedObject var aobutaMemory1: AobutaMemory1
    @ObservedObject var aobutaMemory2: AobutaMemory2
    @ObservedObject var aobutaMemory3: AobutaMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: aobuta.machineName,
            selectedMemory: $aobuta.selectedMemory,
            memoMemory1: aobutaMemory1.memo,
            dateDoubleMemory1: aobutaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: aobutaMemory2.memo,
            dateDoubleMemory2: aobutaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: aobutaMemory3.memo,
            dateDoubleMemory3: aobutaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        aobuta.aoharuCount = aobutaMemory1.aoharuCount
        aobuta.aoharuGame = aobutaMemory1.aoharuGame
        aobuta.aoharuCherryCount = aobutaMemory1.aoharuCherryCount
        aobuta.aoharuCherryCountHit = aobutaMemory1.aoharuCherryCountHit
        aobuta.aoharuChanceCount = aobutaMemory1.aoharuChanceCount
        aobuta.aoharuChanceCountHit = aobutaMemory1.aoharuChanceCountHit
        aobuta.normalGame = aobutaMemory1.normalGame
        aobuta.firstHitCountSt = aobutaMemory1.firstHitCountSt
        aobuta.czKogaReplayCountMiss = aobutaMemory1.czKogaReplayCountMiss
        aobuta.czKogaReplayCountHit = aobutaMemory1.czKogaReplayCountHit
        aobuta.czKogaReplayCountSum = aobutaMemory1.czKogaReplayCountSum
        aobuta.czKogaBellCountMiss = aobutaMemory1.czKogaBellCountMiss
        aobuta.czKogaBellCountHit = aobutaMemory1.czKogaBellCountHit
        aobuta.czKogaBellCountSum = aobutaMemory1.czKogaBellCountSum
        aobuta.czKogaCherryCountMiss = aobutaMemory1.czKogaCherryCountMiss
        aobuta.czKogaCherryCountHit = aobutaMemory1.czKogaCherryCountHit
        aobuta.czKogaCherryCountSum = aobutaMemory1.czKogaCherryCountSum
        aobuta.czKogaChanceCountMiss = aobutaMemory1.czKogaChanceCountMiss
        aobuta.czKogaChanceCountHit = aobutaMemory1.czKogaChanceCountHit
        aobuta.czKogaChanceCountSum = aobutaMemory1.czKogaChanceCountSum
        aobuta.czNodokaReplayCountMiss = aobutaMemory1.czNodokaReplayCountMiss
        aobuta.czNodokaReplayCountHit = aobutaMemory1.czNodokaReplayCountHit
        aobuta.czNodokaReplayCountSum = aobutaMemory1.czNodokaReplayCountSum
        aobuta.czNodokaBellCountMiss = aobutaMemory1.czNodokaBellCountMiss
        aobuta.czNodokaBellCountHit = aobutaMemory1.czNodokaBellCountHit
        aobuta.czNodokaBellCountSum = aobutaMemory1.czNodokaBellCountSum
        aobuta.czNodokaSuikaCherryCountMiss = aobutaMemory1.czNodokaSuikaCherryCountMiss
        aobuta.czNodokaSuikaCherryCountHit = aobutaMemory1.czNodokaSuikaCherryCountHit
        aobuta.czNodokaSuikaCherryCountSum = aobutaMemory1.czNodokaSuikaCherryCountSum
        aobuta.czNodokaChanceCountMiss = aobutaMemory1.czNodokaChanceCountMiss
        aobuta.czNodokaChanceCountHit = aobutaMemory1.czNodokaChanceCountHit
        aobuta.czNodokaChanceCountSum = aobutaMemory1.czNodokaChanceCountSum
        aobuta.czRioReplayCountMiss = aobutaMemory1.czRioReplayCountMiss
        aobuta.czRioReplayCountHit = aobutaMemory1.czRioReplayCountHit
        aobuta.czRioReplayCountSum = aobutaMemory1.czRioReplayCountSum
        aobuta.czRioBellCountMiss = aobutaMemory1.czRioBellCountMiss
        aobuta.czRioBellCountHit = aobutaMemory1.czRioBellCountHit
        aobuta.czRioBellCountSum = aobutaMemory1.czRioBellCountSum
        aobuta.czRioSuikaCountMiss = aobutaMemory1.czRioSuikaCountMiss
        aobuta.czRioSuikaCountHit = aobutaMemory1.czRioSuikaCountHit
        aobuta.czRioSuikaCountSum = aobutaMemory1.czRioSuikaCountSum
        aobuta.czRioChanceCountMiss = aobutaMemory1.czRioChanceCountMiss
        aobuta.czRioChanceCountHit = aobutaMemory1.czRioChanceCountHit
        aobuta.czRioChanceCountSum = aobutaMemory1.czRioChanceCountSum
        aobuta.czMaiReplayCountMiss = aobutaMemory1.czMaiReplayCountMiss
        aobuta.czMaiReplayCountHit = aobutaMemory1.czMaiReplayCountHit
        aobuta.czMaiReplayCountSum = aobutaMemory1.czMaiReplayCountSum
        aobuta.czMaiBellCountMiss = aobutaMemory1.czMaiBellCountMiss
        aobuta.czMaiBellCountHit = aobutaMemory1.czMaiBellCountHit
        aobuta.czMaiBellCountSum = aobutaMemory1.czMaiBellCountSum
        aobuta.czMaiSuikaCountMiss = aobutaMemory1.czMaiSuikaCountMiss
        aobuta.czMaiSuikaCountHit = aobutaMemory1.czMaiSuikaCountHit
        aobuta.czMaiSuikaCountSum = aobutaMemory1.czMaiSuikaCountSum
        aobuta.czMaiCherryCountMiss = aobutaMemory1.czMaiCherryCountMiss
        aobuta.czMaiCherryCountHit = aobutaMemory1.czMaiCherryCountHit
        aobuta.czMaiCherryCountSum = aobutaMemory1.czMaiCherryCountSum
        aobuta.czKaedeReplayCountMiss = aobutaMemory1.czKaedeReplayCountMiss
        aobuta.czKaedeReplayCountHit = aobutaMemory1.czKaedeReplayCountHit
        aobuta.czKaedeReplayCountSum = aobutaMemory1.czKaedeReplayCountSum
        aobuta.czKaedeBellCountMiss = aobutaMemory1.czKaedeBellCountMiss
        aobuta.czKaedeBellCountHit = aobutaMemory1.czKaedeBellCountHit
        aobuta.czKaedeBellCountSum = aobutaMemory1.czKaedeBellCountSum
        aobuta.czShokoReplayCountMiss = aobutaMemory1.czShokoReplayCountMiss
        aobuta.czShokoReplayCountHit = aobutaMemory1.czShokoReplayCountHit
        aobuta.czShokoReplayCountSum = aobutaMemory1.czShokoReplayCountSum
        aobuta.czShokoBellCountMiss = aobutaMemory1.czShokoBellCountMiss
        aobuta.czShokoBellCountHit = aobutaMemory1.czShokoBellCountHit
        aobuta.czShokoBellCountSum = aobutaMemory1.czShokoBellCountSum
        aobuta.screenCount1 = aobutaMemory1.screenCount1
        aobuta.screenCount2 = aobutaMemory1.screenCount2
        aobuta.screenCount3 = aobutaMemory1.screenCount3
        aobuta.screenCount4 = aobutaMemory1.screenCount4
        aobuta.screenCount5 = aobutaMemory1.screenCount5
        aobuta.screenCountSum = aobutaMemory1.screenCountSum
        aobuta.syndromeCountMiss = aobutaMemory1.syndromeCountMiss
        aobuta.syndromeCountHit = aobutaMemory1.syndromeCountHit
        aobuta.syndromeCountSum = aobutaMemory1.syndromeCountSum
    }
    func loadMemory2() {
        aobuta.aoharuCount = aobutaMemory2.aoharuCount
        aobuta.aoharuGame = aobutaMemory2.aoharuGame
        aobuta.aoharuCherryCount = aobutaMemory2.aoharuCherryCount
        aobuta.aoharuCherryCountHit = aobutaMemory2.aoharuCherryCountHit
        aobuta.aoharuChanceCount = aobutaMemory2.aoharuChanceCount
        aobuta.aoharuChanceCountHit = aobutaMemory2.aoharuChanceCountHit
        aobuta.normalGame = aobutaMemory2.normalGame
        aobuta.firstHitCountSt = aobutaMemory2.firstHitCountSt
        aobuta.czKogaReplayCountMiss = aobutaMemory2.czKogaReplayCountMiss
        aobuta.czKogaReplayCountHit = aobutaMemory2.czKogaReplayCountHit
        aobuta.czKogaReplayCountSum = aobutaMemory2.czKogaReplayCountSum
        aobuta.czKogaBellCountMiss = aobutaMemory2.czKogaBellCountMiss
        aobuta.czKogaBellCountHit = aobutaMemory2.czKogaBellCountHit
        aobuta.czKogaBellCountSum = aobutaMemory2.czKogaBellCountSum
        aobuta.czKogaCherryCountMiss = aobutaMemory2.czKogaCherryCountMiss
        aobuta.czKogaCherryCountHit = aobutaMemory2.czKogaCherryCountHit
        aobuta.czKogaCherryCountSum = aobutaMemory2.czKogaCherryCountSum
        aobuta.czKogaChanceCountMiss = aobutaMemory2.czKogaChanceCountMiss
        aobuta.czKogaChanceCountHit = aobutaMemory2.czKogaChanceCountHit
        aobuta.czKogaChanceCountSum = aobutaMemory2.czKogaChanceCountSum
        aobuta.czNodokaReplayCountMiss = aobutaMemory2.czNodokaReplayCountMiss
        aobuta.czNodokaReplayCountHit = aobutaMemory2.czNodokaReplayCountHit
        aobuta.czNodokaReplayCountSum = aobutaMemory2.czNodokaReplayCountSum
        aobuta.czNodokaBellCountMiss = aobutaMemory2.czNodokaBellCountMiss
        aobuta.czNodokaBellCountHit = aobutaMemory2.czNodokaBellCountHit
        aobuta.czNodokaBellCountSum = aobutaMemory2.czNodokaBellCountSum
        aobuta.czNodokaSuikaCherryCountMiss = aobutaMemory2.czNodokaSuikaCherryCountMiss
        aobuta.czNodokaSuikaCherryCountHit = aobutaMemory2.czNodokaSuikaCherryCountHit
        aobuta.czNodokaSuikaCherryCountSum = aobutaMemory2.czNodokaSuikaCherryCountSum
        aobuta.czNodokaChanceCountMiss = aobutaMemory2.czNodokaChanceCountMiss
        aobuta.czNodokaChanceCountHit = aobutaMemory2.czNodokaChanceCountHit
        aobuta.czNodokaChanceCountSum = aobutaMemory2.czNodokaChanceCountSum
        aobuta.czRioReplayCountMiss = aobutaMemory2.czRioReplayCountMiss
        aobuta.czRioReplayCountHit = aobutaMemory2.czRioReplayCountHit
        aobuta.czRioReplayCountSum = aobutaMemory2.czRioReplayCountSum
        aobuta.czRioBellCountMiss = aobutaMemory2.czRioBellCountMiss
        aobuta.czRioBellCountHit = aobutaMemory2.czRioBellCountHit
        aobuta.czRioBellCountSum = aobutaMemory2.czRioBellCountSum
        aobuta.czRioSuikaCountMiss = aobutaMemory2.czRioSuikaCountMiss
        aobuta.czRioSuikaCountHit = aobutaMemory2.czRioSuikaCountHit
        aobuta.czRioSuikaCountSum = aobutaMemory2.czRioSuikaCountSum
        aobuta.czRioChanceCountMiss = aobutaMemory2.czRioChanceCountMiss
        aobuta.czRioChanceCountHit = aobutaMemory2.czRioChanceCountHit
        aobuta.czRioChanceCountSum = aobutaMemory2.czRioChanceCountSum
        aobuta.czMaiReplayCountMiss = aobutaMemory2.czMaiReplayCountMiss
        aobuta.czMaiReplayCountHit = aobutaMemory2.czMaiReplayCountHit
        aobuta.czMaiReplayCountSum = aobutaMemory2.czMaiReplayCountSum
        aobuta.czMaiBellCountMiss = aobutaMemory2.czMaiBellCountMiss
        aobuta.czMaiBellCountHit = aobutaMemory2.czMaiBellCountHit
        aobuta.czMaiBellCountSum = aobutaMemory2.czMaiBellCountSum
        aobuta.czMaiSuikaCountMiss = aobutaMemory2.czMaiSuikaCountMiss
        aobuta.czMaiSuikaCountHit = aobutaMemory2.czMaiSuikaCountHit
        aobuta.czMaiSuikaCountSum = aobutaMemory2.czMaiSuikaCountSum
        aobuta.czMaiCherryCountMiss = aobutaMemory2.czMaiCherryCountMiss
        aobuta.czMaiCherryCountHit = aobutaMemory2.czMaiCherryCountHit
        aobuta.czMaiCherryCountSum = aobutaMemory2.czMaiCherryCountSum
        aobuta.czKaedeReplayCountMiss = aobutaMemory2.czKaedeReplayCountMiss
        aobuta.czKaedeReplayCountHit = aobutaMemory2.czKaedeReplayCountHit
        aobuta.czKaedeReplayCountSum = aobutaMemory2.czKaedeReplayCountSum
        aobuta.czKaedeBellCountMiss = aobutaMemory2.czKaedeBellCountMiss
        aobuta.czKaedeBellCountHit = aobutaMemory2.czKaedeBellCountHit
        aobuta.czKaedeBellCountSum = aobutaMemory2.czKaedeBellCountSum
        aobuta.czShokoReplayCountMiss = aobutaMemory2.czShokoReplayCountMiss
        aobuta.czShokoReplayCountHit = aobutaMemory2.czShokoReplayCountHit
        aobuta.czShokoReplayCountSum = aobutaMemory2.czShokoReplayCountSum
        aobuta.czShokoBellCountMiss = aobutaMemory2.czShokoBellCountMiss
        aobuta.czShokoBellCountHit = aobutaMemory2.czShokoBellCountHit
        aobuta.czShokoBellCountSum = aobutaMemory2.czShokoBellCountSum
        aobuta.screenCount1 = aobutaMemory2.screenCount1
        aobuta.screenCount2 = aobutaMemory2.screenCount2
        aobuta.screenCount3 = aobutaMemory2.screenCount3
        aobuta.screenCount4 = aobutaMemory2.screenCount4
        aobuta.screenCount5 = aobutaMemory2.screenCount5
        aobuta.screenCountSum = aobutaMemory2.screenCountSum
        aobuta.syndromeCountMiss = aobutaMemory2.syndromeCountMiss
        aobuta.syndromeCountHit = aobutaMemory2.syndromeCountHit
        aobuta.syndromeCountSum = aobutaMemory2.syndromeCountSum
    }
    func loadMemory3() {
        aobuta.aoharuCount = aobutaMemory3.aoharuCount
        aobuta.aoharuGame = aobutaMemory3.aoharuGame
        aobuta.aoharuCherryCount = aobutaMemory3.aoharuCherryCount
        aobuta.aoharuCherryCountHit = aobutaMemory3.aoharuCherryCountHit
        aobuta.aoharuChanceCount = aobutaMemory3.aoharuChanceCount
        aobuta.aoharuChanceCountHit = aobutaMemory3.aoharuChanceCountHit
        aobuta.normalGame = aobutaMemory3.normalGame
        aobuta.firstHitCountSt = aobutaMemory3.firstHitCountSt
        aobuta.czKogaReplayCountMiss = aobutaMemory3.czKogaReplayCountMiss
        aobuta.czKogaReplayCountHit = aobutaMemory3.czKogaReplayCountHit
        aobuta.czKogaReplayCountSum = aobutaMemory3.czKogaReplayCountSum
        aobuta.czKogaBellCountMiss = aobutaMemory3.czKogaBellCountMiss
        aobuta.czKogaBellCountHit = aobutaMemory3.czKogaBellCountHit
        aobuta.czKogaBellCountSum = aobutaMemory3.czKogaBellCountSum
        aobuta.czKogaCherryCountMiss = aobutaMemory3.czKogaCherryCountMiss
        aobuta.czKogaCherryCountHit = aobutaMemory3.czKogaCherryCountHit
        aobuta.czKogaCherryCountSum = aobutaMemory3.czKogaCherryCountSum
        aobuta.czKogaChanceCountMiss = aobutaMemory3.czKogaChanceCountMiss
        aobuta.czKogaChanceCountHit = aobutaMemory3.czKogaChanceCountHit
        aobuta.czKogaChanceCountSum = aobutaMemory3.czKogaChanceCountSum
        aobuta.czNodokaReplayCountMiss = aobutaMemory3.czNodokaReplayCountMiss
        aobuta.czNodokaReplayCountHit = aobutaMemory3.czNodokaReplayCountHit
        aobuta.czNodokaReplayCountSum = aobutaMemory3.czNodokaReplayCountSum
        aobuta.czNodokaBellCountMiss = aobutaMemory3.czNodokaBellCountMiss
        aobuta.czNodokaBellCountHit = aobutaMemory3.czNodokaBellCountHit
        aobuta.czNodokaBellCountSum = aobutaMemory3.czNodokaBellCountSum
        aobuta.czNodokaSuikaCherryCountMiss = aobutaMemory3.czNodokaSuikaCherryCountMiss
        aobuta.czNodokaSuikaCherryCountHit = aobutaMemory3.czNodokaSuikaCherryCountHit
        aobuta.czNodokaSuikaCherryCountSum = aobutaMemory3.czNodokaSuikaCherryCountSum
        aobuta.czNodokaChanceCountMiss = aobutaMemory3.czNodokaChanceCountMiss
        aobuta.czNodokaChanceCountHit = aobutaMemory3.czNodokaChanceCountHit
        aobuta.czNodokaChanceCountSum = aobutaMemory3.czNodokaChanceCountSum
        aobuta.czRioReplayCountMiss = aobutaMemory3.czRioReplayCountMiss
        aobuta.czRioReplayCountHit = aobutaMemory3.czRioReplayCountHit
        aobuta.czRioReplayCountSum = aobutaMemory3.czRioReplayCountSum
        aobuta.czRioBellCountMiss = aobutaMemory3.czRioBellCountMiss
        aobuta.czRioBellCountHit = aobutaMemory3.czRioBellCountHit
        aobuta.czRioBellCountSum = aobutaMemory3.czRioBellCountSum
        aobuta.czRioSuikaCountMiss = aobutaMemory3.czRioSuikaCountMiss
        aobuta.czRioSuikaCountHit = aobutaMemory3.czRioSuikaCountHit
        aobuta.czRioSuikaCountSum = aobutaMemory3.czRioSuikaCountSum
        aobuta.czRioChanceCountMiss = aobutaMemory3.czRioChanceCountMiss
        aobuta.czRioChanceCountHit = aobutaMemory3.czRioChanceCountHit
        aobuta.czRioChanceCountSum = aobutaMemory3.czRioChanceCountSum
        aobuta.czMaiReplayCountMiss = aobutaMemory3.czMaiReplayCountMiss
        aobuta.czMaiReplayCountHit = aobutaMemory3.czMaiReplayCountHit
        aobuta.czMaiReplayCountSum = aobutaMemory3.czMaiReplayCountSum
        aobuta.czMaiBellCountMiss = aobutaMemory3.czMaiBellCountMiss
        aobuta.czMaiBellCountHit = aobutaMemory3.czMaiBellCountHit
        aobuta.czMaiBellCountSum = aobutaMemory3.czMaiBellCountSum
        aobuta.czMaiSuikaCountMiss = aobutaMemory3.czMaiSuikaCountMiss
        aobuta.czMaiSuikaCountHit = aobutaMemory3.czMaiSuikaCountHit
        aobuta.czMaiSuikaCountSum = aobutaMemory3.czMaiSuikaCountSum
        aobuta.czMaiCherryCountMiss = aobutaMemory3.czMaiCherryCountMiss
        aobuta.czMaiCherryCountHit = aobutaMemory3.czMaiCherryCountHit
        aobuta.czMaiCherryCountSum = aobutaMemory3.czMaiCherryCountSum
        aobuta.czKaedeReplayCountMiss = aobutaMemory3.czKaedeReplayCountMiss
        aobuta.czKaedeReplayCountHit = aobutaMemory3.czKaedeReplayCountHit
        aobuta.czKaedeReplayCountSum = aobutaMemory3.czKaedeReplayCountSum
        aobuta.czKaedeBellCountMiss = aobutaMemory3.czKaedeBellCountMiss
        aobuta.czKaedeBellCountHit = aobutaMemory3.czKaedeBellCountHit
        aobuta.czKaedeBellCountSum = aobutaMemory3.czKaedeBellCountSum
        aobuta.czShokoReplayCountMiss = aobutaMemory3.czShokoReplayCountMiss
        aobuta.czShokoReplayCountHit = aobutaMemory3.czShokoReplayCountHit
        aobuta.czShokoReplayCountSum = aobutaMemory3.czShokoReplayCountSum
        aobuta.czShokoBellCountMiss = aobutaMemory3.czShokoBellCountMiss
        aobuta.czShokoBellCountHit = aobutaMemory3.czShokoBellCountHit
        aobuta.czShokoBellCountSum = aobutaMemory3.czShokoBellCountSum
        aobuta.screenCount1 = aobutaMemory3.screenCount1
        aobuta.screenCount2 = aobutaMemory3.screenCount2
        aobuta.screenCount3 = aobutaMemory3.screenCount3
        aobuta.screenCount4 = aobutaMemory3.screenCount4
        aobuta.screenCount5 = aobutaMemory3.screenCount5
        aobuta.screenCountSum = aobutaMemory3.screenCountSum
        aobuta.syndromeCountMiss = aobutaMemory3.syndromeCountMiss
        aobuta.syndromeCountHit = aobutaMemory3.syndromeCountHit
        aobuta.syndromeCountSum = aobutaMemory3.syndromeCountSum
    }
}

#Preview {
    aobutaViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
