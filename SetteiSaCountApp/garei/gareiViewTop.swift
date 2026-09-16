//
//  gareiViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct gareiViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var garei = Garei()
    @State var isShowAlert: Bool = false
    @StateObject var gareiMemory1 = GareiMemory1()
    @StateObject var gareiMemory2 = GareiMemory2()
    @StateObject var gareiMemory3 = GareiMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: gareiViewNormal(
                        garei: garei,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.gareiMenuNormalBadge,
                        )
                    }

                    // CZ
                    NavigationLink(destination: gareiViewCz(
                        garei: garei,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "scope",
                            textBody: "CZ",
                            badgeStatus: common.gareiMenuCzBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: gareiViewFirstHit(
                        garei: garei,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.gareiMenuFirstHitBadge,
                        )
                    }

                    // RB
                    NavigationLink(destination: gareiViewDuringRb(
                        garei: garei,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.2.fill",
                            textBody: "RB",
                            badgeStatus: common.gareiMenuDuringRbBadge,
                        )
                    }

                    // ボーナス終了画面
                    NavigationLink(destination: gareiViewBonusScreen(
                        garei: garei,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面",
                            badgeStatus: common.gareiMenuScreenBadge,
                        )
                    }

                    // ART終了画面
                    NavigationLink(destination: gareiViewArtScreen(
                        garei: garei,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ART終了画面",
                            badgeStatus: common.gareiMenuArtScreenBadge,
                        )
                    }

                    // ART終了後
                    NavigationLink(destination: gareiViewAfterArt(
                        garei: garei,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "signpost.right.and.left.fill",
                            textBody: "ART終了後",
                            badgeStatus: common.gareiMenuAfterArtBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: gareiViewEnding(
                        garei: garei,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.gareiMenuEndingBadge,
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: garei.machineName,
                        titleFont: .title,
                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: gareiView95Ci(
                    garei: garei,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: gareiViewBayes(
                    garei: garei,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.gareiMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5028")

                // コピーライト
                unitSectionCopyright {
                    Text("©2008 瀬川はじめ／［喰霊−零−］製作委員会")
                    Text("©OIZUMI")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5028")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: garei.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(gareiSubViewLoadMemory(
                    garei: garei,
                    gareiMemory1: gareiMemory1,
                    gareiMemory2: gareiMemory2,
                    gareiMemory3: gareiMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(gareiSubViewSaveMemory(
                    garei: garei,
                    gareiMemory1: gareiMemory1,
                    gareiMemory2: gareiMemory2,
                    gareiMemory3: gareiMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: garei.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct gareiSubViewSaveMemory: View {
    @ObservedObject var garei: Garei
    @ObservedObject var gareiMemory1: GareiMemory1
    @ObservedObject var gareiMemory2: GareiMemory2
    @ObservedObject var gareiMemory3: GareiMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: garei.machineName,
            selectedMemory: $garei.selectedMemory,
            memoMemory1: $gareiMemory1.memo,
            dateDoubleMemory1: $gareiMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $gareiMemory2.memo,
            dateDoubleMemory2: $gareiMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $gareiMemory3.memo,
            dateDoubleMemory3: $gareiMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        gareiMemory1.koyakuCountSuika = garei.koyakuCountSuika
        gareiMemory1.koyakuCountJakuCherry = garei.koyakuCountJakuCherry
        gareiMemory1.koyakuCountKyoCherry = garei.koyakuCountKyoCherry
        gareiMemory1.koyakuCountJakuChance = garei.koyakuCountJakuChance
        gareiMemory1.koyakuCountKyoChance = garei.koyakuCountKyoChance
        gareiMemory1.chofukuCountJakuCherry = garei.chofukuCountJakuCherry
        gareiMemory1.chofukuCountKyoCherry = garei.chofukuCountKyoCherry
        gareiMemory1.gameNumberStart = garei.gameNumberStart
        gareiMemory1.gameNumberCurrent = garei.gameNumberCurrent
        gareiMemory1.gameNumberPlay = garei.gameNumberPlay
        gareiMemory1.czRangekiCountMiss = garei.czRangekiCountMiss
        gareiMemory1.czRangekiCountHit = garei.czRangekiCountHit
        gareiMemory1.czRangekiCountSum = garei.czRangekiCountSum
        gareiMemory1.normalGame = garei.normalGame
        gareiMemory1.firstHitCountCz = garei.firstHitCountCz
        gareiMemory1.firstHitCountBig = garei.firstHitCountBig
        gareiMemory1.firstHitCountReg = garei.firstHitCountReg
        gareiMemory1.firstHitCountArt = garei.firstHitCountArt
        gareiMemory1.bonusScreenCount1 = garei.bonusScreenCount1
        gareiMemory1.bonusScreenCount2 = garei.bonusScreenCount2
        gareiMemory1.bonusScreenCount3 = garei.bonusScreenCount3
        gareiMemory1.bonusScreenCount4 = garei.bonusScreenCount4
        gareiMemory1.bonusScreenCountSum = garei.bonusScreenCountSum
        gareiMemory1.artScreenCount1 = garei.artScreenCount1
        gareiMemory1.artScreenCount2 = garei.artScreenCount2
        gareiMemory1.artScreenCount3 = garei.artScreenCount3
        gareiMemory1.artScreenCount4 = garei.artScreenCount4
        gareiMemory1.artScreenCountSum = garei.artScreenCountSum
        gareiMemory1.koyakuCountCommonBell = garei.koyakuCountCommonBell
        gareiMemory1.charaCount1 = garei.charaCount1
        gareiMemory1.charaCount2 = garei.charaCount2
        gareiMemory1.charaCount3 = garei.charaCount3
        gareiMemory1.charaCount4 = garei.charaCount4
        gareiMemory1.charaCount5 = garei.charaCount5
        gareiMemory1.charaCount6 = garei.charaCount6
        gareiMemory1.charaCountSum = garei.charaCountSum
        gareiMemory1.startStatusCountNormal = garei.startStatusCountNormal
        gareiMemory1.startStatusCountHigh = garei.startStatusCountHigh
        gareiMemory1.startStatusCountSuperHigh = garei.startStatusCountSuperHigh
        gareiMemory1.startStatusCountSum = garei.startStatusCountSum
        gareiMemory1.lampCount1 = garei.lampCount1
        gareiMemory1.lampCount2 = garei.lampCount2
        gareiMemory1.lampCount3 = garei.lampCount3
        gareiMemory1.lampCount4 = garei.lampCount4
        gareiMemory1.lampCount5 = garei.lampCount5
        gareiMemory1.lampCount6 = garei.lampCount6
        gareiMemory1.lampCount7 = garei.lampCount7
        gareiMemory1.lampCount8 = garei.lampCount8
        gareiMemory1.lampCountSum = garei.lampCountSum
    }
    func saveMemory2() {
        gareiMemory2.koyakuCountSuika = garei.koyakuCountSuika
        gareiMemory2.koyakuCountJakuCherry = garei.koyakuCountJakuCherry
        gareiMemory2.koyakuCountKyoCherry = garei.koyakuCountKyoCherry
        gareiMemory2.koyakuCountJakuChance = garei.koyakuCountJakuChance
        gareiMemory2.koyakuCountKyoChance = garei.koyakuCountKyoChance
        gareiMemory2.chofukuCountJakuCherry = garei.chofukuCountJakuCherry
        gareiMemory2.chofukuCountKyoCherry = garei.chofukuCountKyoCherry
        gareiMemory2.gameNumberStart = garei.gameNumberStart
        gareiMemory2.gameNumberCurrent = garei.gameNumberCurrent
        gareiMemory2.gameNumberPlay = garei.gameNumberPlay
        gareiMemory2.czRangekiCountMiss = garei.czRangekiCountMiss
        gareiMemory2.czRangekiCountHit = garei.czRangekiCountHit
        gareiMemory2.czRangekiCountSum = garei.czRangekiCountSum
        gareiMemory2.normalGame = garei.normalGame
        gareiMemory2.firstHitCountCz = garei.firstHitCountCz
        gareiMemory2.firstHitCountBig = garei.firstHitCountBig
        gareiMemory2.firstHitCountReg = garei.firstHitCountReg
        gareiMemory2.firstHitCountArt = garei.firstHitCountArt
        gareiMemory2.bonusScreenCount1 = garei.bonusScreenCount1
        gareiMemory2.bonusScreenCount2 = garei.bonusScreenCount2
        gareiMemory2.bonusScreenCount3 = garei.bonusScreenCount3
        gareiMemory2.bonusScreenCount4 = garei.bonusScreenCount4
        gareiMemory2.bonusScreenCountSum = garei.bonusScreenCountSum
        gareiMemory2.artScreenCount1 = garei.artScreenCount1
        gareiMemory2.artScreenCount2 = garei.artScreenCount2
        gareiMemory2.artScreenCount3 = garei.artScreenCount3
        gareiMemory2.artScreenCount4 = garei.artScreenCount4
        gareiMemory2.artScreenCountSum = garei.artScreenCountSum
        gareiMemory2.koyakuCountCommonBell = garei.koyakuCountCommonBell
        gareiMemory2.charaCount1 = garei.charaCount1
        gareiMemory2.charaCount2 = garei.charaCount2
        gareiMemory2.charaCount3 = garei.charaCount3
        gareiMemory2.charaCount4 = garei.charaCount4
        gareiMemory2.charaCount5 = garei.charaCount5
        gareiMemory2.charaCount6 = garei.charaCount6
        gareiMemory2.charaCountSum = garei.charaCountSum
        gareiMemory2.startStatusCountNormal = garei.startStatusCountNormal
        gareiMemory2.startStatusCountHigh = garei.startStatusCountHigh
        gareiMemory2.startStatusCountSuperHigh = garei.startStatusCountSuperHigh
        gareiMemory2.startStatusCountSum = garei.startStatusCountSum
        gareiMemory2.lampCount1 = garei.lampCount1
        gareiMemory2.lampCount2 = garei.lampCount2
        gareiMemory2.lampCount3 = garei.lampCount3
        gareiMemory2.lampCount4 = garei.lampCount4
        gareiMemory2.lampCount5 = garei.lampCount5
        gareiMemory2.lampCount6 = garei.lampCount6
        gareiMemory2.lampCount7 = garei.lampCount7
        gareiMemory2.lampCount8 = garei.lampCount8
        gareiMemory2.lampCountSum = garei.lampCountSum
    }
    func saveMemory3() {
        gareiMemory3.koyakuCountSuika = garei.koyakuCountSuika
        gareiMemory3.koyakuCountJakuCherry = garei.koyakuCountJakuCherry
        gareiMemory3.koyakuCountKyoCherry = garei.koyakuCountKyoCherry
        gareiMemory3.koyakuCountJakuChance = garei.koyakuCountJakuChance
        gareiMemory3.koyakuCountKyoChance = garei.koyakuCountKyoChance
        gareiMemory3.chofukuCountJakuCherry = garei.chofukuCountJakuCherry
        gareiMemory3.chofukuCountKyoCherry = garei.chofukuCountKyoCherry
        gareiMemory3.gameNumberStart = garei.gameNumberStart
        gareiMemory3.gameNumberCurrent = garei.gameNumberCurrent
        gareiMemory3.gameNumberPlay = garei.gameNumberPlay
        gareiMemory3.czRangekiCountMiss = garei.czRangekiCountMiss
        gareiMemory3.czRangekiCountHit = garei.czRangekiCountHit
        gareiMemory3.czRangekiCountSum = garei.czRangekiCountSum
        gareiMemory3.normalGame = garei.normalGame
        gareiMemory3.firstHitCountCz = garei.firstHitCountCz
        gareiMemory3.firstHitCountBig = garei.firstHitCountBig
        gareiMemory3.firstHitCountReg = garei.firstHitCountReg
        gareiMemory3.firstHitCountArt = garei.firstHitCountArt
        gareiMemory3.bonusScreenCount1 = garei.bonusScreenCount1
        gareiMemory3.bonusScreenCount2 = garei.bonusScreenCount2
        gareiMemory3.bonusScreenCount3 = garei.bonusScreenCount3
        gareiMemory3.bonusScreenCount4 = garei.bonusScreenCount4
        gareiMemory3.bonusScreenCountSum = garei.bonusScreenCountSum
        gareiMemory3.artScreenCount1 = garei.artScreenCount1
        gareiMemory3.artScreenCount2 = garei.artScreenCount2
        gareiMemory3.artScreenCount3 = garei.artScreenCount3
        gareiMemory3.artScreenCount4 = garei.artScreenCount4
        gareiMemory3.artScreenCountSum = garei.artScreenCountSum
        gareiMemory3.koyakuCountCommonBell = garei.koyakuCountCommonBell
        gareiMemory3.charaCount1 = garei.charaCount1
        gareiMemory3.charaCount2 = garei.charaCount2
        gareiMemory3.charaCount3 = garei.charaCount3
        gareiMemory3.charaCount4 = garei.charaCount4
        gareiMemory3.charaCount5 = garei.charaCount5
        gareiMemory3.charaCount6 = garei.charaCount6
        gareiMemory3.charaCountSum = garei.charaCountSum
        gareiMemory3.startStatusCountNormal = garei.startStatusCountNormal
        gareiMemory3.startStatusCountHigh = garei.startStatusCountHigh
        gareiMemory3.startStatusCountSuperHigh = garei.startStatusCountSuperHigh
        gareiMemory3.startStatusCountSum = garei.startStatusCountSum
        gareiMemory3.lampCount1 = garei.lampCount1
        gareiMemory3.lampCount2 = garei.lampCount2
        gareiMemory3.lampCount3 = garei.lampCount3
        gareiMemory3.lampCount4 = garei.lampCount4
        gareiMemory3.lampCount5 = garei.lampCount5
        gareiMemory3.lampCount6 = garei.lampCount6
        gareiMemory3.lampCount7 = garei.lampCount7
        gareiMemory3.lampCount8 = garei.lampCount8
        gareiMemory3.lampCountSum = garei.lampCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct gareiSubViewLoadMemory: View {
    @ObservedObject var garei: Garei
    @ObservedObject var gareiMemory1: GareiMemory1
    @ObservedObject var gareiMemory2: GareiMemory2
    @ObservedObject var gareiMemory3: GareiMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: garei.machineName,
            selectedMemory: $garei.selectedMemory,
            memoMemory1: gareiMemory1.memo,
            dateDoubleMemory1: gareiMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: gareiMemory2.memo,
            dateDoubleMemory2: gareiMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: gareiMemory3.memo,
            dateDoubleMemory3: gareiMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        garei.koyakuCountSuika = gareiMemory1.koyakuCountSuika
        garei.koyakuCountJakuCherry = gareiMemory1.koyakuCountJakuCherry
        garei.koyakuCountKyoCherry = gareiMemory1.koyakuCountKyoCherry
        garei.koyakuCountJakuChance = gareiMemory1.koyakuCountJakuChance
        garei.koyakuCountKyoChance = gareiMemory1.koyakuCountKyoChance
        garei.chofukuCountJakuCherry = gareiMemory1.chofukuCountJakuCherry
        garei.chofukuCountKyoCherry = gareiMemory1.chofukuCountKyoCherry
        garei.gameNumberStart = gareiMemory1.gameNumberStart
        garei.gameNumberCurrent = gareiMemory1.gameNumberCurrent
        garei.gameNumberPlay = gareiMemory1.gameNumberPlay
        garei.czRangekiCountMiss = gareiMemory1.czRangekiCountMiss
        garei.czRangekiCountHit = gareiMemory1.czRangekiCountHit
        garei.czRangekiCountSum = gareiMemory1.czRangekiCountSum
        garei.normalGame = gareiMemory1.normalGame
        garei.firstHitCountCz = gareiMemory1.firstHitCountCz
        garei.firstHitCountBig = gareiMemory1.firstHitCountBig
        garei.firstHitCountReg = gareiMemory1.firstHitCountReg
        garei.firstHitCountArt = gareiMemory1.firstHitCountArt
        garei.bonusScreenCount1 = gareiMemory1.bonusScreenCount1
        garei.bonusScreenCount2 = gareiMemory1.bonusScreenCount2
        garei.bonusScreenCount3 = gareiMemory1.bonusScreenCount3
        garei.bonusScreenCount4 = gareiMemory1.bonusScreenCount4
        garei.bonusScreenCountSum = gareiMemory1.bonusScreenCountSum
        garei.artScreenCount1 = gareiMemory1.artScreenCount1
        garei.artScreenCount2 = gareiMemory1.artScreenCount2
        garei.artScreenCount3 = gareiMemory1.artScreenCount3
        garei.artScreenCount4 = gareiMemory1.artScreenCount4
        garei.artScreenCountSum = gareiMemory1.artScreenCountSum
        garei.koyakuCountCommonBell = gareiMemory1.koyakuCountCommonBell
        garei.charaCount1 = gareiMemory1.charaCount1
        garei.charaCount2 = gareiMemory1.charaCount2
        garei.charaCount3 = gareiMemory1.charaCount3
        garei.charaCount4 = gareiMemory1.charaCount4
        garei.charaCount5 = gareiMemory1.charaCount5
        garei.charaCount6 = gareiMemory1.charaCount6
        garei.charaCountSum = gareiMemory1.charaCountSum
        garei.startStatusCountNormal = gareiMemory1.startStatusCountNormal
        garei.startStatusCountHigh = gareiMemory1.startStatusCountHigh
        garei.startStatusCountSuperHigh = gareiMemory1.startStatusCountSuperHigh
        garei.startStatusCountSum = gareiMemory1.startStatusCountSum
        garei.lampCount1 = gareiMemory1.lampCount1
        garei.lampCount2 = gareiMemory1.lampCount2
        garei.lampCount3 = gareiMemory1.lampCount3
        garei.lampCount4 = gareiMemory1.lampCount4
        garei.lampCount5 = gareiMemory1.lampCount5
        garei.lampCount6 = gareiMemory1.lampCount6
        garei.lampCount7 = gareiMemory1.lampCount7
        garei.lampCount8 = gareiMemory1.lampCount8
        garei.lampCountSum = gareiMemory1.lampCountSum
    }
    func loadMemory2() {
        garei.koyakuCountSuika = gareiMemory2.koyakuCountSuika
        garei.koyakuCountJakuCherry = gareiMemory2.koyakuCountJakuCherry
        garei.koyakuCountKyoCherry = gareiMemory2.koyakuCountKyoCherry
        garei.koyakuCountJakuChance = gareiMemory2.koyakuCountJakuChance
        garei.koyakuCountKyoChance = gareiMemory2.koyakuCountKyoChance
        garei.chofukuCountJakuCherry = gareiMemory2.chofukuCountJakuCherry
        garei.chofukuCountKyoCherry = gareiMemory2.chofukuCountKyoCherry
        garei.gameNumberStart = gareiMemory2.gameNumberStart
        garei.gameNumberCurrent = gareiMemory2.gameNumberCurrent
        garei.gameNumberPlay = gareiMemory2.gameNumberPlay
        garei.czRangekiCountMiss = gareiMemory2.czRangekiCountMiss
        garei.czRangekiCountHit = gareiMemory2.czRangekiCountHit
        garei.czRangekiCountSum = gareiMemory2.czRangekiCountSum
        garei.normalGame = gareiMemory2.normalGame
        garei.firstHitCountCz = gareiMemory2.firstHitCountCz
        garei.firstHitCountBig = gareiMemory2.firstHitCountBig
        garei.firstHitCountReg = gareiMemory2.firstHitCountReg
        garei.firstHitCountArt = gareiMemory2.firstHitCountArt
        garei.bonusScreenCount1 = gareiMemory2.bonusScreenCount1
        garei.bonusScreenCount2 = gareiMemory2.bonusScreenCount2
        garei.bonusScreenCount3 = gareiMemory2.bonusScreenCount3
        garei.bonusScreenCount4 = gareiMemory2.bonusScreenCount4
        garei.bonusScreenCountSum = gareiMemory2.bonusScreenCountSum
        garei.artScreenCount1 = gareiMemory2.artScreenCount1
        garei.artScreenCount2 = gareiMemory2.artScreenCount2
        garei.artScreenCount3 = gareiMemory2.artScreenCount3
        garei.artScreenCount4 = gareiMemory2.artScreenCount4
        garei.artScreenCountSum = gareiMemory2.artScreenCountSum
        garei.koyakuCountCommonBell = gareiMemory2.koyakuCountCommonBell
        garei.charaCount1 = gareiMemory2.charaCount1
        garei.charaCount2 = gareiMemory2.charaCount2
        garei.charaCount3 = gareiMemory2.charaCount3
        garei.charaCount4 = gareiMemory2.charaCount4
        garei.charaCount5 = gareiMemory2.charaCount5
        garei.charaCount6 = gareiMemory2.charaCount6
        garei.charaCountSum = gareiMemory2.charaCountSum
        garei.startStatusCountNormal = gareiMemory2.startStatusCountNormal
        garei.startStatusCountHigh = gareiMemory2.startStatusCountHigh
        garei.startStatusCountSuperHigh = gareiMemory2.startStatusCountSuperHigh
        garei.startStatusCountSum = gareiMemory2.startStatusCountSum
        garei.lampCount1 = gareiMemory2.lampCount1
        garei.lampCount2 = gareiMemory2.lampCount2
        garei.lampCount3 = gareiMemory2.lampCount3
        garei.lampCount4 = gareiMemory2.lampCount4
        garei.lampCount5 = gareiMemory2.lampCount5
        garei.lampCount6 = gareiMemory2.lampCount6
        garei.lampCount7 = gareiMemory2.lampCount7
        garei.lampCount8 = gareiMemory2.lampCount8
        garei.lampCountSum = gareiMemory2.lampCountSum
    }
    func loadMemory3() {
        garei.koyakuCountSuika = gareiMemory3.koyakuCountSuika
        garei.koyakuCountJakuCherry = gareiMemory3.koyakuCountJakuCherry
        garei.koyakuCountKyoCherry = gareiMemory3.koyakuCountKyoCherry
        garei.koyakuCountJakuChance = gareiMemory3.koyakuCountJakuChance
        garei.koyakuCountKyoChance = gareiMemory3.koyakuCountKyoChance
        garei.chofukuCountJakuCherry = gareiMemory3.chofukuCountJakuCherry
        garei.chofukuCountKyoCherry = gareiMemory3.chofukuCountKyoCherry
        garei.gameNumberStart = gareiMemory3.gameNumberStart
        garei.gameNumberCurrent = gareiMemory3.gameNumberCurrent
        garei.gameNumberPlay = gareiMemory3.gameNumberPlay
        garei.czRangekiCountMiss = gareiMemory3.czRangekiCountMiss
        garei.czRangekiCountHit = gareiMemory3.czRangekiCountHit
        garei.czRangekiCountSum = gareiMemory3.czRangekiCountSum
        garei.normalGame = gareiMemory3.normalGame
        garei.firstHitCountCz = gareiMemory3.firstHitCountCz
        garei.firstHitCountBig = gareiMemory3.firstHitCountBig
        garei.firstHitCountReg = gareiMemory3.firstHitCountReg
        garei.firstHitCountArt = gareiMemory3.firstHitCountArt
        garei.bonusScreenCount1 = gareiMemory3.bonusScreenCount1
        garei.bonusScreenCount2 = gareiMemory3.bonusScreenCount2
        garei.bonusScreenCount3 = gareiMemory3.bonusScreenCount3
        garei.bonusScreenCount4 = gareiMemory3.bonusScreenCount4
        garei.bonusScreenCountSum = gareiMemory3.bonusScreenCountSum
        garei.artScreenCount1 = gareiMemory3.artScreenCount1
        garei.artScreenCount2 = gareiMemory3.artScreenCount2
        garei.artScreenCount3 = gareiMemory3.artScreenCount3
        garei.artScreenCount4 = gareiMemory3.artScreenCount4
        garei.artScreenCountSum = gareiMemory3.artScreenCountSum
        garei.koyakuCountCommonBell = gareiMemory3.koyakuCountCommonBell
        garei.charaCount1 = gareiMemory3.charaCount1
        garei.charaCount2 = gareiMemory3.charaCount2
        garei.charaCount3 = gareiMemory3.charaCount3
        garei.charaCount4 = gareiMemory3.charaCount4
        garei.charaCount5 = gareiMemory3.charaCount5
        garei.charaCount6 = gareiMemory3.charaCount6
        garei.charaCountSum = gareiMemory3.charaCountSum
        garei.startStatusCountNormal = gareiMemory3.startStatusCountNormal
        garei.startStatusCountHigh = gareiMemory3.startStatusCountHigh
        garei.startStatusCountSuperHigh = gareiMemory3.startStatusCountSuperHigh
        garei.startStatusCountSum = gareiMemory3.startStatusCountSum
        garei.lampCount1 = gareiMemory3.lampCount1
        garei.lampCount2 = gareiMemory3.lampCount2
        garei.lampCount3 = gareiMemory3.lampCount3
        garei.lampCount4 = gareiMemory3.lampCount4
        garei.lampCount5 = gareiMemory3.lampCount5
        garei.lampCount6 = gareiMemory3.lampCount6
        garei.lampCount7 = gareiMemory3.lampCount7
        garei.lampCount8 = gareiMemory3.lampCount8
        garei.lampCountSum = gareiMemory3.lampCountSum
    }
}

#Preview {
    gareiViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
