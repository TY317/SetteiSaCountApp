//
//  gobsla2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/23.
//

import SwiftUI

struct gobsla2ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var gobsla2 = Gobsla2()
    @State var isShowAlert: Bool = false
    @StateObject var gobsla2Memory1 = Gobsla2Memory1()
    @StateObject var gobsla2Memory2 = Gobsla2Memory2()
    @StateObject var gobsla2Memory3 = Gobsla2Memory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: gobsla2ViewNormal(
                        gobsla2: gobsla2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.gobsla2MenuNormalBadge,
                        )
                    }
                    
                    // 兜pt
                    NavigationLink(destination: gobsla2ViewKabuto(
                        gobsla2: gobsla2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "crown.fill",
                            textBody: "兜pt",
                            badgeStatus: common.gobsla2MenuKabutoBadge,
                        )
                    }
                    
                    // 初あたり
                    NavigationLink(destination: gobsla2ViewFirstHit(
                        gobsla2: gobsla2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.gobsla2MenuFirstHitBadge,
                        )
                    }
                    
                    // 初あたり
                    NavigationLink(destination: gobsla2ViewScreen(
                        gobsla2: gobsla2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: common.gobsla2MenuScreenBadge,
                        )
                    }
                    
                    // エンディング
                    NavigationLink(destination: gobsla2ViewEnding(
                        gobsla2: gobsla2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.gobsla2MenuEndingBadge,
                        )
                    }
                    
                    // 藤丸コイン
                    NavigationLink(destination: commonViewFujimaruCoin()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "藤丸コイン"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: gobsla2.machineName)
                }
                
                // 設定推測グラフ
                NavigationLink(destination: gobsla2View95Ci(
                    gobsla2: gobsla2,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: gobsla2ViewBayes(
                    gobsla2: gobsla2,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.gobsla2MenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4950")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©蝸牛くも・SBクリエイティブ／ゴブリンスレイヤー2製作委員会")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.gobsla2MachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: gobsla2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(gobsla2SubViewLoadMemory(
                    gobsla2: gobsla2,
                    gobsla2Memory1: gobsla2Memory1,
                    gobsla2Memory2: gobsla2Memory2,
                    gobsla2Memory3: gobsla2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(gobsla2SubViewSaveMemory(
                    gobsla2: gobsla2,
                    gobsla2Memory1: gobsla2Memory1,
                    gobsla2Memory2: gobsla2Memory2,
                    gobsla2Memory3: gobsla2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: gobsla2.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct gobsla2SubViewSaveMemory: View {
    @ObservedObject var gobsla2: Gobsla2
    @ObservedObject var gobsla2Memory1: Gobsla2Memory1
    @ObservedObject var gobsla2Memory2: Gobsla2Memory2
    @ObservedObject var gobsla2Memory3: Gobsla2Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: gobsla2.machineName,
            selectedMemory: $gobsla2.selectedMemory,
            memoMemory1: $gobsla2Memory1.memo,
            dateDoubleMemory1: $gobsla2Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $gobsla2Memory2.memo,
            dateDoubleMemory2: $gobsla2Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $gobsla2Memory3.memo,
            dateDoubleMemory3: $gobsla2Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        gobsla2Memory1.jakuRareCountJakuCherry = gobsla2.jakuRareCountJakuCherry
        gobsla2Memory1.jakuRareCountSuika = gobsla2.jakuRareCountSuika
        gobsla2Memory1.jakuRareCountSum = gobsla2.jakuRareCountSum
        gobsla2Memory1.jakuRareCountHit = gobsla2.jakuRareCountHit
        gobsla2Memory1.game35HitCountMiss = gobsla2.game35HitCountMiss
        gobsla2Memory1.game35HitCountHit = gobsla2.game35HitCountHit
        gobsla2Memory1.game35HitCountSum = gobsla2.game35HitCountSum
        gobsla2Memory1.ptCount10 = gobsla2.ptCount10
        gobsla2Memory1.ptCount20 = gobsla2.ptCount20
        gobsla2Memory1.ptCount30 = gobsla2.ptCount30
        gobsla2Memory1.ptCount40 = gobsla2.ptCount40
        gobsla2Memory1.ptCount50 = gobsla2.ptCount50
        gobsla2Memory1.ptCount60 = gobsla2.ptCount60
        gobsla2Memory1.ptCount70 = gobsla2.ptCount70
        gobsla2Memory1.ptCount80 = gobsla2.ptCount80
        gobsla2Memory1.ptCount90 = gobsla2.ptCount90
        gobsla2Memory1.ptCount100 = gobsla2.ptCount100
        gobsla2Memory1.ptCountSum = gobsla2.ptCountSum
        gobsla2Memory1.ptCountU20 = gobsla2.ptCountU20
        gobsla2Memory1.ptCountO40 = gobsla2.ptCountO40
        gobsla2Memory1.inputGame = gobsla2.inputGame
        gobsla2Memory1.selectedKind = gobsla2.selectedKind
        gobsla2Memory1.selectedAtHit = gobsla2.selectedAtHit
        gobsla2Memory1.gameArrayData = gobsla2.gameArrayData
        gobsla2Memory1.kindArrayData = gobsla2.kindArrayData
        gobsla2Memory1.atHitArrayData = gobsla2.atHitArrayData
        gobsla2Memory1.normalGame = gobsla2.normalGame
        gobsla2Memory1.czCount = gobsla2.czCount
        gobsla2Memory1.atCount = gobsla2.atCount
        gobsla2Memory1.screenCountDefault = gobsla2.screenCountDefault
        gobsla2Memory1.screenCountPtSisa1 = gobsla2.screenCountPtSisa1
        gobsla2Memory1.screenCountPtSisa2 = gobsla2.screenCountPtSisa2
        gobsla2Memory1.screenCountPtSisa3 = gobsla2.screenCountPtSisa3
        gobsla2Memory1.screenCountPtSisa4 = gobsla2.screenCountPtSisa4
        gobsla2Memory1.screenCountHighJaku = gobsla2.screenCountHighJaku
        gobsla2Memory1.screenCountOver2 = gobsla2.screenCountOver2
        gobsla2Memory1.screenCountGusu = gobsla2.screenCountGusu
        gobsla2Memory1.screenCountOver4 = gobsla2.screenCountOver4
        gobsla2Memory1.screenCountOver6 = gobsla2.screenCountOver6
        gobsla2Memory1.screenCountSum = gobsla2.screenCountSum
    }
    func saveMemory2() {
        gobsla2Memory2.jakuRareCountJakuCherry = gobsla2.jakuRareCountJakuCherry
        gobsla2Memory2.jakuRareCountSuika = gobsla2.jakuRareCountSuika
        gobsla2Memory2.jakuRareCountSum = gobsla2.jakuRareCountSum
        gobsla2Memory2.jakuRareCountHit = gobsla2.jakuRareCountHit
        gobsla2Memory2.game35HitCountMiss = gobsla2.game35HitCountMiss
        gobsla2Memory2.game35HitCountHit = gobsla2.game35HitCountHit
        gobsla2Memory2.game35HitCountSum = gobsla2.game35HitCountSum
        gobsla2Memory2.ptCount10 = gobsla2.ptCount10
        gobsla2Memory2.ptCount20 = gobsla2.ptCount20
        gobsla2Memory2.ptCount30 = gobsla2.ptCount30
        gobsla2Memory2.ptCount40 = gobsla2.ptCount40
        gobsla2Memory2.ptCount50 = gobsla2.ptCount50
        gobsla2Memory2.ptCount60 = gobsla2.ptCount60
        gobsla2Memory2.ptCount70 = gobsla2.ptCount70
        gobsla2Memory2.ptCount80 = gobsla2.ptCount80
        gobsla2Memory2.ptCount90 = gobsla2.ptCount90
        gobsla2Memory2.ptCount100 = gobsla2.ptCount100
        gobsla2Memory2.ptCountSum = gobsla2.ptCountSum
        gobsla2Memory2.ptCountU20 = gobsla2.ptCountU20
        gobsla2Memory2.ptCountO40 = gobsla2.ptCountO40
        gobsla2Memory2.inputGame = gobsla2.inputGame
        gobsla2Memory2.selectedKind = gobsla2.selectedKind
        gobsla2Memory2.selectedAtHit = gobsla2.selectedAtHit
        gobsla2Memory2.gameArrayData = gobsla2.gameArrayData
        gobsla2Memory2.kindArrayData = gobsla2.kindArrayData
        gobsla2Memory2.atHitArrayData = gobsla2.atHitArrayData
        gobsla2Memory2.normalGame = gobsla2.normalGame
        gobsla2Memory2.czCount = gobsla2.czCount
        gobsla2Memory2.atCount = gobsla2.atCount
        gobsla2Memory2.screenCountDefault = gobsla2.screenCountDefault
        gobsla2Memory2.screenCountPtSisa1 = gobsla2.screenCountPtSisa1
        gobsla2Memory2.screenCountPtSisa2 = gobsla2.screenCountPtSisa2
        gobsla2Memory2.screenCountPtSisa3 = gobsla2.screenCountPtSisa3
        gobsla2Memory2.screenCountPtSisa4 = gobsla2.screenCountPtSisa4
        gobsla2Memory2.screenCountHighJaku = gobsla2.screenCountHighJaku
        gobsla2Memory2.screenCountOver2 = gobsla2.screenCountOver2
        gobsla2Memory2.screenCountGusu = gobsla2.screenCountGusu
        gobsla2Memory2.screenCountOver4 = gobsla2.screenCountOver4
        gobsla2Memory2.screenCountOver6 = gobsla2.screenCountOver6
        gobsla2Memory2.screenCountSum = gobsla2.screenCountSum
    }
    func saveMemory3() {
        gobsla2Memory3.jakuRareCountJakuCherry = gobsla2.jakuRareCountJakuCherry
        gobsla2Memory3.jakuRareCountSuika = gobsla2.jakuRareCountSuika
        gobsla2Memory3.jakuRareCountSum = gobsla2.jakuRareCountSum
        gobsla2Memory3.jakuRareCountHit = gobsla2.jakuRareCountHit
        gobsla2Memory3.game35HitCountMiss = gobsla2.game35HitCountMiss
        gobsla2Memory3.game35HitCountHit = gobsla2.game35HitCountHit
        gobsla2Memory3.game35HitCountSum = gobsla2.game35HitCountSum
        gobsla2Memory3.ptCount10 = gobsla2.ptCount10
        gobsla2Memory3.ptCount20 = gobsla2.ptCount20
        gobsla2Memory3.ptCount30 = gobsla2.ptCount30
        gobsla2Memory3.ptCount40 = gobsla2.ptCount40
        gobsla2Memory3.ptCount50 = gobsla2.ptCount50
        gobsla2Memory3.ptCount60 = gobsla2.ptCount60
        gobsla2Memory3.ptCount70 = gobsla2.ptCount70
        gobsla2Memory3.ptCount80 = gobsla2.ptCount80
        gobsla2Memory3.ptCount90 = gobsla2.ptCount90
        gobsla2Memory3.ptCount100 = gobsla2.ptCount100
        gobsla2Memory3.ptCountSum = gobsla2.ptCountSum
        gobsla2Memory3.ptCountU20 = gobsla2.ptCountU20
        gobsla2Memory3.ptCountO40 = gobsla2.ptCountO40
        gobsla2Memory3.inputGame = gobsla2.inputGame
        gobsla2Memory3.selectedKind = gobsla2.selectedKind
        gobsla2Memory3.selectedAtHit = gobsla2.selectedAtHit
        gobsla2Memory3.gameArrayData = gobsla2.gameArrayData
        gobsla2Memory3.kindArrayData = gobsla2.kindArrayData
        gobsla2Memory3.atHitArrayData = gobsla2.atHitArrayData
        gobsla2Memory3.normalGame = gobsla2.normalGame
        gobsla2Memory3.czCount = gobsla2.czCount
        gobsla2Memory3.atCount = gobsla2.atCount
        gobsla2Memory3.screenCountDefault = gobsla2.screenCountDefault
        gobsla2Memory3.screenCountPtSisa1 = gobsla2.screenCountPtSisa1
        gobsla2Memory3.screenCountPtSisa2 = gobsla2.screenCountPtSisa2
        gobsla2Memory3.screenCountPtSisa3 = gobsla2.screenCountPtSisa3
        gobsla2Memory3.screenCountPtSisa4 = gobsla2.screenCountPtSisa4
        gobsla2Memory3.screenCountHighJaku = gobsla2.screenCountHighJaku
        gobsla2Memory3.screenCountOver2 = gobsla2.screenCountOver2
        gobsla2Memory3.screenCountGusu = gobsla2.screenCountGusu
        gobsla2Memory3.screenCountOver4 = gobsla2.screenCountOver4
        gobsla2Memory3.screenCountOver6 = gobsla2.screenCountOver6
        gobsla2Memory3.screenCountSum = gobsla2.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct gobsla2SubViewLoadMemory: View {
    @ObservedObject var gobsla2: Gobsla2
    @ObservedObject var gobsla2Memory1: Gobsla2Memory1
    @ObservedObject var gobsla2Memory2: Gobsla2Memory2
    @ObservedObject var gobsla2Memory3: Gobsla2Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: gobsla2.machineName,
            selectedMemory: $gobsla2.selectedMemory,
            memoMemory1: gobsla2Memory1.memo,
            dateDoubleMemory1: gobsla2Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: gobsla2Memory2.memo,
            dateDoubleMemory2: gobsla2Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: gobsla2Memory3.memo,
            dateDoubleMemory3: gobsla2Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        gobsla2.jakuRareCountJakuCherry = gobsla2Memory1.jakuRareCountJakuCherry
        gobsla2.jakuRareCountSuika = gobsla2Memory1.jakuRareCountSuika
        gobsla2.jakuRareCountSum = gobsla2Memory1.jakuRareCountSum
        gobsla2.jakuRareCountHit = gobsla2Memory1.jakuRareCountHit
        gobsla2.game35HitCountMiss = gobsla2Memory1.game35HitCountMiss
        gobsla2.game35HitCountHit = gobsla2Memory1.game35HitCountHit
        gobsla2.game35HitCountSum = gobsla2Memory1.game35HitCountSum
        gobsla2.ptCount10 = gobsla2Memory1.ptCount10
        gobsla2.ptCount20 = gobsla2Memory1.ptCount20
        gobsla2.ptCount30 = gobsla2Memory1.ptCount30
        gobsla2.ptCount40 = gobsla2Memory1.ptCount40
        gobsla2.ptCount50 = gobsla2Memory1.ptCount50
        gobsla2.ptCount60 = gobsla2Memory1.ptCount60
        gobsla2.ptCount70 = gobsla2Memory1.ptCount70
        gobsla2.ptCount80 = gobsla2Memory1.ptCount80
        gobsla2.ptCount90 = gobsla2Memory1.ptCount90
        gobsla2.ptCount100 = gobsla2Memory1.ptCount100
        gobsla2.ptCountSum = gobsla2Memory1.ptCountSum
        gobsla2.ptCountU20 = gobsla2Memory1.ptCountU20
        gobsla2.ptCountO40 = gobsla2Memory1.ptCountO40
        gobsla2.inputGame = gobsla2Memory1.inputGame
        gobsla2.selectedKind = gobsla2Memory1.selectedKind
        gobsla2.selectedAtHit = gobsla2Memory1.selectedAtHit
        let array = decodeIntArray(from: gobsla2Memory1.gameArrayData)
        saveArray(array, forKey: gobsla2.gameArrayKey)
//        gobsla2.gameArrayData = gobsla2Memory1.gameArrayData
        let array2 = decodeStringArray(from: gobsla2Memory1.kindArrayData)
        saveArray(array2, forKey: gobsla2.kindArrayKey)
//        gobsla2.kindArrayData = gobsla2Memory1.kindArrayData
        let array3 = decodeStringArray(from: gobsla2Memory1.atHitArrayData)
        saveArray(array3, forKey: gobsla2.atHitArrayKey)
//        gobsla2.atHitArrayData = gobsla2Memory1.atHitArrayData
        gobsla2.normalGame = gobsla2Memory1.normalGame
        gobsla2.czCount = gobsla2Memory1.czCount
        gobsla2.atCount = gobsla2Memory1.atCount
        gobsla2.screenCountDefault = gobsla2Memory1.screenCountDefault
        gobsla2.screenCountPtSisa1 = gobsla2Memory1.screenCountPtSisa1
        gobsla2.screenCountPtSisa2 = gobsla2Memory1.screenCountPtSisa2
        gobsla2.screenCountPtSisa3 = gobsla2Memory1.screenCountPtSisa3
        gobsla2.screenCountPtSisa4 = gobsla2Memory1.screenCountPtSisa4
        gobsla2.screenCountHighJaku = gobsla2Memory1.screenCountHighJaku
        gobsla2.screenCountOver2 = gobsla2Memory1.screenCountOver2
        gobsla2.screenCountGusu = gobsla2Memory1.screenCountGusu
        gobsla2.screenCountOver4 = gobsla2Memory1.screenCountOver4
        gobsla2.screenCountOver6 = gobsla2Memory1.screenCountOver6
        gobsla2.screenCountSum = gobsla2Memory1.screenCountSum
    }
    func loadMemory2() {
        gobsla2.jakuRareCountJakuCherry = gobsla2Memory2.jakuRareCountJakuCherry
        gobsla2.jakuRareCountSuika = gobsla2Memory2.jakuRareCountSuika
        gobsla2.jakuRareCountSum = gobsla2Memory2.jakuRareCountSum
        gobsla2.jakuRareCountHit = gobsla2Memory2.jakuRareCountHit
        gobsla2.game35HitCountMiss = gobsla2Memory2.game35HitCountMiss
        gobsla2.game35HitCountHit = gobsla2Memory2.game35HitCountHit
        gobsla2.game35HitCountSum = gobsla2Memory2.game35HitCountSum
        gobsla2.ptCount10 = gobsla2Memory2.ptCount10
        gobsla2.ptCount20 = gobsla2Memory2.ptCount20
        gobsla2.ptCount30 = gobsla2Memory2.ptCount30
        gobsla2.ptCount40 = gobsla2Memory2.ptCount40
        gobsla2.ptCount50 = gobsla2Memory2.ptCount50
        gobsla2.ptCount60 = gobsla2Memory2.ptCount60
        gobsla2.ptCount70 = gobsla2Memory2.ptCount70
        gobsla2.ptCount80 = gobsla2Memory2.ptCount80
        gobsla2.ptCount90 = gobsla2Memory2.ptCount90
        gobsla2.ptCount100 = gobsla2Memory2.ptCount100
        gobsla2.ptCountSum = gobsla2Memory2.ptCountSum
        gobsla2.ptCountU20 = gobsla2Memory2.ptCountU20
        gobsla2.ptCountO40 = gobsla2Memory2.ptCountO40
        gobsla2.inputGame = gobsla2Memory2.inputGame
        gobsla2.selectedKind = gobsla2Memory2.selectedKind
        gobsla2.selectedAtHit = gobsla2Memory2.selectedAtHit
        let array = decodeIntArray(from: gobsla2Memory2.gameArrayData)
        saveArray(array, forKey: gobsla2.gameArrayKey)
//        gobsla2.gameArrayData = gobsla2Memory1.gameArrayData
        let array2 = decodeStringArray(from: gobsla2Memory2.kindArrayData)
        saveArray(array2, forKey: gobsla2.kindArrayKey)
//        gobsla2.kindArrayData = gobsla2Memory1.kindArrayData
        let array3 = decodeStringArray(from: gobsla2Memory2.atHitArrayData)
        saveArray(array3, forKey: gobsla2.atHitArrayKey)
//        gobsla2.atHitArrayData = gobsla2Memory1.atHitArrayData
        gobsla2.normalGame = gobsla2Memory2.normalGame
        gobsla2.czCount = gobsla2Memory2.czCount
        gobsla2.atCount = gobsla2Memory2.atCount
        gobsla2.screenCountDefault = gobsla2Memory2.screenCountDefault
        gobsla2.screenCountPtSisa1 = gobsla2Memory2.screenCountPtSisa1
        gobsla2.screenCountPtSisa2 = gobsla2Memory2.screenCountPtSisa2
        gobsla2.screenCountPtSisa3 = gobsla2Memory2.screenCountPtSisa3
        gobsla2.screenCountPtSisa4 = gobsla2Memory2.screenCountPtSisa4
        gobsla2.screenCountHighJaku = gobsla2Memory2.screenCountHighJaku
        gobsla2.screenCountOver2 = gobsla2Memory2.screenCountOver2
        gobsla2.screenCountGusu = gobsla2Memory2.screenCountGusu
        gobsla2.screenCountOver4 = gobsla2Memory2.screenCountOver4
        gobsla2.screenCountOver6 = gobsla2Memory2.screenCountOver6
        gobsla2.screenCountSum = gobsla2Memory2.screenCountSum
    }
    func loadMemory3() {
        gobsla2.jakuRareCountJakuCherry = gobsla2Memory3.jakuRareCountJakuCherry
        gobsla2.jakuRareCountSuika = gobsla2Memory3.jakuRareCountSuika
        gobsla2.jakuRareCountSum = gobsla2Memory3.jakuRareCountSum
        gobsla2.jakuRareCountHit = gobsla2Memory3.jakuRareCountHit
        gobsla2.game35HitCountMiss = gobsla2Memory3.game35HitCountMiss
        gobsla2.game35HitCountHit = gobsla2Memory3.game35HitCountHit
        gobsla2.game35HitCountSum = gobsla2Memory3.game35HitCountSum
        gobsla2.ptCount10 = gobsla2Memory3.ptCount10
        gobsla2.ptCount20 = gobsla2Memory3.ptCount20
        gobsla2.ptCount30 = gobsla2Memory3.ptCount30
        gobsla2.ptCount40 = gobsla2Memory3.ptCount40
        gobsla2.ptCount50 = gobsla2Memory3.ptCount50
        gobsla2.ptCount60 = gobsla2Memory3.ptCount60
        gobsla2.ptCount70 = gobsla2Memory3.ptCount70
        gobsla2.ptCount80 = gobsla2Memory3.ptCount80
        gobsla2.ptCount90 = gobsla2Memory3.ptCount90
        gobsla2.ptCount100 = gobsla2Memory3.ptCount100
        gobsla2.ptCountSum = gobsla2Memory3.ptCountSum
        gobsla2.ptCountU20 = gobsla2Memory3.ptCountU20
        gobsla2.ptCountO40 = gobsla2Memory3.ptCountO40
        gobsla2.inputGame = gobsla2Memory3.inputGame
        gobsla2.selectedKind = gobsla2Memory3.selectedKind
        gobsla2.selectedAtHit = gobsla2Memory3.selectedAtHit
        let array = decodeIntArray(from: gobsla2Memory3.gameArrayData)
        saveArray(array, forKey: gobsla2.gameArrayKey)
//        gobsla2.gameArrayData = gobsla2Memory1.gameArrayData
        let array2 = decodeStringArray(from: gobsla2Memory3.kindArrayData)
        saveArray(array2, forKey: gobsla2.kindArrayKey)
//        gobsla2.kindArrayData = gobsla2Memory1.kindArrayData
        let array3 = decodeStringArray(from: gobsla2Memory3.atHitArrayData)
        saveArray(array3, forKey: gobsla2.atHitArrayKey)
//        gobsla2.atHitArrayData = gobsla2Memory1.atHitArrayData
        gobsla2.normalGame = gobsla2Memory3.normalGame
        gobsla2.czCount = gobsla2Memory3.czCount
        gobsla2.atCount = gobsla2Memory3.atCount
        gobsla2.screenCountDefault = gobsla2Memory3.screenCountDefault
        gobsla2.screenCountPtSisa1 = gobsla2Memory3.screenCountPtSisa1
        gobsla2.screenCountPtSisa2 = gobsla2Memory3.screenCountPtSisa2
        gobsla2.screenCountPtSisa3 = gobsla2Memory3.screenCountPtSisa3
        gobsla2.screenCountPtSisa4 = gobsla2Memory3.screenCountPtSisa4
        gobsla2.screenCountHighJaku = gobsla2Memory3.screenCountHighJaku
        gobsla2.screenCountOver2 = gobsla2Memory3.screenCountOver2
        gobsla2.screenCountGusu = gobsla2Memory3.screenCountGusu
        gobsla2.screenCountOver4 = gobsla2Memory3.screenCountOver4
        gobsla2.screenCountOver6 = gobsla2Memory3.screenCountOver6
        gobsla2.screenCountSum = gobsla2Memory3.screenCountSum
    }
}

#Preview {
    gobsla2ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
