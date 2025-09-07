//
//  darlingViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/27.
//

import SwiftUI

struct darlingViewTop: View {
//    @ObservedObject var ver380: Ver380
    @ObservedObject var ver390: Ver390
    @StateObject var darling = Darling()
    @State var isShowAlert: Bool = false
    @StateObject var darlingMemory1 = DarlingMemory1()
    @StateObject var darlingMemory2 = DarlingMemory2()
    @StateObject var darlingMemory3 = DarlingMemory3()
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: darlingViewNormal(
//                        ver380: ver380,
                        ver390: ver390,
                        darling: darling,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
//                            badgeStatus: ver380.darlingMenuNormalBadge,
                        )
                    }
                    // 初当り
                    NavigationLink(destination: darlingViewFirstHit(
                        ver390: ver390,
                        darling: darling,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
//                            badgeStatus: ver370.darlingMenuFirstHitBadge,
                        )
                    }
                    // CZ 開始時の初期レベル
                    NavigationLink(destination: darlingViewCz(
                        ver390: ver390,
                        darling: darling,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "dot.scope",
                            textBody: "CZ コネクトチャンス",
                            badgeStatus: ver390.darlingMenuCzBadge,
                        )
                    }
                    // ボーナス高確率終了画面
                    NavigationLink(destination: darlingViewScreen(
                        darling: darling,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス高確率終了画面"
                        )
                    }
                    
                    // エンディング
                    NavigationLink(destination: darlingViewEnding(
                        darling: darling,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング"
                        )
                    }
                    
                    // トロフィー
                    NavigationLink(destination: commonViewNamichanTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ナミちゃんトロフィー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: darling.machineName,
                        titleFont: .title3,
                    )
                }
                
                // 設定推測グラフ
                NavigationLink(destination: darlingView95Ci(
                    darling: darling,
                    selection: 1
                )) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                
                // 設定期待値計算
                NavigationLink(destination: darlingViewBayes(
                    ver390: ver390,
                    darling: darling,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: ver390.darlingMenuBayesBadge,
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4855"
                )
                
                // コピーライト
                unitSectionCopyright {
                    Text("©ダーリン・イン・ザ・フランキス製作委員会")
                    Text("©︎SPIKY")
                    Text("©︎CROSSALPHA")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver390.darlingMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: darling.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(darlingSubViewLoadMemory(
                        darling: darling,
                        darlingMemory1: darlingMemory1,
                        darlingMemory2: darlingMemory2,
                        darlingMemory3: darlingMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(darlingSubViewSaveMemory(
                        darling: darling,
                        darlingMemory1: darlingMemory1,
                        darlingMemory2: darlingMemory2,
                        darlingMemory3: darlingMemory3
                    )))
                }
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: darling.resetAll, message: "この機種のデータを全てリセットします")
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct darlingSubViewSaveMemory: View {
    @ObservedObject var darling: Darling
    @ObservedObject var darlingMemory1: DarlingMemory1
    @ObservedObject var darlingMemory2: DarlingMemory2
    @ObservedObject var darlingMemory3: DarlingMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: darling.machineName,
            selectedMemory: $darling.selectedMemory,
            memoMemory1: $darlingMemory1.memo,
            dateDoubleMemory1: $darlingMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $darlingMemory2.memo,
            dateDoubleMemory2: $darlingMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $darlingMemory3.memo,
            dateDoubleMemory3: $darlingMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        darlingMemory1.gameArrayData = darling.gameArrayData
        darlingMemory1.firstKindArrayData = darling.firstKindArrayData
        darlingMemory1.bonusKindArrayData = darling.bonusKindArrayData
        darlingMemory1.kokakuHitArrayData = darling.kokakuHitArrayData
        darlingMemory1.normalGame = darling.normalGame
        darlingMemory1.czCount = darling.czCount
        darlingMemory1.bonusCount = darling.bonusCount
        darlingMemory1.kokakuCount = darling.kokakuCount
        darlingMemory1.endingCountDefault = darling.endingCountDefault
        darlingMemory1.endingCount13sisa = darling.endingCount13sisa
        darlingMemory1.endingCount245sisa = darling.endingCount245sisa
        darlingMemory1.endingCount5sisa = darling.endingCount5sisa
        darlingMemory1.endingCountOver2 = darling.endingCountOver2
        darlingMemory1.endingCountOver6 = darling.endingCountOver6
        darlingMemory1.endingCountSum = darling.endingCountSum
        
        // ///////////
        // ver3.8.0で追加
        // ///////////
        darlingMemory1.kokakuCountCherryMiss = darling.kokakuCountCherryMiss
        darlingMemory1.kokakuCountCherryHit = darling.kokakuCountCherryHit
        darlingMemory1.kokakuCountCherrySum = darling.kokakuCountCherrySum
        darlingMemory1.kokakuCountChanceMiss = darling.kokakuCountChanceMiss
        darlingMemory1.kokakuCountChanceHit = darling.kokakuCountChanceHit
        darlingMemory1.kokakuCountChanceSum = darling.kokakuCountChanceSum
        darlingMemory1.czLevelCountWhite = darling.czLevelCountWhite
        darlingMemory1.czLevelCountBlue = darling.czLevelCountBlue
        darlingMemory1.czLevelCountYellow = darling.czLevelCountYellow
        darlingMemory1.czLevelCountGreen = darling.czLevelCountGreen
        darlingMemory1.czLevelCountRed = darling.czLevelCountRed
        darlingMemory1.czLevelCountSum = darling.czLevelCountSum
        
        // ///////////
        // ver3.9.0で追加
        // ///////////
        darlingMemory1.czFLCountWhiteMiss = darling.czFLCountWhiteMiss
        darlingMemory1.czFLCountWhiteHit = darling.czFLCountWhiteHit
        darlingMemory1.czFLCountWhiteSum = darling.czFLCountWhiteSum
        darlingMemory1.czFLCountBlueMiss = darling.czFLCountBlueMiss
        darlingMemory1.czFLCountBlueHit = darling.czFLCountBlueHit
        darlingMemory1.czFLCountBlueSum = darling.czFLCountBlueSum
        darlingMemory1.czFLCountYellowMiss = darling.czFLCountYellowMiss
        darlingMemory1.czFLCountYellowHit = darling.czFLCountYellowHit
        darlingMemory1.czFLCountYellowSum = darling.czFLCountYellowSum
        darlingMemory1.czFLCountGreenMiss = darling.czFLCountGreenMiss
        darlingMemory1.czFLCountGreenHit = darling.czFLCountGreenHit
        darlingMemory1.czFLCountGreenSum = darling.czFLCountGreenSum
        darlingMemory1.czFLCountRedMiss = darling.czFLCountRedMiss
        darlingMemory1.czFLCountRedHit = darling.czFLCountRedHit
        darlingMemory1.czFLCountRedSum = darling.czFLCountRedSum
    }
    func saveMemory2() {
        darlingMemory2.gameArrayData = darling.gameArrayData
        darlingMemory2.firstKindArrayData = darling.firstKindArrayData
        darlingMemory2.bonusKindArrayData = darling.bonusKindArrayData
        darlingMemory2.kokakuHitArrayData = darling.kokakuHitArrayData
        darlingMemory2.normalGame = darling.normalGame
        darlingMemory2.czCount = darling.czCount
        darlingMemory2.bonusCount = darling.bonusCount
        darlingMemory2.kokakuCount = darling.kokakuCount
        darlingMemory2.endingCountDefault = darling.endingCountDefault
        darlingMemory2.endingCount13sisa = darling.endingCount13sisa
        darlingMemory2.endingCount245sisa = darling.endingCount245sisa
        darlingMemory2.endingCount5sisa = darling.endingCount5sisa
        darlingMemory2.endingCountOver2 = darling.endingCountOver2
        darlingMemory2.endingCountOver6 = darling.endingCountOver6
        darlingMemory2.endingCountSum = darling.endingCountSum
        
        // ///////////
        // ver3.8.0で追加
        // ///////////
        darlingMemory2.kokakuCountCherryMiss = darling.kokakuCountCherryMiss
        darlingMemory2.kokakuCountCherryHit = darling.kokakuCountCherryHit
        darlingMemory2.kokakuCountCherrySum = darling.kokakuCountCherrySum
        darlingMemory2.kokakuCountChanceMiss = darling.kokakuCountChanceMiss
        darlingMemory2.kokakuCountChanceHit = darling.kokakuCountChanceHit
        darlingMemory2.kokakuCountChanceSum = darling.kokakuCountChanceSum
        darlingMemory2.czLevelCountWhite = darling.czLevelCountWhite
        darlingMemory2.czLevelCountBlue = darling.czLevelCountBlue
        darlingMemory2.czLevelCountYellow = darling.czLevelCountYellow
        darlingMemory2.czLevelCountGreen = darling.czLevelCountGreen
        darlingMemory2.czLevelCountRed = darling.czLevelCountRed
        darlingMemory2.czLevelCountSum = darling.czLevelCountSum
        
        // ///////////
        // ver3.9.0で追加
        // ///////////
        darlingMemory2.czFLCountWhiteMiss = darling.czFLCountWhiteMiss
        darlingMemory2.czFLCountWhiteHit = darling.czFLCountWhiteHit
        darlingMemory2.czFLCountWhiteSum = darling.czFLCountWhiteSum
        darlingMemory2.czFLCountBlueMiss = darling.czFLCountBlueMiss
        darlingMemory2.czFLCountBlueHit = darling.czFLCountBlueHit
        darlingMemory2.czFLCountBlueSum = darling.czFLCountBlueSum
        darlingMemory2.czFLCountYellowMiss = darling.czFLCountYellowMiss
        darlingMemory2.czFLCountYellowHit = darling.czFLCountYellowHit
        darlingMemory2.czFLCountYellowSum = darling.czFLCountYellowSum
        darlingMemory2.czFLCountGreenMiss = darling.czFLCountGreenMiss
        darlingMemory2.czFLCountGreenHit = darling.czFLCountGreenHit
        darlingMemory2.czFLCountGreenSum = darling.czFLCountGreenSum
        darlingMemory2.czFLCountRedMiss = darling.czFLCountRedMiss
        darlingMemory2.czFLCountRedHit = darling.czFLCountRedHit
        darlingMemory2.czFLCountRedSum = darling.czFLCountRedSum
    }
    func saveMemory3() {
        darlingMemory3.gameArrayData = darling.gameArrayData
        darlingMemory3.firstKindArrayData = darling.firstKindArrayData
        darlingMemory3.bonusKindArrayData = darling.bonusKindArrayData
        darlingMemory3.kokakuHitArrayData = darling.kokakuHitArrayData
        darlingMemory3.normalGame = darling.normalGame
        darlingMemory3.czCount = darling.czCount
        darlingMemory3.bonusCount = darling.bonusCount
        darlingMemory3.kokakuCount = darling.kokakuCount
        darlingMemory3.endingCountDefault = darling.endingCountDefault
        darlingMemory3.endingCount13sisa = darling.endingCount13sisa
        darlingMemory3.endingCount245sisa = darling.endingCount245sisa
        darlingMemory3.endingCount5sisa = darling.endingCount5sisa
        darlingMemory3.endingCountOver2 = darling.endingCountOver2
        darlingMemory3.endingCountOver6 = darling.endingCountOver6
        darlingMemory3.endingCountSum = darling.endingCountSum
        
        // ///////////
        // ver3.8.0で追加
        // ///////////
        darlingMemory3.kokakuCountCherryMiss = darling.kokakuCountCherryMiss
        darlingMemory3.kokakuCountCherryHit = darling.kokakuCountCherryHit
        darlingMemory3.kokakuCountCherrySum = darling.kokakuCountCherrySum
        darlingMemory3.kokakuCountChanceMiss = darling.kokakuCountChanceMiss
        darlingMemory3.kokakuCountChanceHit = darling.kokakuCountChanceHit
        darlingMemory3.kokakuCountChanceSum = darling.kokakuCountChanceSum
        darlingMemory3.czLevelCountWhite = darling.czLevelCountWhite
        darlingMemory3.czLevelCountBlue = darling.czLevelCountBlue
        darlingMemory3.czLevelCountYellow = darling.czLevelCountYellow
        darlingMemory3.czLevelCountGreen = darling.czLevelCountGreen
        darlingMemory3.czLevelCountRed = darling.czLevelCountRed
        darlingMemory3.czLevelCountSum = darling.czLevelCountSum
        
        // ///////////
        // ver3.9.0で追加
        // ///////////
        darlingMemory3.czFLCountWhiteMiss = darling.czFLCountWhiteMiss
        darlingMemory3.czFLCountWhiteHit = darling.czFLCountWhiteHit
        darlingMemory3.czFLCountWhiteSum = darling.czFLCountWhiteSum
        darlingMemory3.czFLCountBlueMiss = darling.czFLCountBlueMiss
        darlingMemory3.czFLCountBlueHit = darling.czFLCountBlueHit
        darlingMemory3.czFLCountBlueSum = darling.czFLCountBlueSum
        darlingMemory3.czFLCountYellowMiss = darling.czFLCountYellowMiss
        darlingMemory3.czFLCountYellowHit = darling.czFLCountYellowHit
        darlingMemory3.czFLCountYellowSum = darling.czFLCountYellowSum
        darlingMemory3.czFLCountGreenMiss = darling.czFLCountGreenMiss
        darlingMemory3.czFLCountGreenHit = darling.czFLCountGreenHit
        darlingMemory3.czFLCountGreenSum = darling.czFLCountGreenSum
        darlingMemory3.czFLCountRedMiss = darling.czFLCountRedMiss
        darlingMemory3.czFLCountRedHit = darling.czFLCountRedHit
        darlingMemory3.czFLCountRedSum = darling.czFLCountRedSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct darlingSubViewLoadMemory: View {
    @ObservedObject var darling: Darling
    @ObservedObject var darlingMemory1: DarlingMemory1
    @ObservedObject var darlingMemory2: DarlingMemory2
    @ObservedObject var darlingMemory3: DarlingMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: darling.machineName,
            selectedMemory: $darling.selectedMemory,
            memoMemory1: darlingMemory1.memo,
            dateDoubleMemory1: darlingMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: darlingMemory2.memo,
            dateDoubleMemory2: darlingMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: darlingMemory3.memo,
            dateDoubleMemory3: darlingMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        let array = decodeIntArray(from: darlingMemory1.gameArrayData)
        saveArray(array, forKey: darling.gameArrayKey)
        let array2 = decodeStringArray(from: darlingMemory1.firstKindArrayData)
        saveArray(array2, forKey: darling.firstKindArrayKey)
        let array3 = decodeStringArray(from: darlingMemory1.bonusKindArrayData)
        saveArray(array3, forKey: darling.bonusKindArrayKey)
        let array4 = decodeStringArray(from: darlingMemory1.kokakuHitArrayData)
        saveArray(array4, forKey: darling.kokakuHitArrayKey)
        darling.normalGame = darlingMemory1.normalGame
        darling.czCount = darlingMemory1.czCount
        darling.bonusCount = darlingMemory1.bonusCount
        darling.kokakuCount = darlingMemory1.kokakuCount
        darling.endingCountDefault = darlingMemory1.endingCountDefault
        darling.endingCount13sisa = darlingMemory1.endingCount13sisa
        darling.endingCount245sisa = darlingMemory1.endingCount245sisa
        darling.endingCount5sisa = darlingMemory1.endingCount5sisa
        darling.endingCountOver2 = darlingMemory1.endingCountOver2
        darling.endingCountOver6 = darlingMemory1.endingCountOver6
        darling.endingCountSum = darlingMemory1.endingCountSum
        
        // ///////////
        // ver3.8.0で追加
        // ///////////
        darling.kokakuCountCherryMiss = darlingMemory1.kokakuCountCherryMiss
        darling.kokakuCountCherryHit = darlingMemory1.kokakuCountCherryHit
        darling.kokakuCountCherrySum = darlingMemory1.kokakuCountCherrySum
        darling.kokakuCountChanceMiss = darlingMemory1.kokakuCountChanceMiss
        darling.kokakuCountChanceHit = darlingMemory1.kokakuCountChanceHit
        darling.kokakuCountChanceSum = darlingMemory1.kokakuCountChanceSum
        darling.czLevelCountWhite = darlingMemory1.czLevelCountWhite
        darling.czLevelCountBlue = darlingMemory1.czLevelCountBlue
        darling.czLevelCountYellow = darlingMemory1.czLevelCountYellow
        darling.czLevelCountGreen = darlingMemory1.czLevelCountGreen
        darling.czLevelCountRed = darlingMemory1.czLevelCountRed
        darling.czLevelCountSum = darlingMemory1.czLevelCountSum
        
        // ///////////
        // ver3.9.0で追加
        // ///////////
        darling.czFLCountWhiteMiss = darlingMemory1.czFLCountWhiteMiss
        darling.czFLCountWhiteHit = darlingMemory1.czFLCountWhiteHit
        darling.czFLCountWhiteSum = darlingMemory1.czFLCountWhiteSum
        darling.czFLCountBlueMiss = darlingMemory1.czFLCountBlueMiss
        darling.czFLCountBlueHit = darlingMemory1.czFLCountBlueHit
        darling.czFLCountBlueSum = darlingMemory1.czFLCountBlueSum
        darling.czFLCountYellowMiss = darlingMemory1.czFLCountYellowMiss
        darling.czFLCountYellowHit = darlingMemory1.czFLCountYellowHit
        darling.czFLCountYellowSum = darlingMemory1.czFLCountYellowSum
        darling.czFLCountGreenMiss = darlingMemory1.czFLCountGreenMiss
        darling.czFLCountGreenHit = darlingMemory1.czFLCountGreenHit
        darling.czFLCountGreenSum = darlingMemory1.czFLCountGreenSum
        darling.czFLCountRedMiss = darlingMemory1.czFLCountRedMiss
        darling.czFLCountRedHit = darlingMemory1.czFLCountRedHit
        darling.czFLCountRedSum = darlingMemory1.czFLCountRedSum
    }
    func loadMemory2() {
        let array = decodeIntArray(from: darlingMemory2.gameArrayData)
        saveArray(array, forKey: darling.gameArrayKey)
        let array2 = decodeStringArray(from: darlingMemory2.firstKindArrayData)
        saveArray(array2, forKey: darling.firstKindArrayKey)
        let array3 = decodeStringArray(from: darlingMemory2.bonusKindArrayData)
        saveArray(array3, forKey: darling.bonusKindArrayKey)
        let array4 = decodeStringArray(from: darlingMemory2.kokakuHitArrayData)
        saveArray(array4, forKey: darling.kokakuHitArrayKey)
        darling.normalGame = darlingMemory2.normalGame
        darling.czCount = darlingMemory2.czCount
        darling.bonusCount = darlingMemory2.bonusCount
        darling.kokakuCount = darlingMemory2.kokakuCount
        darling.endingCountDefault = darlingMemory2.endingCountDefault
        darling.endingCount13sisa = darlingMemory2.endingCount13sisa
        darling.endingCount245sisa = darlingMemory2.endingCount245sisa
        darling.endingCount5sisa = darlingMemory2.endingCount5sisa
        darling.endingCountOver2 = darlingMemory2.endingCountOver2
        darling.endingCountOver6 = darlingMemory2.endingCountOver6
        darling.endingCountSum = darlingMemory2.endingCountSum
        
        // ///////////
        // ver3.8.0で追加
        // ///////////
        darling.kokakuCountCherryMiss = darlingMemory2.kokakuCountCherryMiss
        darling.kokakuCountCherryHit = darlingMemory2.kokakuCountCherryHit
        darling.kokakuCountCherrySum = darlingMemory2.kokakuCountCherrySum
        darling.kokakuCountChanceMiss = darlingMemory2.kokakuCountChanceMiss
        darling.kokakuCountChanceHit = darlingMemory2.kokakuCountChanceHit
        darling.kokakuCountChanceSum = darlingMemory2.kokakuCountChanceSum
        darling.czLevelCountWhite = darlingMemory2.czLevelCountWhite
        darling.czLevelCountBlue = darlingMemory2.czLevelCountBlue
        darling.czLevelCountYellow = darlingMemory2.czLevelCountYellow
        darling.czLevelCountGreen = darlingMemory2.czLevelCountGreen
        darling.czLevelCountRed = darlingMemory2.czLevelCountRed
        darling.czLevelCountSum = darlingMemory2.czLevelCountSum
        
        // ///////////
        // ver3.9.0で追加
        // ///////////
        darling.czFLCountWhiteMiss = darlingMemory2.czFLCountWhiteMiss
        darling.czFLCountWhiteHit = darlingMemory2.czFLCountWhiteHit
        darling.czFLCountWhiteSum = darlingMemory2.czFLCountWhiteSum
        darling.czFLCountBlueMiss = darlingMemory2.czFLCountBlueMiss
        darling.czFLCountBlueHit = darlingMemory2.czFLCountBlueHit
        darling.czFLCountBlueSum = darlingMemory2.czFLCountBlueSum
        darling.czFLCountYellowMiss = darlingMemory2.czFLCountYellowMiss
        darling.czFLCountYellowHit = darlingMemory2.czFLCountYellowHit
        darling.czFLCountYellowSum = darlingMemory2.czFLCountYellowSum
        darling.czFLCountGreenMiss = darlingMemory2.czFLCountGreenMiss
        darling.czFLCountGreenHit = darlingMemory2.czFLCountGreenHit
        darling.czFLCountGreenSum = darlingMemory2.czFLCountGreenSum
        darling.czFLCountRedMiss = darlingMemory2.czFLCountRedMiss
        darling.czFLCountRedHit = darlingMemory2.czFLCountRedHit
        darling.czFLCountRedSum = darlingMemory2.czFLCountRedSum
    }
    func loadMemory3() {
        let array = decodeIntArray(from: darlingMemory3.gameArrayData)
        saveArray(array, forKey: darling.gameArrayKey)
        let array2 = decodeStringArray(from: darlingMemory3.firstKindArrayData)
        saveArray(array2, forKey: darling.firstKindArrayKey)
        let array3 = decodeStringArray(from: darlingMemory3.bonusKindArrayData)
        saveArray(array3, forKey: darling.bonusKindArrayKey)
        let array4 = decodeStringArray(from: darlingMemory3.kokakuHitArrayData)
        saveArray(array4, forKey: darling.kokakuHitArrayKey)
        darling.normalGame = darlingMemory3.normalGame
        darling.czCount = darlingMemory3.czCount
        darling.bonusCount = darlingMemory3.bonusCount
        darling.kokakuCount = darlingMemory3.kokakuCount
        darling.endingCountDefault = darlingMemory3.endingCountDefault
        darling.endingCount13sisa = darlingMemory3.endingCount13sisa
        darling.endingCount245sisa = darlingMemory3.endingCount245sisa
        darling.endingCount5sisa = darlingMemory3.endingCount5sisa
        darling.endingCountOver2 = darlingMemory3.endingCountOver2
        darling.endingCountOver6 = darlingMemory3.endingCountOver6
        darling.endingCountSum = darlingMemory3.endingCountSum
        
        // ///////////
        // ver3.8.0で追加
        // ///////////
        darling.kokakuCountCherryMiss = darlingMemory3.kokakuCountCherryMiss
        darling.kokakuCountCherryHit = darlingMemory3.kokakuCountCherryHit
        darling.kokakuCountCherrySum = darlingMemory3.kokakuCountCherrySum
        darling.kokakuCountChanceMiss = darlingMemory3.kokakuCountChanceMiss
        darling.kokakuCountChanceHit = darlingMemory3.kokakuCountChanceHit
        darling.kokakuCountChanceSum = darlingMemory3.kokakuCountChanceSum
        darling.czLevelCountWhite = darlingMemory3.czLevelCountWhite
        darling.czLevelCountBlue = darlingMemory3.czLevelCountBlue
        darling.czLevelCountYellow = darlingMemory3.czLevelCountYellow
        darling.czLevelCountGreen = darlingMemory3.czLevelCountGreen
        darling.czLevelCountRed = darlingMemory3.czLevelCountRed
        darling.czLevelCountSum = darlingMemory3.czLevelCountSum
        
        // ///////////
        // ver3.9.0で追加
        // ///////////
        darling.czFLCountWhiteMiss = darlingMemory3.czFLCountWhiteMiss
        darling.czFLCountWhiteHit = darlingMemory3.czFLCountWhiteHit
        darling.czFLCountWhiteSum = darlingMemory3.czFLCountWhiteSum
        darling.czFLCountBlueMiss = darlingMemory3.czFLCountBlueMiss
        darling.czFLCountBlueHit = darlingMemory3.czFLCountBlueHit
        darling.czFLCountBlueSum = darlingMemory3.czFLCountBlueSum
        darling.czFLCountYellowMiss = darlingMemory3.czFLCountYellowMiss
        darling.czFLCountYellowHit = darlingMemory3.czFLCountYellowHit
        darling.czFLCountYellowSum = darlingMemory3.czFLCountYellowSum
        darling.czFLCountGreenMiss = darlingMemory3.czFLCountGreenMiss
        darling.czFLCountGreenHit = darlingMemory3.czFLCountGreenHit
        darling.czFLCountGreenSum = darlingMemory3.czFLCountGreenSum
        darling.czFLCountRedMiss = darlingMemory3.czFLCountRedMiss
        darling.czFLCountRedHit = darlingMemory3.czFLCountRedHit
        darling.czFLCountRedSum = darlingMemory3.czFLCountRedSum
    }
}

#Preview {
    darlingViewTop(
//        ver380: Ver380(),
        ver390: Ver390(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
