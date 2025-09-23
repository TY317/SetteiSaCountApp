//
//  toreveViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/02.
//

import SwiftUI

struct toreveViewTop: View {
//    @ObservedObject var ver390: Ver390
    @ObservedObject var ver391: Ver391
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var toreve = Toreve()
    @State var isShowAlert: Bool = false
    @StateObject var toreveMemory1 = ToreveMemory1()
    @StateObject var toreveMemory2 = ToreveMemory2()
    @StateObject var toreveMemory3 = ToreveMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("マイスロの利用を前提としています\n遊技前にマイスロを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: toreve.machineName)
                }
                
                // //// メニュー
                Section {
                    // 通常時
                    NavigationLink(destination: toreveViewNormal(
                        ver391: ver391,
                        toreve: toreve,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: ver391.toreveMenuNormalBadge,
                        )
                    }
                    // 周期履歴
                    NavigationLink(destination: toreveViewCycle(
                        ver391: ver391,
                        toreve: toreve,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "周期履歴",
                            badgeStatus: ver391.toreveMenuCycleBadge,
                        )
                    }
                    // 初当り
                    NavigationLink(destination: toreveViewFirstHit(
                        toreve: toreve,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                    // 東卍チャンス
                    NavigationLink(destination: toreveViewTomanChallenge(
                        ver391: ver391,
                        toreve: toreve,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "figure.stairs",
                            textBody: "東卍チャンス",
                            badgeStatus: ver391.toreveMenuTomanChallengeBadge,
                        )
                    }
                    // ATセット開始画面
                    NavigationLink(destination: toreveViewStartScreen(
                        ver391: ver391,
                        toreve: toreve,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "東卍ラッシュ",
                            badgeStatus: ver391.toreveMenuStartScreenBadge,
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: toreveViewScreen(
                        ver391: ver391,
                        toreve: toreve,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: ver391.toreveMenuScreenBadge,
                        )
                    }
                    // リベンジ
                    NavigationLink(destination: toreveViewRevenge(
                        toreve: toreve,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arrow.trianglehead.2.counterclockwise",
                            textBody: "リベンジ"
                        )
                    }
                    // 上位AT
                    NavigationLink(destination: toreveViewPremiumAt(
                        toreve: toreve,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "smoke.fill",
                            textBody: "東卍ラッシュバースト")
                    }
                    // エンディング
                    NavigationLink(destination: toreveViewEnding(
                        ver391: ver391,
                        toreve: toreve,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: ver391.toreveMenuEndingBadge,
                        )
                    }
                    // サミートロフィー
                    NavigationLink(destination: commonViewSammyTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "サミートロフィー"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: toreveView95Ci(
                    toreve: toreve,
                    selection: 7,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }
                // 設定期待値計算
                NavigationLink(destination: toreveViewBayes(
                    toreve: toreve,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4849")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎和久井健／講談社")
                    Text("©︎和久井健・講談社／アニメ「東京リベンジャーズ」製作委員会")
                    Text("©︎Sammy")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver391.toreveMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(toreveSubViewLoadMemory(
                        toreve: toreve,
                        toreveMemory1: toreveMemory1,
                        toreveMemory2: toreveMemory2,
                        toreveMemory3: toreveMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(toreveSubViewSaveMemory(
                        toreve: toreve,
                        toreveMemory1: toreveMemory1,
                        toreveMemory2: toreveMemory2,
                        toreveMemory3: toreveMemory3
                    )))
                }
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: toreve.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct toreveSubViewSaveMemory: View {
    @ObservedObject var toreve: Toreve
    @ObservedObject var toreveMemory1: ToreveMemory1
    @ObservedObject var toreveMemory2: ToreveMemory2
    @ObservedObject var toreveMemory3: ToreveMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: toreve.machineName,
            selectedMemory: $toreve.selectedMemory,
            memoMemory1: $toreveMemory1.memo,
            dateDoubleMemory1: $toreveMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $toreveMemory2.memo,
            dateDoubleMemory2: $toreveMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $toreveMemory3.memo,
            dateDoubleMemory3: $toreveMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        toreveMemory1.cycleArrayData = toreve.cycleArrayData
        toreveMemory1.ptArrayData = toreve.ptArrayData
        toreveMemory1.triggerArrayData = toreve.triggerArrayData
        toreveMemory1.resultArrayData = toreve.resultArrayData
        toreveMemory1.normalGame = toreve.normalGame
        toreveMemory1.czCountMidNight = toreve.czCountMidNight
        toreveMemory1.czCountKisaki = toreve.czCountKisaki
        toreveMemory1.czCountSum = toreve.czCountSum
        toreveMemory1.tomanRushCount = toreve.tomanRushCount
        toreveMemory1.tomanChallengeCount = toreve.tomanChallengeCount
        toreveMemory1.firstHitCount = toreve.firstHitCount
        toreveMemory1.screenCount1 = toreve.screenCount1
        toreveMemory1.screenCount2 = toreve.screenCount2
        toreveMemory1.screenCount3 = toreve.screenCount3
        toreveMemory1.screenCount4 = toreve.screenCount4
        toreveMemory1.screenCount5 = toreve.screenCount5
        toreveMemory1.screenCount6 = toreve.screenCount6
        toreveMemory1.screenCount7 = toreve.screenCount7
        toreveMemory1.screenCount8 = toreve.screenCount8
        toreveMemory1.screenCount9 = toreve.screenCount9
        toreveMemory1.screenCount10 = toreve.screenCount10
        toreveMemory1.screenCountSum = toreve.screenCountSum
        
        // /////////////
        // ver3.9.1で追加
        // /////////////
        toreveMemory1.gameNumberStart = toreve.gameNumberStart
        toreveMemory1.gameNumberCurrent = toreve.gameNumberCurrent
        toreveMemory1.gameNumberPlay = toreve.gameNumberPlay
        toreveMemory1.bellCount = toreve.bellCount
        toreveMemory1.atRiseCountManji = toreve.atRiseCountManji
        toreveMemory1.atRiseCountManjiRise = toreve.atRiseCountManjiRise
        toreveMemory1.atRiseCountChance = toreve.atRiseCountChance
        toreveMemory1.atRiseCountChanceRise = toreve.atRiseCountChanceRise
        toreveMemory1.atRiseCountKyoCherry = toreve.atRiseCountKyoCherry
        toreveMemory1.atRiseCountKyoCherryRise = toreve.atRiseCountKyoCherryRise
        toreveMemory1.endingCountBlue = toreve.endingCountBlue
        toreveMemory1.endingCountYellow = toreve.endingCountYellow
        toreveMemory1.endingCountGreen = toreve.endingCountGreen
        toreveMemory1.endingCountRed = toreve.endingCountRed
        toreveMemory1.endingCountRainbow = toreve.endingCountRainbow
        toreveMemory1.endingCountSum = toreve.endingCountSum
    }
    func saveMemory2() {
        toreveMemory2.cycleArrayData = toreve.cycleArrayData
        toreveMemory2.ptArrayData = toreve.ptArrayData
        toreveMemory2.triggerArrayData = toreve.triggerArrayData
        toreveMemory2.resultArrayData = toreve.resultArrayData
        toreveMemory2.normalGame = toreve.normalGame
        toreveMemory2.czCountMidNight = toreve.czCountMidNight
        toreveMemory2.czCountKisaki = toreve.czCountKisaki
        toreveMemory2.czCountSum = toreve.czCountSum
        toreveMemory2.tomanRushCount = toreve.tomanRushCount
        toreveMemory2.tomanChallengeCount = toreve.tomanChallengeCount
        toreveMemory2.firstHitCount = toreve.firstHitCount
        toreveMemory2.screenCount1 = toreve.screenCount1
        toreveMemory2.screenCount2 = toreve.screenCount2
        toreveMemory2.screenCount3 = toreve.screenCount3
        toreveMemory2.screenCount4 = toreve.screenCount4
        toreveMemory2.screenCount5 = toreve.screenCount5
        toreveMemory2.screenCount6 = toreve.screenCount6
        toreveMemory2.screenCount7 = toreve.screenCount7
        toreveMemory2.screenCount8 = toreve.screenCount8
        toreveMemory2.screenCount9 = toreve.screenCount9
        toreveMemory2.screenCount10 = toreve.screenCount10
        toreveMemory2.screenCountSum = toreve.screenCountSum
        
        // /////////////
        // ver3.9.1で追加
        // /////////////
        toreveMemory2.gameNumberStart = toreve.gameNumberStart
        toreveMemory2.gameNumberCurrent = toreve.gameNumberCurrent
        toreveMemory2.gameNumberPlay = toreve.gameNumberPlay
        toreveMemory2.bellCount = toreve.bellCount
        toreveMemory2.atRiseCountManji = toreve.atRiseCountManji
        toreveMemory2.atRiseCountManjiRise = toreve.atRiseCountManjiRise
        toreveMemory2.atRiseCountChance = toreve.atRiseCountChance
        toreveMemory2.atRiseCountChanceRise = toreve.atRiseCountChanceRise
        toreveMemory2.atRiseCountKyoCherry = toreve.atRiseCountKyoCherry
        toreveMemory2.atRiseCountKyoCherryRise = toreve.atRiseCountKyoCherryRise
        toreveMemory2.endingCountBlue = toreve.endingCountBlue
        toreveMemory2.endingCountYellow = toreve.endingCountYellow
        toreveMemory2.endingCountGreen = toreve.endingCountGreen
        toreveMemory2.endingCountRed = toreve.endingCountRed
        toreveMemory2.endingCountRainbow = toreve.endingCountRainbow
        toreveMemory2.endingCountSum = toreve.endingCountSum
    }
    func saveMemory3() {
        toreveMemory3.cycleArrayData = toreve.cycleArrayData
        toreveMemory3.ptArrayData = toreve.ptArrayData
        toreveMemory3.triggerArrayData = toreve.triggerArrayData
        toreveMemory3.resultArrayData = toreve.resultArrayData
        toreveMemory3.normalGame = toreve.normalGame
        toreveMemory3.czCountMidNight = toreve.czCountMidNight
        toreveMemory3.czCountKisaki = toreve.czCountKisaki
        toreveMemory3.czCountSum = toreve.czCountSum
        toreveMemory3.tomanRushCount = toreve.tomanRushCount
        toreveMemory3.tomanChallengeCount = toreve.tomanChallengeCount
        toreveMemory3.firstHitCount = toreve.firstHitCount
        toreveMemory3.screenCount1 = toreve.screenCount1
        toreveMemory3.screenCount2 = toreve.screenCount2
        toreveMemory3.screenCount3 = toreve.screenCount3
        toreveMemory3.screenCount4 = toreve.screenCount4
        toreveMemory3.screenCount5 = toreve.screenCount5
        toreveMemory3.screenCount6 = toreve.screenCount6
        toreveMemory3.screenCount7 = toreve.screenCount7
        toreveMemory3.screenCount8 = toreve.screenCount8
        toreveMemory3.screenCount9 = toreve.screenCount9
        toreveMemory3.screenCount10 = toreve.screenCount10
        toreveMemory3.screenCountSum = toreve.screenCountSum
        
        // /////////////
        // ver3.9.1で追加
        // /////////////
        toreveMemory3.gameNumberStart = toreve.gameNumberStart
        toreveMemory3.gameNumberCurrent = toreve.gameNumberCurrent
        toreveMemory3.gameNumberPlay = toreve.gameNumberPlay
        toreveMemory3.bellCount = toreve.bellCount
        toreveMemory3.atRiseCountManji = toreve.atRiseCountManji
        toreveMemory3.atRiseCountManjiRise = toreve.atRiseCountManjiRise
        toreveMemory3.atRiseCountChance = toreve.atRiseCountChance
        toreveMemory3.atRiseCountChanceRise = toreve.atRiseCountChanceRise
        toreveMemory3.atRiseCountKyoCherry = toreve.atRiseCountKyoCherry
        toreveMemory3.atRiseCountKyoCherryRise = toreve.atRiseCountKyoCherryRise
        toreveMemory3.endingCountBlue = toreve.endingCountBlue
        toreveMemory3.endingCountYellow = toreve.endingCountYellow
        toreveMemory3.endingCountGreen = toreve.endingCountGreen
        toreveMemory3.endingCountRed = toreve.endingCountRed
        toreveMemory3.endingCountRainbow = toreve.endingCountRainbow
        toreveMemory3.endingCountSum = toreve.endingCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct toreveSubViewLoadMemory: View {
    @ObservedObject var toreve: Toreve
    @ObservedObject var toreveMemory1: ToreveMemory1
    @ObservedObject var toreveMemory2: ToreveMemory2
    @ObservedObject var toreveMemory3: ToreveMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: toreve.machineName,
            selectedMemory: $toreve.selectedMemory,
            memoMemory1: toreveMemory1.memo,
            dateDoubleMemory1: toreveMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: toreveMemory2.memo,
            dateDoubleMemory2: toreveMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: toreveMemory3.memo,
            dateDoubleMemory3: toreveMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        let array = decodeIntArray(from: toreveMemory1.cycleArrayData)
        let array2 = decodeIntArray(from: toreveMemory1.ptArrayData)
        let array3 = decodeStringArray(from: toreveMemory1.triggerArrayData)
        let array4 = decodeStringArray(from: toreveMemory1.resultArrayData)
        saveArray(array, forKey: toreve.cycleArrayKey)
//        toreve.cycleArrayData = toreveMemory1.cycleArrayData
        saveArray(array2, forKey: toreve.ptArrayKey)
//        toreve.ptArrayData = toreveMemory1.ptArrayData
        saveArray(array3, forKey: toreve.triggerArrayKey)
//        toreve.triggerArrayData = toreveMemory1.triggerArrayData
        saveArray(array4, forKey: toreve.resultArrayKey)
//        toreve.resultArrayData = toreveMemory1.resultArrayData
        toreve.normalGame = toreveMemory1.normalGame
        toreve.czCountMidNight = toreveMemory1.czCountMidNight
        toreve.czCountKisaki = toreveMemory1.czCountKisaki
        toreve.czCountSum = toreveMemory1.czCountSum
        toreve.tomanRushCount = toreveMemory1.tomanRushCount
        toreve.tomanChallengeCount = toreveMemory1.tomanChallengeCount
        toreve.firstHitCount = toreveMemory1.firstHitCount
        toreve.screenCount1 = toreveMemory1.screenCount1
        toreve.screenCount2 = toreveMemory1.screenCount2
        toreve.screenCount3 = toreveMemory1.screenCount3
        toreve.screenCount4 = toreveMemory1.screenCount4
        toreve.screenCount5 = toreveMemory1.screenCount5
        toreve.screenCount6 = toreveMemory1.screenCount6
        toreve.screenCount7 = toreveMemory1.screenCount7
        toreve.screenCount8 = toreveMemory1.screenCount8
        toreve.screenCount9 = toreveMemory1.screenCount9
        toreve.screenCount10 = toreveMemory1.screenCount10
        toreve.screenCountSum = toreveMemory1.screenCountSum
        
        // /////////////
        // ver3.9.1で追加
        // /////////////
        toreve.gameNumberStart = toreveMemory1.gameNumberStart
        toreve.gameNumberCurrent = toreveMemory1.gameNumberCurrent
        toreve.gameNumberPlay = toreveMemory1.gameNumberPlay
        toreve.bellCount = toreveMemory1.bellCount
        toreve.atRiseCountManji = toreveMemory1.atRiseCountManji
        toreve.atRiseCountManjiRise = toreveMemory1.atRiseCountManjiRise
        toreve.atRiseCountChance = toreveMemory1.atRiseCountChance
        toreve.atRiseCountChanceRise = toreveMemory1.atRiseCountChanceRise
        toreve.atRiseCountKyoCherry = toreveMemory1.atRiseCountKyoCherry
        toreve.atRiseCountKyoCherryRise = toreveMemory1.atRiseCountKyoCherryRise
        toreve.endingCountBlue = toreveMemory1.endingCountBlue
        toreve.endingCountYellow = toreveMemory1.endingCountYellow
        toreve.endingCountGreen = toreveMemory1.endingCountGreen
        toreve.endingCountRed = toreveMemory1.endingCountRed
        toreve.endingCountRainbow = toreveMemory1.endingCountRainbow
        toreve.endingCountSum = toreveMemory1.endingCountSum
    }
    func loadMemory2() {
        let array = decodeIntArray(from: toreveMemory2.cycleArrayData)
        let array2 = decodeIntArray(from: toreveMemory2.ptArrayData)
        let array3 = decodeStringArray(from: toreveMemory2.triggerArrayData)
        let array4 = decodeStringArray(from: toreveMemory2.resultArrayData)
        saveArray(array, forKey: toreve.cycleArrayKey)
//        toreve.cycleArrayData = toreveMemory1.cycleArrayData
        saveArray(array2, forKey: toreve.ptArrayKey)
//        toreve.ptArrayData = toreveMemory1.ptArrayData
        saveArray(array3, forKey: toreve.triggerArrayKey)
//        toreve.triggerArrayData = toreveMemory1.triggerArrayData
        saveArray(array4, forKey: toreve.resultArrayKey)
//        toreve.resultArrayData = toreveMemory1.resultArrayData
        toreve.normalGame = toreveMemory2.normalGame
        toreve.czCountMidNight = toreveMemory2.czCountMidNight
        toreve.czCountKisaki = toreveMemory2.czCountKisaki
        toreve.czCountSum = toreveMemory2.czCountSum
        toreve.tomanRushCount = toreveMemory2.tomanRushCount
        toreve.tomanChallengeCount = toreveMemory2.tomanChallengeCount
        toreve.firstHitCount = toreveMemory2.firstHitCount
        toreve.screenCount1 = toreveMemory2.screenCount1
        toreve.screenCount2 = toreveMemory2.screenCount2
        toreve.screenCount3 = toreveMemory2.screenCount3
        toreve.screenCount4 = toreveMemory2.screenCount4
        toreve.screenCount5 = toreveMemory2.screenCount5
        toreve.screenCount6 = toreveMemory2.screenCount6
        toreve.screenCount7 = toreveMemory2.screenCount7
        toreve.screenCount8 = toreveMemory2.screenCount8
        toreve.screenCount9 = toreveMemory2.screenCount9
        toreve.screenCount10 = toreveMemory2.screenCount10
        toreve.screenCountSum = toreveMemory2.screenCountSum
        
        // /////////////
        // ver3.9.1で追加
        // /////////////
        toreve.gameNumberStart = toreveMemory2.gameNumberStart
        toreve.gameNumberCurrent = toreveMemory2.gameNumberCurrent
        toreve.gameNumberPlay = toreveMemory2.gameNumberPlay
        toreve.bellCount = toreveMemory2.bellCount
        toreve.atRiseCountManji = toreveMemory2.atRiseCountManji
        toreve.atRiseCountManjiRise = toreveMemory2.atRiseCountManjiRise
        toreve.atRiseCountChance = toreveMemory2.atRiseCountChance
        toreve.atRiseCountChanceRise = toreveMemory2.atRiseCountChanceRise
        toreve.atRiseCountKyoCherry = toreveMemory2.atRiseCountKyoCherry
        toreve.atRiseCountKyoCherryRise = toreveMemory2.atRiseCountKyoCherryRise
        toreve.endingCountBlue = toreveMemory2.endingCountBlue
        toreve.endingCountYellow = toreveMemory2.endingCountYellow
        toreve.endingCountGreen = toreveMemory2.endingCountGreen
        toreve.endingCountRed = toreveMemory2.endingCountRed
        toreve.endingCountRainbow = toreveMemory2.endingCountRainbow
        toreve.endingCountSum = toreveMemory2.endingCountSum
    }
    func loadMemory3() {
        let array = decodeIntArray(from: toreveMemory3.cycleArrayData)
        let array2 = decodeIntArray(from: toreveMemory3.ptArrayData)
        let array3 = decodeStringArray(from: toreveMemory3.triggerArrayData)
        let array4 = decodeStringArray(from: toreveMemory3.resultArrayData)
        saveArray(array, forKey: toreve.cycleArrayKey)
//        toreve.cycleArrayData = toreveMemory1.cycleArrayData
        saveArray(array2, forKey: toreve.ptArrayKey)
//        toreve.ptArrayData = toreveMemory1.ptArrayData
        saveArray(array3, forKey: toreve.triggerArrayKey)
//        toreve.triggerArrayData = toreveMemory1.triggerArrayData
        saveArray(array4, forKey: toreve.resultArrayKey)
//        toreve.resultArrayData = toreveMemory1.resultArrayData
        toreve.normalGame = toreveMemory3.normalGame
        toreve.czCountMidNight = toreveMemory3.czCountMidNight
        toreve.czCountKisaki = toreveMemory3.czCountKisaki
        toreve.czCountSum = toreveMemory3.czCountSum
        toreve.tomanRushCount = toreveMemory3.tomanRushCount
        toreve.tomanChallengeCount = toreveMemory3.tomanChallengeCount
        toreve.firstHitCount = toreveMemory3.firstHitCount
        toreve.screenCount1 = toreveMemory3.screenCount1
        toreve.screenCount2 = toreveMemory3.screenCount2
        toreve.screenCount3 = toreveMemory3.screenCount3
        toreve.screenCount4 = toreveMemory3.screenCount4
        toreve.screenCount5 = toreveMemory3.screenCount5
        toreve.screenCount6 = toreveMemory3.screenCount6
        toreve.screenCount7 = toreveMemory3.screenCount7
        toreve.screenCount8 = toreveMemory3.screenCount8
        toreve.screenCount9 = toreveMemory3.screenCount9
        toreve.screenCount10 = toreveMemory3.screenCount10
        toreve.screenCountSum = toreveMemory3.screenCountSum
        
        // /////////////
        // ver3.9.1で追加
        // /////////////
        toreve.gameNumberStart = toreveMemory3.gameNumberStart
        toreve.gameNumberCurrent = toreveMemory3.gameNumberCurrent
        toreve.gameNumberPlay = toreveMemory3.gameNumberPlay
        toreve.bellCount = toreveMemory3.bellCount
        toreve.atRiseCountManji = toreveMemory3.atRiseCountManji
        toreve.atRiseCountManjiRise = toreveMemory3.atRiseCountManjiRise
        toreve.atRiseCountChance = toreveMemory3.atRiseCountChance
        toreve.atRiseCountChanceRise = toreveMemory3.atRiseCountChanceRise
        toreve.atRiseCountKyoCherry = toreveMemory3.atRiseCountKyoCherry
        toreve.atRiseCountKyoCherryRise = toreveMemory3.atRiseCountKyoCherryRise
        toreve.endingCountBlue = toreveMemory3.endingCountBlue
        toreve.endingCountYellow = toreveMemory3.endingCountYellow
        toreve.endingCountGreen = toreveMemory3.endingCountGreen
        toreve.endingCountRed = toreveMemory3.endingCountRed
        toreve.endingCountRainbow = toreveMemory3.endingCountRainbow
        toreve.endingCountSum = toreveMemory3.endingCountSum
    }
}

#Preview {
    toreveViewTop(
//        ver390: Ver390(),
        ver391: Ver391(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
