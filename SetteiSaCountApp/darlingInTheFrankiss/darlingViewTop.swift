//
//  darlingViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/27.
//

import SwiftUI

struct darlingViewTop: View {
    @ObservedObject var ver380: Ver380
    @StateObject var darling = Darling()
    @State var isShowAlert: Bool = false
    @StateObject var darlingMemory1 = DarlingMemory1()
    @StateObject var darlingMemory2 = DarlingMemory2()
    @StateObject var darlingMemory3 = DarlingMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: darlingViewNormal(
                        ver380: ver380,
                        darling: darling,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: ver380.darlingMenuNormalBadge,
                        )
                    }
                    // 初当り
                    NavigationLink(destination: darlingViewFirstHit(
//                        ver370: ver370,
                        darling: darling,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
//                            badgeStatus: ver370.darlingMenuFirstHitBadge,
                        )
                    }
                    // CZ 開始時の初期レベル
                    NavigationLink(destination: darlingViewCz(
                        ver380: ver380,
                        darling: darling,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "dot.scope",
                            textBody: "CZ 開始時の初期レベル",
                            badgeStatus: ver380.darlingMenuCzBadge,
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
        .resetBadgeOnAppear($ver380.darlingMachineIconBadge)
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
    }
}

#Preview {
    darlingViewTop(
        ver380: Ver380(),
    )
}
