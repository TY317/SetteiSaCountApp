//
//  ragnadorViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ragnadorViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var ragnador = Ragnador()
    @State var isShowAlert: Bool = false
    @StateObject var ragnadorMemory1 = RagnadorMemory1()
    @StateObject var ragnadorMemory2 = RagnadorMemory2()
    @StateObject var ragnadorMemory3 = RagnadorMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ユニメモの利用を前提としています\n遊技前にユニメモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: ragnador.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: ragnadorViewNormal(
                        ragnador: ragnador,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.ragnadorMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: ragnadorViewFirstHit(
                        ragnador: ragnador,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.ragnadorMenuFirstHitBadge,
                        )
                    }

                    // CZ,AT終了時のボイス
                    NavigationLink(destination: ragnadorViewEndVoice(
                        ragnador: ragnador,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "message.fill",
                            textBody: "CZ,AT終了時のボイス",
                            badgeStatus: common.ragnadorMenuEndVoiceBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: ragnadorViewEnding(
                        ragnador: ragnador,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.ragnadorMenuEndingBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewUniversalPlate()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ユニバプレート"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: ragnador.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: ragnadorView95Ci(
                    ragnador: ragnador,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: ragnadorViewBayes(
                    ragnador: ragnador,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.ragnadorMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5079")

                // コピーライト
                unitSectionCopyright {
                    Text("©Grams. All rights Reserved.")
                    Text("©UNIVERSAL ENTERTAINMENT")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5079")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ragnador.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(ragnadorSubViewLoadMemory(
                    ragnador: ragnador,
                    ragnadorMemory1: ragnadorMemory1,
                    ragnadorMemory2: ragnadorMemory2,
                    ragnadorMemory3: ragnadorMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(ragnadorSubViewSaveMemory(
                    ragnador: ragnador,
                    ragnadorMemory1: ragnadorMemory1,
                    ragnadorMemory2: ragnadorMemory2,
                    ragnadorMemory3: ragnadorMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: ragnador.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct ragnadorSubViewSaveMemory: View {
    @ObservedObject var ragnador: Ragnador
    @ObservedObject var ragnadorMemory1: RagnadorMemory1
    @ObservedObject var ragnadorMemory2: RagnadorMemory2
    @ObservedObject var ragnadorMemory3: RagnadorMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: ragnador.machineName,
            selectedMemory: $ragnador.selectedMemory,
            memoMemory1: $ragnadorMemory1.memo,
            dateDoubleMemory1: $ragnadorMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $ragnadorMemory2.memo,
            dateDoubleMemory2: $ragnadorMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $ragnadorMemory3.memo,
            dateDoubleMemory3: $ragnadorMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        ragnadorMemory1.weakCherryCount = ragnador.weakCherryCount
        ragnadorMemory1.weakCherryUpCountHigh = ragnador.weakCherryUpCountHigh
        ragnadorMemory1.weakCherryUpCountSuperHigh = ragnador.weakCherryUpCountSuperHigh
        ragnadorMemory1.rareCountNormalSuika = ragnador.rareCountNormalSuika
        ragnadorMemory1.rareAtCountNormalSuika = ragnador.rareAtCountNormalSuika
        ragnadorMemory1.rareCountNormalChance = ragnador.rareCountNormalChance
        ragnadorMemory1.rareCzCountNormalChance = ragnador.rareCzCountNormalChance
        ragnadorMemory1.rareAtCountNormalChance = ragnador.rareAtCountNormalChance
        ragnadorMemory1.rareCountNormalKyo = ragnador.rareCountNormalKyo
        ragnadorMemory1.rareCzCountNormalKyo = ragnador.rareCzCountNormalKyo
        ragnadorMemory1.rareAtCountNormalKyo = ragnador.rareAtCountNormalKyo
        ragnadorMemory1.rareCountNormalGoku = ragnador.rareCountNormalGoku
        ragnadorMemory1.rareAtCountNormalGoku = ragnador.rareAtCountNormalGoku
        ragnadorMemory1.rareCountHighSuika = ragnador.rareCountHighSuika
        ragnadorMemory1.rareAtCountHighSuika = ragnador.rareAtCountHighSuika
        ragnadorMemory1.rareCountHighChance = ragnador.rareCountHighChance
        ragnadorMemory1.rareCzCountHighChance = ragnador.rareCzCountHighChance
        ragnadorMemory1.rareAtCountHighChance = ragnador.rareAtCountHighChance
        ragnadorMemory1.rareCountHighKyo = ragnador.rareCountHighKyo
        ragnadorMemory1.rareCzCountHighKyo = ragnador.rareCzCountHighKyo
        ragnadorMemory1.rareAtCountHighKyo = ragnador.rareAtCountHighKyo
        ragnadorMemory1.enemyIncludeFirstInterval = ragnador.enemyIncludeFirstInterval
        ragnadorMemory1.gameArrayData = ragnador.gameArrayData
        ragnadorMemory1.entryKindArrayData = ragnador.entryKindArrayData
        ragnadorMemory1.enemyArrayData = ragnador.enemyArrayData
        ragnadorMemory1.resultArrayData = ragnador.resultArrayData
        ragnadorMemory1.playGameSum = ragnador.playGameSum
        ragnadorMemory1.firstHitCountCz = ragnador.firstHitCountCz
        ragnadorMemory1.firstHitCountAt = ragnador.firstHitCountAt
        ragnadorMemory1.firstHitInputMode = ragnador.firstHitInputMode
        ragnadorMemory1.manualNormalGame = ragnador.manualNormalGame
        ragnadorMemory1.manualFirstHitCountCz = ragnador.manualFirstHitCountCz
        ragnadorMemory1.manualFirstHitCountAt = ragnador.manualFirstHitCountAt
        ragnadorMemory1.voiceCount1 = ragnador.voiceCount1
        ragnadorMemory1.voiceCount2 = ragnador.voiceCount2
        ragnadorMemory1.voiceCount3 = ragnador.voiceCount3
        ragnadorMemory1.voiceCount4 = ragnador.voiceCount4
        ragnadorMemory1.voiceCount5 = ragnador.voiceCount5
        ragnadorMemory1.voiceCount6 = ragnador.voiceCount6
        ragnadorMemory1.voiceCount7 = ragnador.voiceCount7
        ragnadorMemory1.voiceCount8 = ragnador.voiceCount8
        ragnadorMemory1.voiceCountSum = ragnador.voiceCountSum
        ragnadorMemory1.endVoiceCount1 = ragnador.endVoiceCount1
        ragnadorMemory1.endVoiceCount2 = ragnador.endVoiceCount2
        ragnadorMemory1.endVoiceCount3 = ragnador.endVoiceCount3
        ragnadorMemory1.endVoiceCountSum = ragnador.endVoiceCountSum
    }
    func saveMemory2() {
        ragnadorMemory2.weakCherryCount = ragnador.weakCherryCount
        ragnadorMemory2.weakCherryUpCountHigh = ragnador.weakCherryUpCountHigh
        ragnadorMemory2.weakCherryUpCountSuperHigh = ragnador.weakCherryUpCountSuperHigh
        ragnadorMemory2.rareCountNormalSuika = ragnador.rareCountNormalSuika
        ragnadorMemory2.rareAtCountNormalSuika = ragnador.rareAtCountNormalSuika
        ragnadorMemory2.rareCountNormalChance = ragnador.rareCountNormalChance
        ragnadorMemory2.rareCzCountNormalChance = ragnador.rareCzCountNormalChance
        ragnadorMemory2.rareAtCountNormalChance = ragnador.rareAtCountNormalChance
        ragnadorMemory2.rareCountNormalKyo = ragnador.rareCountNormalKyo
        ragnadorMemory2.rareCzCountNormalKyo = ragnador.rareCzCountNormalKyo
        ragnadorMemory2.rareAtCountNormalKyo = ragnador.rareAtCountNormalKyo
        ragnadorMemory2.rareCountNormalGoku = ragnador.rareCountNormalGoku
        ragnadorMemory2.rareAtCountNormalGoku = ragnador.rareAtCountNormalGoku
        ragnadorMemory2.rareCountHighSuika = ragnador.rareCountHighSuika
        ragnadorMemory2.rareAtCountHighSuika = ragnador.rareAtCountHighSuika
        ragnadorMemory2.rareCountHighChance = ragnador.rareCountHighChance
        ragnadorMemory2.rareCzCountHighChance = ragnador.rareCzCountHighChance
        ragnadorMemory2.rareAtCountHighChance = ragnador.rareAtCountHighChance
        ragnadorMemory2.rareCountHighKyo = ragnador.rareCountHighKyo
        ragnadorMemory2.rareCzCountHighKyo = ragnador.rareCzCountHighKyo
        ragnadorMemory2.rareAtCountHighKyo = ragnador.rareAtCountHighKyo
        ragnadorMemory2.enemyIncludeFirstInterval = ragnador.enemyIncludeFirstInterval
        ragnadorMemory2.gameArrayData = ragnador.gameArrayData
        ragnadorMemory2.entryKindArrayData = ragnador.entryKindArrayData
        ragnadorMemory2.enemyArrayData = ragnador.enemyArrayData
        ragnadorMemory2.resultArrayData = ragnador.resultArrayData
        ragnadorMemory2.playGameSum = ragnador.playGameSum
        ragnadorMemory2.firstHitCountCz = ragnador.firstHitCountCz
        ragnadorMemory2.firstHitCountAt = ragnador.firstHitCountAt
        ragnadorMemory2.firstHitInputMode = ragnador.firstHitInputMode
        ragnadorMemory2.manualNormalGame = ragnador.manualNormalGame
        ragnadorMemory2.manualFirstHitCountCz = ragnador.manualFirstHitCountCz
        ragnadorMemory2.manualFirstHitCountAt = ragnador.manualFirstHitCountAt
        ragnadorMemory2.voiceCount1 = ragnador.voiceCount1
        ragnadorMemory2.voiceCount2 = ragnador.voiceCount2
        ragnadorMemory2.voiceCount3 = ragnador.voiceCount3
        ragnadorMemory2.voiceCount4 = ragnador.voiceCount4
        ragnadorMemory2.voiceCount5 = ragnador.voiceCount5
        ragnadorMemory2.voiceCount6 = ragnador.voiceCount6
        ragnadorMemory2.voiceCount7 = ragnador.voiceCount7
        ragnadorMemory2.voiceCount8 = ragnador.voiceCount8
        ragnadorMemory2.voiceCountSum = ragnador.voiceCountSum
        ragnadorMemory2.endVoiceCount1 = ragnador.endVoiceCount1
        ragnadorMemory2.endVoiceCount2 = ragnador.endVoiceCount2
        ragnadorMemory2.endVoiceCount3 = ragnador.endVoiceCount3
        ragnadorMemory2.endVoiceCountSum = ragnador.endVoiceCountSum
    }
    func saveMemory3() {
        ragnadorMemory3.weakCherryCount = ragnador.weakCherryCount
        ragnadorMemory3.weakCherryUpCountHigh = ragnador.weakCherryUpCountHigh
        ragnadorMemory3.weakCherryUpCountSuperHigh = ragnador.weakCherryUpCountSuperHigh
        ragnadorMemory3.rareCountNormalSuika = ragnador.rareCountNormalSuika
        ragnadorMemory3.rareAtCountNormalSuika = ragnador.rareAtCountNormalSuika
        ragnadorMemory3.rareCountNormalChance = ragnador.rareCountNormalChance
        ragnadorMemory3.rareCzCountNormalChance = ragnador.rareCzCountNormalChance
        ragnadorMemory3.rareAtCountNormalChance = ragnador.rareAtCountNormalChance
        ragnadorMemory3.rareCountNormalKyo = ragnador.rareCountNormalKyo
        ragnadorMemory3.rareCzCountNormalKyo = ragnador.rareCzCountNormalKyo
        ragnadorMemory3.rareAtCountNormalKyo = ragnador.rareAtCountNormalKyo
        ragnadorMemory3.rareCountNormalGoku = ragnador.rareCountNormalGoku
        ragnadorMemory3.rareAtCountNormalGoku = ragnador.rareAtCountNormalGoku
        ragnadorMemory3.rareCountHighSuika = ragnador.rareCountHighSuika
        ragnadorMemory3.rareAtCountHighSuika = ragnador.rareAtCountHighSuika
        ragnadorMemory3.rareCountHighChance = ragnador.rareCountHighChance
        ragnadorMemory3.rareCzCountHighChance = ragnador.rareCzCountHighChance
        ragnadorMemory3.rareAtCountHighChance = ragnador.rareAtCountHighChance
        ragnadorMemory3.rareCountHighKyo = ragnador.rareCountHighKyo
        ragnadorMemory3.rareCzCountHighKyo = ragnador.rareCzCountHighKyo
        ragnadorMemory3.rareAtCountHighKyo = ragnador.rareAtCountHighKyo
        ragnadorMemory3.enemyIncludeFirstInterval = ragnador.enemyIncludeFirstInterval
        ragnadorMemory3.gameArrayData = ragnador.gameArrayData
        ragnadorMemory3.entryKindArrayData = ragnador.entryKindArrayData
        ragnadorMemory3.enemyArrayData = ragnador.enemyArrayData
        ragnadorMemory3.resultArrayData = ragnador.resultArrayData
        ragnadorMemory3.playGameSum = ragnador.playGameSum
        ragnadorMemory3.firstHitCountCz = ragnador.firstHitCountCz
        ragnadorMemory3.firstHitCountAt = ragnador.firstHitCountAt
        ragnadorMemory3.firstHitInputMode = ragnador.firstHitInputMode
        ragnadorMemory3.manualNormalGame = ragnador.manualNormalGame
        ragnadorMemory3.manualFirstHitCountCz = ragnador.manualFirstHitCountCz
        ragnadorMemory3.manualFirstHitCountAt = ragnador.manualFirstHitCountAt
        ragnadorMemory3.voiceCount1 = ragnador.voiceCount1
        ragnadorMemory3.voiceCount2 = ragnador.voiceCount2
        ragnadorMemory3.voiceCount3 = ragnador.voiceCount3
        ragnadorMemory3.voiceCount4 = ragnador.voiceCount4
        ragnadorMemory3.voiceCount5 = ragnador.voiceCount5
        ragnadorMemory3.voiceCount6 = ragnador.voiceCount6
        ragnadorMemory3.voiceCount7 = ragnador.voiceCount7
        ragnadorMemory3.voiceCount8 = ragnador.voiceCount8
        ragnadorMemory3.voiceCountSum = ragnador.voiceCountSum
        ragnadorMemory3.endVoiceCount1 = ragnador.endVoiceCount1
        ragnadorMemory3.endVoiceCount2 = ragnador.endVoiceCount2
        ragnadorMemory3.endVoiceCount3 = ragnador.endVoiceCount3
        ragnadorMemory3.endVoiceCountSum = ragnador.endVoiceCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct ragnadorSubViewLoadMemory: View {
    @ObservedObject var ragnador: Ragnador
    @ObservedObject var ragnadorMemory1: RagnadorMemory1
    @ObservedObject var ragnadorMemory2: RagnadorMemory2
    @ObservedObject var ragnadorMemory3: RagnadorMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: ragnador.machineName,
            selectedMemory: $ragnador.selectedMemory,
            memoMemory1: ragnadorMemory1.memo,
            dateDoubleMemory1: ragnadorMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: ragnadorMemory2.memo,
            dateDoubleMemory2: ragnadorMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: ragnadorMemory3.memo,
            dateDoubleMemory3: ragnadorMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        ragnador.weakCherryCount = ragnadorMemory1.weakCherryCount
        ragnador.weakCherryUpCountHigh = ragnadorMemory1.weakCherryUpCountHigh
        ragnador.weakCherryUpCountSuperHigh = ragnadorMemory1.weakCherryUpCountSuperHigh
        ragnador.rareCountNormalSuika = ragnadorMemory1.rareCountNormalSuika
        ragnador.rareAtCountNormalSuika = ragnadorMemory1.rareAtCountNormalSuika
        ragnador.rareCountNormalChance = ragnadorMemory1.rareCountNormalChance
        ragnador.rareCzCountNormalChance = ragnadorMemory1.rareCzCountNormalChance
        ragnador.rareAtCountNormalChance = ragnadorMemory1.rareAtCountNormalChance
        ragnador.rareCountNormalKyo = ragnadorMemory1.rareCountNormalKyo
        ragnador.rareCzCountNormalKyo = ragnadorMemory1.rareCzCountNormalKyo
        ragnador.rareAtCountNormalKyo = ragnadorMemory1.rareAtCountNormalKyo
        ragnador.rareCountNormalGoku = ragnadorMemory1.rareCountNormalGoku
        ragnador.rareAtCountNormalGoku = ragnadorMemory1.rareAtCountNormalGoku
        ragnador.rareCountHighSuika = ragnadorMemory1.rareCountHighSuika
        ragnador.rareAtCountHighSuika = ragnadorMemory1.rareAtCountHighSuika
        ragnador.rareCountHighChance = ragnadorMemory1.rareCountHighChance
        ragnador.rareCzCountHighChance = ragnadorMemory1.rareCzCountHighChance
        ragnador.rareAtCountHighChance = ragnadorMemory1.rareAtCountHighChance
        ragnador.rareCountHighKyo = ragnadorMemory1.rareCountHighKyo
        ragnador.rareCzCountHighKyo = ragnadorMemory1.rareCzCountHighKyo
        ragnador.rareAtCountHighKyo = ragnadorMemory1.rareAtCountHighKyo
        ragnador.enemyIncludeFirstInterval = ragnadorMemory1.enemyIncludeFirstInterval
        let gameArrayDecoded = decodeIntArray(from: ragnadorMemory1.gameArrayData)
        saveArray(gameArrayDecoded, forKey: ragnador.gameArrayKey)
        let entryKindArrayDecoded = decodeStringArray(from: ragnadorMemory1.entryKindArrayData)
        saveArray(entryKindArrayDecoded, forKey: ragnador.entryKindArrayKey)
        let enemyArrayDecoded = decodeStringArray(from: ragnadorMemory1.enemyArrayData)
        saveArray(enemyArrayDecoded, forKey: ragnador.enemyArrayKey)
        let resultArrayDecoded = decodeStringArray(from: ragnadorMemory1.resultArrayData)
        saveArray(resultArrayDecoded, forKey: ragnador.resultArrayKey)
        ragnador.playGameSum = ragnadorMemory1.playGameSum
        ragnador.firstHitCountCz = ragnadorMemory1.firstHitCountCz
        ragnador.firstHitCountAt = ragnadorMemory1.firstHitCountAt
        ragnador.firstHitInputMode = ragnadorMemory1.firstHitInputMode
        ragnador.manualNormalGame = ragnadorMemory1.manualNormalGame
        ragnador.manualFirstHitCountCz = ragnadorMemory1.manualFirstHitCountCz
        ragnador.manualFirstHitCountAt = ragnadorMemory1.manualFirstHitCountAt
        ragnador.voiceCount1 = ragnadorMemory1.voiceCount1
        ragnador.voiceCount2 = ragnadorMemory1.voiceCount2
        ragnador.voiceCount3 = ragnadorMemory1.voiceCount3
        ragnador.voiceCount4 = ragnadorMemory1.voiceCount4
        ragnador.voiceCount5 = ragnadorMemory1.voiceCount5
        ragnador.voiceCount6 = ragnadorMemory1.voiceCount6
        ragnador.voiceCount7 = ragnadorMemory1.voiceCount7
        ragnador.voiceCount8 = ragnadorMemory1.voiceCount8
        ragnador.voiceCountSum = ragnadorMemory1.voiceCountSum
        ragnador.endVoiceCount1 = ragnadorMemory1.endVoiceCount1
        ragnador.endVoiceCount2 = ragnadorMemory1.endVoiceCount2
        ragnador.endVoiceCount3 = ragnadorMemory1.endVoiceCount3
        ragnador.endVoiceCountSum = ragnadorMemory1.endVoiceCountSum
    }
    func loadMemory2() {
        ragnador.weakCherryCount = ragnadorMemory2.weakCherryCount
        ragnador.weakCherryUpCountHigh = ragnadorMemory2.weakCherryUpCountHigh
        ragnador.weakCherryUpCountSuperHigh = ragnadorMemory2.weakCherryUpCountSuperHigh
        ragnador.rareCountNormalSuika = ragnadorMemory2.rareCountNormalSuika
        ragnador.rareAtCountNormalSuika = ragnadorMemory2.rareAtCountNormalSuika
        ragnador.rareCountNormalChance = ragnadorMemory2.rareCountNormalChance
        ragnador.rareCzCountNormalChance = ragnadorMemory2.rareCzCountNormalChance
        ragnador.rareAtCountNormalChance = ragnadorMemory2.rareAtCountNormalChance
        ragnador.rareCountNormalKyo = ragnadorMemory2.rareCountNormalKyo
        ragnador.rareCzCountNormalKyo = ragnadorMemory2.rareCzCountNormalKyo
        ragnador.rareAtCountNormalKyo = ragnadorMemory2.rareAtCountNormalKyo
        ragnador.rareCountNormalGoku = ragnadorMemory2.rareCountNormalGoku
        ragnador.rareAtCountNormalGoku = ragnadorMemory2.rareAtCountNormalGoku
        ragnador.rareCountHighSuika = ragnadorMemory2.rareCountHighSuika
        ragnador.rareAtCountHighSuika = ragnadorMemory2.rareAtCountHighSuika
        ragnador.rareCountHighChance = ragnadorMemory2.rareCountHighChance
        ragnador.rareCzCountHighChance = ragnadorMemory2.rareCzCountHighChance
        ragnador.rareAtCountHighChance = ragnadorMemory2.rareAtCountHighChance
        ragnador.rareCountHighKyo = ragnadorMemory2.rareCountHighKyo
        ragnador.rareCzCountHighKyo = ragnadorMemory2.rareCzCountHighKyo
        ragnador.rareAtCountHighKyo = ragnadorMemory2.rareAtCountHighKyo
        ragnador.enemyIncludeFirstInterval = ragnadorMemory2.enemyIncludeFirstInterval
        let gameArrayDecoded = decodeIntArray(from: ragnadorMemory2.gameArrayData)
        saveArray(gameArrayDecoded, forKey: ragnador.gameArrayKey)
        let entryKindArrayDecoded = decodeStringArray(from: ragnadorMemory2.entryKindArrayData)
        saveArray(entryKindArrayDecoded, forKey: ragnador.entryKindArrayKey)
        let enemyArrayDecoded = decodeStringArray(from: ragnadorMemory2.enemyArrayData)
        saveArray(enemyArrayDecoded, forKey: ragnador.enemyArrayKey)
        let resultArrayDecoded = decodeStringArray(from: ragnadorMemory2.resultArrayData)
        saveArray(resultArrayDecoded, forKey: ragnador.resultArrayKey)
        ragnador.playGameSum = ragnadorMemory2.playGameSum
        ragnador.firstHitCountCz = ragnadorMemory2.firstHitCountCz
        ragnador.firstHitCountAt = ragnadorMemory2.firstHitCountAt
        ragnador.firstHitInputMode = ragnadorMemory2.firstHitInputMode
        ragnador.manualNormalGame = ragnadorMemory2.manualNormalGame
        ragnador.manualFirstHitCountCz = ragnadorMemory2.manualFirstHitCountCz
        ragnador.manualFirstHitCountAt = ragnadorMemory2.manualFirstHitCountAt
        ragnador.voiceCount1 = ragnadorMemory2.voiceCount1
        ragnador.voiceCount2 = ragnadorMemory2.voiceCount2
        ragnador.voiceCount3 = ragnadorMemory2.voiceCount3
        ragnador.voiceCount4 = ragnadorMemory2.voiceCount4
        ragnador.voiceCount5 = ragnadorMemory2.voiceCount5
        ragnador.voiceCount6 = ragnadorMemory2.voiceCount6
        ragnador.voiceCount7 = ragnadorMemory2.voiceCount7
        ragnador.voiceCount8 = ragnadorMemory2.voiceCount8
        ragnador.voiceCountSum = ragnadorMemory2.voiceCountSum
        ragnador.endVoiceCount1 = ragnadorMemory2.endVoiceCount1
        ragnador.endVoiceCount2 = ragnadorMemory2.endVoiceCount2
        ragnador.endVoiceCount3 = ragnadorMemory2.endVoiceCount3
        ragnador.endVoiceCountSum = ragnadorMemory2.endVoiceCountSum
    }
    func loadMemory3() {
        ragnador.weakCherryCount = ragnadorMemory3.weakCherryCount
        ragnador.weakCherryUpCountHigh = ragnadorMemory3.weakCherryUpCountHigh
        ragnador.weakCherryUpCountSuperHigh = ragnadorMemory3.weakCherryUpCountSuperHigh
        ragnador.rareCountNormalSuika = ragnadorMemory3.rareCountNormalSuika
        ragnador.rareAtCountNormalSuika = ragnadorMemory3.rareAtCountNormalSuika
        ragnador.rareCountNormalChance = ragnadorMemory3.rareCountNormalChance
        ragnador.rareCzCountNormalChance = ragnadorMemory3.rareCzCountNormalChance
        ragnador.rareAtCountNormalChance = ragnadorMemory3.rareAtCountNormalChance
        ragnador.rareCountNormalKyo = ragnadorMemory3.rareCountNormalKyo
        ragnador.rareCzCountNormalKyo = ragnadorMemory3.rareCzCountNormalKyo
        ragnador.rareAtCountNormalKyo = ragnadorMemory3.rareAtCountNormalKyo
        ragnador.rareCountNormalGoku = ragnadorMemory3.rareCountNormalGoku
        ragnador.rareAtCountNormalGoku = ragnadorMemory3.rareAtCountNormalGoku
        ragnador.rareCountHighSuika = ragnadorMemory3.rareCountHighSuika
        ragnador.rareAtCountHighSuika = ragnadorMemory3.rareAtCountHighSuika
        ragnador.rareCountHighChance = ragnadorMemory3.rareCountHighChance
        ragnador.rareCzCountHighChance = ragnadorMemory3.rareCzCountHighChance
        ragnador.rareAtCountHighChance = ragnadorMemory3.rareAtCountHighChance
        ragnador.rareCountHighKyo = ragnadorMemory3.rareCountHighKyo
        ragnador.rareCzCountHighKyo = ragnadorMemory3.rareCzCountHighKyo
        ragnador.rareAtCountHighKyo = ragnadorMemory3.rareAtCountHighKyo
        ragnador.enemyIncludeFirstInterval = ragnadorMemory3.enemyIncludeFirstInterval
        let gameArrayDecoded = decodeIntArray(from: ragnadorMemory3.gameArrayData)
        saveArray(gameArrayDecoded, forKey: ragnador.gameArrayKey)
        let entryKindArrayDecoded = decodeStringArray(from: ragnadorMemory3.entryKindArrayData)
        saveArray(entryKindArrayDecoded, forKey: ragnador.entryKindArrayKey)
        let enemyArrayDecoded = decodeStringArray(from: ragnadorMemory3.enemyArrayData)
        saveArray(enemyArrayDecoded, forKey: ragnador.enemyArrayKey)
        let resultArrayDecoded = decodeStringArray(from: ragnadorMemory3.resultArrayData)
        saveArray(resultArrayDecoded, forKey: ragnador.resultArrayKey)
        ragnador.playGameSum = ragnadorMemory3.playGameSum
        ragnador.firstHitCountCz = ragnadorMemory3.firstHitCountCz
        ragnador.firstHitCountAt = ragnadorMemory3.firstHitCountAt
        ragnador.firstHitInputMode = ragnadorMemory3.firstHitInputMode
        ragnador.manualNormalGame = ragnadorMemory3.manualNormalGame
        ragnador.manualFirstHitCountCz = ragnadorMemory3.manualFirstHitCountCz
        ragnador.manualFirstHitCountAt = ragnadorMemory3.manualFirstHitCountAt
        ragnador.voiceCount1 = ragnadorMemory3.voiceCount1
        ragnador.voiceCount2 = ragnadorMemory3.voiceCount2
        ragnador.voiceCount3 = ragnadorMemory3.voiceCount3
        ragnador.voiceCount4 = ragnadorMemory3.voiceCount4
        ragnador.voiceCount5 = ragnadorMemory3.voiceCount5
        ragnador.voiceCount6 = ragnadorMemory3.voiceCount6
        ragnador.voiceCount7 = ragnadorMemory3.voiceCount7
        ragnador.voiceCount8 = ragnadorMemory3.voiceCount8
        ragnador.voiceCountSum = ragnadorMemory3.voiceCountSum
        ragnador.endVoiceCount1 = ragnadorMemory3.endVoiceCount1
        ragnador.endVoiceCount2 = ragnadorMemory3.endVoiceCount2
        ragnador.endVoiceCount3 = ragnadorMemory3.endVoiceCount3
        ragnador.endVoiceCountSum = ragnadorMemory3.endVoiceCountSum
    }
}

#Preview {
    ragnadorViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
