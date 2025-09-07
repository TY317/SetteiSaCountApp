//
//  toreveViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/02.
//

import SwiftUI

struct toreveViewTop: View {
    @ObservedObject var ver390: Ver390
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
                        toreve: toreve,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // 周期履歴
                    NavigationLink(destination: toreveViewCycle(
                        toreve: toreve,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "周期履歴",
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
                        toreve: toreve,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "figure.stairs",
                            textBody: "東卍チャンス"
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: toreveViewScreen(
                        toreve: toreve,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面"
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
                    selection: 1
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
        .resetBadgeOnAppear($ver390.toreveMachineIconBadge)
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
    }
}

#Preview {
    toreveViewTop(
        ver390: Ver390(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
