//
//  tokyoGhoulViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/20.
//

import SwiftUI
import FirebaseAnalytics

struct tokyoGhoulViewTop: View {
    @ObservedObject var ver351: Ver351
    @ObservedObject var ver352: Ver352
//    @ObservedObject var tokyoGhoul = TokyoGhoul()
    @StateObject var tokyoGhoul = TokyoGhoul()
    @State var isShowAlert: Bool = false
    @StateObject var tokyoGhoulMemory1 = TokyoGhoulMemory1()
    @StateObject var tokyoGhoulMemory2 = TokyoGhoulMemory2()
    @StateObject var tokyoGhoulMemory3 = TokyoGhoulMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 月山招待状
                    NavigationLink(destination: tokyoGhoulViewTsukiyama(
                        ver352: ver352,
                        tokyoGhoul: tokyoGhoul
                    )) {
                        unitLabelMenu(
                            imageSystemName: "envelope.fill",
                            textBody: "通常時 月山招待状での示唆",
                            badgeStatus: ver352.tokyoGhoulMenuTsukiyamaBadge,
                        )
                    }
                    // CZ,AT 初当り履歴
                    NavigationLink(
                        destination: tokyoGhoulViewHistory(
                            ver351: ver351,
                            tokyoGhoul: tokyoGhoul
                        )) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "CZ,AT 初当り履歴",
                            badgeStatus: ver351.ghoulMenuFirstHitBadge,
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: tokyoGhoulViewScreen(tokyoGhoul: tokyoGhoul)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
                        )
                    }
                    // エンディング
                    NavigationLink(destination: tokyoGhoulViewEnding(tokyoGhoul: tokyoGhoul)) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング"
//                            badgeStatus: ver240.tokyoGhoulMenuEndingBadgeStatus
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "東京喰種")
                }
                // 設定推測グラフ
                NavigationLink(destination: tokyoGhoulView95Ci(tokyoGhoul: tokyoGhoul, selection: 3)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4742")
//                    .popoverTip(tipVer220AddLink())
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver352.tokyoGhoulMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "東京喰種",
                screenClass: screenClass
            )
        }
        // 画面ログイベントの収集
//        .onAppear {
//            // Viewが表示されたタイミングでログを送信します
//            Analytics.logEvent(AnalyticsEventScreenView, parameters: [
//                AnalyticsParameterScreenName: "東京喰種", // この画面の名前を識別できるように設定
//                AnalyticsParameterScreenClass: "tokyoGhoulViewTop" // 通常はViewのクラス名（構造体名）を設定
//                // その他、この画面に関連するパラメータを追加できます
//            ])
//            print("Firebase Analytics: tokyoGhoulViewTop appeared.") // デバッグ用にログ出力
//        }
//        .onAppear {
//            if ver250.ghoulMachineIconBadgeStatus != "none" {
//                ver250.ghoulMachineIconBadgeStatus = "none"
//            }
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(tokyoGhoulSubViewLoadMemory(
                        tokyoGhoul: tokyoGhoul,
                        tokyoGhoulMemory1: tokyoGhoulMemory1,
                        tokyoGhoulMemory2: tokyoGhoulMemory2,
                        tokyoGhoulMemory3: tokyoGhoulMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(tokyoGhoulSubViewSaveMemory(
                        tokyoGhoul: tokyoGhoul,
                        tokyoGhoulMemory1: tokyoGhoulMemory1,
                        tokyoGhoulMemory2: tokyoGhoulMemory2,
                        tokyoGhoulMemory3: tokyoGhoulMemory3
                    )))
                }
//                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: tokyoGhoul.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct tokyoGhoulSubViewSaveMemory: View {
    @ObservedObject var tokyoGhoul: TokyoGhoul
    @ObservedObject var tokyoGhoulMemory1: TokyoGhoulMemory1
    @ObservedObject var tokyoGhoulMemory2: TokyoGhoulMemory2
    @ObservedObject var tokyoGhoulMemory3: TokyoGhoulMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "東京喰種",
            selectedMemory: $tokyoGhoul.selectedMemory,
            memoMemory1: $tokyoGhoulMemory1.memo,
            dateDoubleMemory1: $tokyoGhoulMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $tokyoGhoulMemory2.memo,
            dateDoubleMemory2: $tokyoGhoulMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $tokyoGhoulMemory3.memo,
            dateDoubleMemory3: $tokyoGhoulMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        tokyoGhoulMemory1.tsukiyamaCountGusu = tokyoGhoul.tsukiyamaCountGusu
        tokyoGhoulMemory1.tsukiyamaCountNot1 = tokyoGhoul.tsukiyamaCountNot1
        tokyoGhoulMemory1.tsukiyamaCountNot2 = tokyoGhoul.tsukiyamaCountNot2
        tokyoGhoulMemory1.tsukiyamaCountNot3 = tokyoGhoul.tsukiyamaCountNot3
        tokyoGhoulMemory1.tsukiyamaCountNot4 = tokyoGhoul.tsukiyamaCountNot4
        tokyoGhoulMemory1.tsukiyamaCountOver4 = tokyoGhoul.tsukiyamaCountOver4
        tokyoGhoulMemory1.tsukiyamaCountOver6 = tokyoGhoul.tsukiyamaCountOver6
        tokyoGhoulMemory1.tsukiyamaCountDefault = tokyoGhoul.tsukiyamaCountDefault
        tokyoGhoulMemory1.tsukiyamaCountRemainGame = tokyoGhoul.tsukiyamaCountRemainGame
        tokyoGhoulMemory1.tsukiyamaCountSum = tokyoGhoul.tsukiyamaCountSum
        tokyoGhoulMemory1.inputGame = tokyoGhoul.inputGame
        tokyoGhoulMemory1.gameArrayData = tokyoGhoul.gameArrayData
        tokyoGhoulMemory1.kindArrayData = tokyoGhoul.kindArrayData
        tokyoGhoulMemory1.triggerArrayData = tokyoGhoul.triggerArrayData
        tokyoGhoulMemory1.atHitArrayData = tokyoGhoul.atHitArrayData
        tokyoGhoulMemory1.playGameSum = tokyoGhoul.playGameSum
        tokyoGhoulMemory1.czCountRemini = tokyoGhoul.czCountRemini
        tokyoGhoulMemory1.czCountRise = tokyoGhoul.czCountRise
        tokyoGhoulMemory1.czCountSum = tokyoGhoul.czCountSum
        tokyoGhoulMemory1.atCount = tokyoGhoul.atCount
        tokyoGhoulMemory1.screenCountDefault = tokyoGhoul.screenCountDefault
        tokyoGhoulMemory1.screenCountKisu = tokyoGhoul.screenCountKisu
        tokyoGhoulMemory1.screenCountGusu = tokyoGhoul.screenCountGusu
        tokyoGhoulMemory1.screenCountNot1 = tokyoGhoul.screenCountNot1
        tokyoGhoulMemory1.screenCountHighJaku = tokyoGhoul.screenCountHighJaku
        tokyoGhoulMemory1.screenCountHighKyo = tokyoGhoul.screenCountHighKyo
        tokyoGhoulMemory1.screenCountOver4 = tokyoGhoul.screenCountOver4
        tokyoGhoulMemory1.screenCountOver6 = tokyoGhoul.screenCountOver6
        tokyoGhoulMemory1.screenCountSum = tokyoGhoul.screenCountSum
        tokyoGhoulMemory1.czCountEpisode = tokyoGhoul.czCountEpisode
        tokyoGhoulMemory1.morningModeEnable = tokyoGhoul.morningModeEnable
        tokyoGhoulMemory1.under100CountHit = tokyoGhoul.under100CountHit
        tokyoGhoulMemory1.firstHitCountSum = tokyoGhoul.firstHitCountSum
        tokyoGhoulMemory1.endingCountKisuJaku = tokyoGhoul.endingCountKisuJaku
        tokyoGhoulMemory1.endingCountKisuKyo = tokyoGhoul.endingCountKisuKyo
        tokyoGhoulMemory1.endingCountGusuJaku = tokyoGhoul.endingCountGusuJaku
        tokyoGhoulMemory1.endingCountGusuKyo = tokyoGhoul.endingCountGusuKyo
        tokyoGhoulMemory1.endingCountHighJaku = tokyoGhoul.endingCountHighJaku
        tokyoGhoulMemory1.endingCountHighKyo = tokyoGhoul.endingCountHighKyo
        tokyoGhoulMemory1.endingCountSum = tokyoGhoul.endingCountSum
        // ///////////////////////
        // ver240追加
        // ///////////////////////
        tokyoGhoulMemory1.endingCountExcept1 = tokyoGhoul.endingCountExcept1
        tokyoGhoulMemory1.endingCountExcept2 = tokyoGhoul.endingCountExcept2
        tokyoGhoulMemory1.endingCountExcept3 = tokyoGhoul.endingCountExcept3
        tokyoGhoulMemory1.endingCountExcept4 = tokyoGhoul.endingCountExcept4
        tokyoGhoulMemory1.endingCountOver3 = tokyoGhoul.endingCountOver3
        tokyoGhoulMemory1.endingCountOver4 = tokyoGhoul.endingCountOver4
        tokyoGhoulMemory1.endingCountOver5 = tokyoGhoul.endingCountOver5
        tokyoGhoulMemory1.endingCountOver6 = tokyoGhoul.endingCountOver6
    }
    func saveMemory2() {
        tokyoGhoulMemory2.tsukiyamaCountGusu = tokyoGhoul.tsukiyamaCountGusu
        tokyoGhoulMemory2.tsukiyamaCountNot1 = tokyoGhoul.tsukiyamaCountNot1
        tokyoGhoulMemory2.tsukiyamaCountNot2 = tokyoGhoul.tsukiyamaCountNot2
        tokyoGhoulMemory2.tsukiyamaCountNot3 = tokyoGhoul.tsukiyamaCountNot3
        tokyoGhoulMemory2.tsukiyamaCountNot4 = tokyoGhoul.tsukiyamaCountNot4
        tokyoGhoulMemory2.tsukiyamaCountOver4 = tokyoGhoul.tsukiyamaCountOver4
        tokyoGhoulMemory2.tsukiyamaCountOver6 = tokyoGhoul.tsukiyamaCountOver6
        tokyoGhoulMemory2.tsukiyamaCountDefault = tokyoGhoul.tsukiyamaCountDefault
        tokyoGhoulMemory2.tsukiyamaCountRemainGame = tokyoGhoul.tsukiyamaCountRemainGame
        tokyoGhoulMemory2.tsukiyamaCountSum = tokyoGhoul.tsukiyamaCountSum
        tokyoGhoulMemory2.inputGame = tokyoGhoul.inputGame
        tokyoGhoulMemory2.gameArrayData = tokyoGhoul.gameArrayData
        tokyoGhoulMemory2.kindArrayData = tokyoGhoul.kindArrayData
        tokyoGhoulMemory2.triggerArrayData = tokyoGhoul.triggerArrayData
        tokyoGhoulMemory2.atHitArrayData = tokyoGhoul.atHitArrayData
        tokyoGhoulMemory2.playGameSum = tokyoGhoul.playGameSum
        tokyoGhoulMemory2.czCountRemini = tokyoGhoul.czCountRemini
        tokyoGhoulMemory2.czCountRise = tokyoGhoul.czCountRise
        tokyoGhoulMemory2.czCountSum = tokyoGhoul.czCountSum
        tokyoGhoulMemory2.atCount = tokyoGhoul.atCount
        tokyoGhoulMemory2.screenCountDefault = tokyoGhoul.screenCountDefault
        tokyoGhoulMemory2.screenCountKisu = tokyoGhoul.screenCountKisu
        tokyoGhoulMemory2.screenCountGusu = tokyoGhoul.screenCountGusu
        tokyoGhoulMemory2.screenCountNot1 = tokyoGhoul.screenCountNot1
        tokyoGhoulMemory2.screenCountHighJaku = tokyoGhoul.screenCountHighJaku
        tokyoGhoulMemory2.screenCountHighKyo = tokyoGhoul.screenCountHighKyo
        tokyoGhoulMemory2.screenCountOver4 = tokyoGhoul.screenCountOver4
        tokyoGhoulMemory2.screenCountOver6 = tokyoGhoul.screenCountOver6
        tokyoGhoulMemory2.screenCountSum = tokyoGhoul.screenCountSum
        
        tokyoGhoulMemory2.czCountEpisode = tokyoGhoul.czCountEpisode
        tokyoGhoulMemory2.morningModeEnable = tokyoGhoul.morningModeEnable
        tokyoGhoulMemory2.under100CountHit = tokyoGhoul.under100CountHit
        tokyoGhoulMemory2.firstHitCountSum = tokyoGhoul.firstHitCountSum
        tokyoGhoulMemory2.endingCountKisuJaku = tokyoGhoul.endingCountKisuJaku
        tokyoGhoulMemory2.endingCountKisuKyo = tokyoGhoul.endingCountKisuKyo
        tokyoGhoulMemory2.endingCountGusuJaku = tokyoGhoul.endingCountGusuJaku
        tokyoGhoulMemory2.endingCountGusuKyo = tokyoGhoul.endingCountGusuKyo
        tokyoGhoulMemory2.endingCountHighJaku = tokyoGhoul.endingCountHighJaku
        tokyoGhoulMemory2.endingCountHighKyo = tokyoGhoul.endingCountHighKyo
        tokyoGhoulMemory2.endingCountSum = tokyoGhoul.endingCountSum
        // ///////////////////////
        // ver240追加
        // ///////////////////////
        tokyoGhoulMemory2.endingCountExcept1 = tokyoGhoul.endingCountExcept1
        tokyoGhoulMemory2.endingCountExcept2 = tokyoGhoul.endingCountExcept2
        tokyoGhoulMemory2.endingCountExcept3 = tokyoGhoul.endingCountExcept3
        tokyoGhoulMemory2.endingCountExcept4 = tokyoGhoul.endingCountExcept4
        tokyoGhoulMemory2.endingCountOver3 = tokyoGhoul.endingCountOver3
        tokyoGhoulMemory2.endingCountOver4 = tokyoGhoul.endingCountOver4
        tokyoGhoulMemory2.endingCountOver5 = tokyoGhoul.endingCountOver5
        tokyoGhoulMemory2.endingCountOver6 = tokyoGhoul.endingCountOver6
    }
    func saveMemory3() {
        tokyoGhoulMemory3.tsukiyamaCountGusu = tokyoGhoul.tsukiyamaCountGusu
        tokyoGhoulMemory3.tsukiyamaCountNot1 = tokyoGhoul.tsukiyamaCountNot1
        tokyoGhoulMemory3.tsukiyamaCountNot2 = tokyoGhoul.tsukiyamaCountNot2
        tokyoGhoulMemory3.tsukiyamaCountNot3 = tokyoGhoul.tsukiyamaCountNot3
        tokyoGhoulMemory3.tsukiyamaCountNot4 = tokyoGhoul.tsukiyamaCountNot4
        tokyoGhoulMemory3.tsukiyamaCountOver4 = tokyoGhoul.tsukiyamaCountOver4
        tokyoGhoulMemory3.tsukiyamaCountOver6 = tokyoGhoul.tsukiyamaCountOver6
        tokyoGhoulMemory3.tsukiyamaCountDefault = tokyoGhoul.tsukiyamaCountDefault
        tokyoGhoulMemory3.tsukiyamaCountRemainGame = tokyoGhoul.tsukiyamaCountRemainGame
        tokyoGhoulMemory3.tsukiyamaCountSum = tokyoGhoul.tsukiyamaCountSum
        tokyoGhoulMemory3.inputGame = tokyoGhoul.inputGame
        tokyoGhoulMemory3.gameArrayData = tokyoGhoul.gameArrayData
        tokyoGhoulMemory3.kindArrayData = tokyoGhoul.kindArrayData
        tokyoGhoulMemory3.triggerArrayData = tokyoGhoul.triggerArrayData
        tokyoGhoulMemory3.atHitArrayData = tokyoGhoul.atHitArrayData
        tokyoGhoulMemory3.playGameSum = tokyoGhoul.playGameSum
        tokyoGhoulMemory3.czCountRemini = tokyoGhoul.czCountRemini
        tokyoGhoulMemory3.czCountRise = tokyoGhoul.czCountRise
        tokyoGhoulMemory3.czCountSum = tokyoGhoul.czCountSum
        tokyoGhoulMemory3.atCount = tokyoGhoul.atCount
        tokyoGhoulMemory3.screenCountDefault = tokyoGhoul.screenCountDefault
        tokyoGhoulMemory3.screenCountKisu = tokyoGhoul.screenCountKisu
        tokyoGhoulMemory3.screenCountGusu = tokyoGhoul.screenCountGusu
        tokyoGhoulMemory3.screenCountNot1 = tokyoGhoul.screenCountNot1
        tokyoGhoulMemory3.screenCountHighJaku = tokyoGhoul.screenCountHighJaku
        tokyoGhoulMemory3.screenCountHighKyo = tokyoGhoul.screenCountHighKyo
        tokyoGhoulMemory3.screenCountOver4 = tokyoGhoul.screenCountOver4
        tokyoGhoulMemory3.screenCountOver6 = tokyoGhoul.screenCountOver6
        tokyoGhoulMemory3.screenCountSum = tokyoGhoul.screenCountSum
        
        tokyoGhoulMemory3.czCountEpisode = tokyoGhoul.czCountEpisode
        tokyoGhoulMemory3.morningModeEnable = tokyoGhoul.morningModeEnable
        tokyoGhoulMemory3.under100CountHit = tokyoGhoul.under100CountHit
        tokyoGhoulMemory3.firstHitCountSum = tokyoGhoul.firstHitCountSum
        tokyoGhoulMemory3.endingCountKisuJaku = tokyoGhoul.endingCountKisuJaku
        tokyoGhoulMemory3.endingCountKisuKyo = tokyoGhoul.endingCountKisuKyo
        tokyoGhoulMemory3.endingCountGusuJaku = tokyoGhoul.endingCountGusuJaku
        tokyoGhoulMemory3.endingCountGusuKyo = tokyoGhoul.endingCountGusuKyo
        tokyoGhoulMemory3.endingCountHighJaku = tokyoGhoul.endingCountHighJaku
        tokyoGhoulMemory3.endingCountHighKyo = tokyoGhoul.endingCountHighKyo
        tokyoGhoulMemory3.endingCountSum = tokyoGhoul.endingCountSum
        // ///////////////////////
        // ver240追加
        // ///////////////////////
        tokyoGhoulMemory3.endingCountExcept1 = tokyoGhoul.endingCountExcept1
        tokyoGhoulMemory3.endingCountExcept2 = tokyoGhoul.endingCountExcept2
        tokyoGhoulMemory3.endingCountExcept3 = tokyoGhoul.endingCountExcept3
        tokyoGhoulMemory3.endingCountExcept4 = tokyoGhoul.endingCountExcept4
        tokyoGhoulMemory3.endingCountOver3 = tokyoGhoul.endingCountOver3
        tokyoGhoulMemory3.endingCountOver4 = tokyoGhoul.endingCountOver4
        tokyoGhoulMemory3.endingCountOver5 = tokyoGhoul.endingCountOver5
        tokyoGhoulMemory3.endingCountOver6 = tokyoGhoul.endingCountOver6
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct tokyoGhoulSubViewLoadMemory: View {
    @ObservedObject var tokyoGhoul: TokyoGhoul
    @ObservedObject var tokyoGhoulMemory1: TokyoGhoulMemory1
    @ObservedObject var tokyoGhoulMemory2: TokyoGhoulMemory2
    @ObservedObject var tokyoGhoulMemory3: TokyoGhoulMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "東京喰種",
            selectedMemory: $tokyoGhoul.selectedMemory,
            memoMemory1: tokyoGhoulMemory1.memo,
            dateDoubleMemory1: tokyoGhoulMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: tokyoGhoulMemory2.memo,
            dateDoubleMemory2: tokyoGhoulMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: tokyoGhoulMemory3.memo,
            dateDoubleMemory3: tokyoGhoulMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        tokyoGhoul.tsukiyamaCountGusu = tokyoGhoulMemory1.tsukiyamaCountGusu
        tokyoGhoul.tsukiyamaCountNot1 = tokyoGhoulMemory1.tsukiyamaCountNot1
        tokyoGhoul.tsukiyamaCountNot2 = tokyoGhoulMemory1.tsukiyamaCountNot2
        tokyoGhoul.tsukiyamaCountNot3 = tokyoGhoulMemory1.tsukiyamaCountNot3
        tokyoGhoul.tsukiyamaCountNot4 = tokyoGhoulMemory1.tsukiyamaCountNot4
        tokyoGhoul.tsukiyamaCountOver4 = tokyoGhoulMemory1.tsukiyamaCountOver4
        tokyoGhoul.tsukiyamaCountOver6 = tokyoGhoulMemory1.tsukiyamaCountOver6
        tokyoGhoul.tsukiyamaCountDefault = tokyoGhoulMemory1.tsukiyamaCountDefault
        tokyoGhoul.tsukiyamaCountRemainGame = tokyoGhoulMemory1.tsukiyamaCountRemainGame
        tokyoGhoul.tsukiyamaCountSum = tokyoGhoulMemory1.tsukiyamaCountSum
        tokyoGhoul.inputGame = tokyoGhoulMemory1.inputGame
        let memoryGameArrayData = decodeIntArray(from: tokyoGhoulMemory1.gameArrayData)
        saveArray(memoryGameArrayData, forKey: tokyoGhoul.gameArrayKey)
        let memoryKindArrayData = decodeStringArray(from: tokyoGhoulMemory1.kindArrayData)
        saveArray(memoryKindArrayData, forKey: tokyoGhoul.kindArrayKey)
        let memoryTriggerArrayData = decodeStringArray(from: tokyoGhoulMemory1.triggerArrayData)
        saveArray(memoryTriggerArrayData, forKey: tokyoGhoul.triggerArrayKey)
        let memoryAtHitArrayData = decodeStringArray(from: tokyoGhoulMemory1.atHitArrayData)
        saveArray(memoryAtHitArrayData, forKey: tokyoGhoul.atHitArrayKey)
//        tokyoGhoul.gameArrayData = tokyoGhoulMemory1.gameArrayData
//        tokyoGhoul.kindArrayData = tokyoGhoulMemory1.kindArrayData
//        tokyoGhoul.triggerArrayData = tokyoGhoulMemory1.triggerArrayData
//        tokyoGhoul.atHitArrayData = tokyoGhoulMemory1.atHitArrayData
        tokyoGhoul.playGameSum = tokyoGhoulMemory1.playGameSum
        tokyoGhoul.czCountRemini = tokyoGhoulMemory1.czCountRemini
        tokyoGhoul.czCountRise = tokyoGhoulMemory1.czCountRise
        tokyoGhoul.czCountSum = tokyoGhoulMemory1.czCountSum
        tokyoGhoul.atCount = tokyoGhoulMemory1.atCount
        tokyoGhoul.screenCountDefault = tokyoGhoulMemory1.screenCountDefault
        tokyoGhoul.screenCountKisu = tokyoGhoulMemory1.screenCountKisu
        tokyoGhoul.screenCountGusu = tokyoGhoulMemory1.screenCountGusu
        tokyoGhoul.screenCountNot1 = tokyoGhoulMemory1.screenCountNot1
        tokyoGhoul.screenCountHighJaku = tokyoGhoulMemory1.screenCountHighJaku
        tokyoGhoul.screenCountHighKyo = tokyoGhoulMemory1.screenCountHighKyo
        tokyoGhoul.screenCountOver4 = tokyoGhoulMemory1.screenCountOver4
        tokyoGhoul.screenCountOver6 = tokyoGhoulMemory1.screenCountOver6
        tokyoGhoul.screenCountSum = tokyoGhoulMemory1.screenCountSum
        
        tokyoGhoul.czCountEpisode = tokyoGhoulMemory1.czCountEpisode
        tokyoGhoul.morningModeEnable = tokyoGhoulMemory1.morningModeEnable
        tokyoGhoul.under100CountHit = tokyoGhoulMemory1.under100CountHit
        tokyoGhoul.firstHitCountSum = tokyoGhoulMemory1.firstHitCountSum
        tokyoGhoul.endingCountKisuJaku = tokyoGhoulMemory1.endingCountKisuJaku
        tokyoGhoul.endingCountKisuKyo = tokyoGhoulMemory1.endingCountKisuKyo
        tokyoGhoul.endingCountGusuJaku = tokyoGhoulMemory1.endingCountGusuJaku
        tokyoGhoul.endingCountGusuKyo = tokyoGhoulMemory1.endingCountGusuKyo
        tokyoGhoul.endingCountHighJaku = tokyoGhoulMemory1.endingCountHighJaku
        tokyoGhoul.endingCountHighKyo = tokyoGhoulMemory1.endingCountHighKyo
        tokyoGhoul.endingCountSum = tokyoGhoulMemory1.endingCountSum
        // ///////////////////////
        // ver240追加
        // ///////////////////////
        tokyoGhoul.endingCountExcept1 = tokyoGhoulMemory1.endingCountExcept1
        tokyoGhoul.endingCountExcept2 = tokyoGhoulMemory1.endingCountExcept2
        tokyoGhoul.endingCountExcept3 = tokyoGhoulMemory1.endingCountExcept3
        tokyoGhoul.endingCountExcept4 = tokyoGhoulMemory1.endingCountExcept4
        tokyoGhoul.endingCountOver3 = tokyoGhoulMemory1.endingCountOver3
        tokyoGhoul.endingCountOver4 = tokyoGhoulMemory1.endingCountOver4
        tokyoGhoul.endingCountOver5 = tokyoGhoulMemory1.endingCountOver5
        tokyoGhoul.endingCountOver6 = tokyoGhoulMemory1.endingCountOver6
    }
    func loadMemory2() {
        tokyoGhoul.tsukiyamaCountGusu = tokyoGhoulMemory2.tsukiyamaCountGusu
        tokyoGhoul.tsukiyamaCountNot1 = tokyoGhoulMemory2.tsukiyamaCountNot1
        tokyoGhoul.tsukiyamaCountNot2 = tokyoGhoulMemory2.tsukiyamaCountNot2
        tokyoGhoul.tsukiyamaCountNot3 = tokyoGhoulMemory2.tsukiyamaCountNot3
        tokyoGhoul.tsukiyamaCountNot4 = tokyoGhoulMemory2.tsukiyamaCountNot4
        tokyoGhoul.tsukiyamaCountOver4 = tokyoGhoulMemory2.tsukiyamaCountOver4
        tokyoGhoul.tsukiyamaCountOver6 = tokyoGhoulMemory2.tsukiyamaCountOver6
        tokyoGhoul.tsukiyamaCountDefault = tokyoGhoulMemory2.tsukiyamaCountDefault
        tokyoGhoul.tsukiyamaCountRemainGame = tokyoGhoulMemory2.tsukiyamaCountRemainGame
        tokyoGhoul.tsukiyamaCountSum = tokyoGhoulMemory2.tsukiyamaCountSum
        tokyoGhoul.inputGame = tokyoGhoulMemory2.inputGame
        let memoryGameArrayData = decodeIntArray(from: tokyoGhoulMemory2.gameArrayData)
        saveArray(memoryGameArrayData, forKey: tokyoGhoul.gameArrayKey)
        let memoryKindArrayData = decodeStringArray(from: tokyoGhoulMemory2.kindArrayData)
        saveArray(memoryKindArrayData, forKey: tokyoGhoul.kindArrayKey)
        let memoryTriggerArrayData = decodeStringArray(from: tokyoGhoulMemory2.triggerArrayData)
        saveArray(memoryTriggerArrayData, forKey: tokyoGhoul.triggerArrayKey)
        let memoryAtHitArrayData = decodeStringArray(from: tokyoGhoulMemory2.atHitArrayData)
        saveArray(memoryAtHitArrayData, forKey: tokyoGhoul.atHitArrayKey)
//        tokyoGhoul.gameArrayData = tokyoGhoulMemory2.gameArrayData
//        tokyoGhoul.kindArrayData = tokyoGhoulMemory2.kindArrayData
//        tokyoGhoul.triggerArrayData = tokyoGhoulMemory2.triggerArrayData
//        tokyoGhoul.atHitArrayData = tokyoGhoulMemory2.atHitArrayData
        tokyoGhoul.playGameSum = tokyoGhoulMemory2.playGameSum
        tokyoGhoul.czCountRemini = tokyoGhoulMemory2.czCountRemini
        tokyoGhoul.czCountRise = tokyoGhoulMemory2.czCountRise
        tokyoGhoul.czCountSum = tokyoGhoulMemory2.czCountSum
        tokyoGhoul.atCount = tokyoGhoulMemory2.atCount
        tokyoGhoul.screenCountDefault = tokyoGhoulMemory2.screenCountDefault
        tokyoGhoul.screenCountKisu = tokyoGhoulMemory2.screenCountKisu
        tokyoGhoul.screenCountGusu = tokyoGhoulMemory2.screenCountGusu
        tokyoGhoul.screenCountNot1 = tokyoGhoulMemory2.screenCountNot1
        tokyoGhoul.screenCountHighJaku = tokyoGhoulMemory2.screenCountHighJaku
        tokyoGhoul.screenCountHighKyo = tokyoGhoulMemory2.screenCountHighKyo
        tokyoGhoul.screenCountOver4 = tokyoGhoulMemory2.screenCountOver4
        tokyoGhoul.screenCountOver6 = tokyoGhoulMemory2.screenCountOver6
        tokyoGhoul.screenCountSum = tokyoGhoulMemory2.screenCountSum
        
        tokyoGhoul.czCountEpisode = tokyoGhoulMemory2.czCountEpisode
        tokyoGhoul.morningModeEnable = tokyoGhoulMemory2.morningModeEnable
        tokyoGhoul.under100CountHit = tokyoGhoulMemory2.under100CountHit
        tokyoGhoul.firstHitCountSum = tokyoGhoulMemory2.firstHitCountSum
        tokyoGhoul.endingCountKisuJaku = tokyoGhoulMemory2.endingCountKisuJaku
        tokyoGhoul.endingCountKisuKyo = tokyoGhoulMemory2.endingCountKisuKyo
        tokyoGhoul.endingCountGusuJaku = tokyoGhoulMemory2.endingCountGusuJaku
        tokyoGhoul.endingCountGusuKyo = tokyoGhoulMemory2.endingCountGusuKyo
        tokyoGhoul.endingCountHighJaku = tokyoGhoulMemory2.endingCountHighJaku
        tokyoGhoul.endingCountHighKyo = tokyoGhoulMemory2.endingCountHighKyo
        tokyoGhoul.endingCountSum = tokyoGhoulMemory2.endingCountSum
        // ///////////////////////
        // ver240追加
        // ///////////////////////
        tokyoGhoul.endingCountExcept1 = tokyoGhoulMemory2.endingCountExcept1
        tokyoGhoul.endingCountExcept2 = tokyoGhoulMemory2.endingCountExcept2
        tokyoGhoul.endingCountExcept3 = tokyoGhoulMemory2.endingCountExcept3
        tokyoGhoul.endingCountExcept4 = tokyoGhoulMemory2.endingCountExcept4
        tokyoGhoul.endingCountOver3 = tokyoGhoulMemory2.endingCountOver3
        tokyoGhoul.endingCountOver4 = tokyoGhoulMemory2.endingCountOver4
        tokyoGhoul.endingCountOver5 = tokyoGhoulMemory2.endingCountOver5
        tokyoGhoul.endingCountOver6 = tokyoGhoulMemory2.endingCountOver6
    }
    func loadMemory3() {
        tokyoGhoul.tsukiyamaCountGusu = tokyoGhoulMemory3.tsukiyamaCountGusu
        tokyoGhoul.tsukiyamaCountNot1 = tokyoGhoulMemory3.tsukiyamaCountNot1
        tokyoGhoul.tsukiyamaCountNot2 = tokyoGhoulMemory3.tsukiyamaCountNot2
        tokyoGhoul.tsukiyamaCountNot3 = tokyoGhoulMemory3.tsukiyamaCountNot3
        tokyoGhoul.tsukiyamaCountNot4 = tokyoGhoulMemory3.tsukiyamaCountNot4
        tokyoGhoul.tsukiyamaCountOver4 = tokyoGhoulMemory3.tsukiyamaCountOver4
        tokyoGhoul.tsukiyamaCountOver6 = tokyoGhoulMemory3.tsukiyamaCountOver6
        tokyoGhoul.tsukiyamaCountDefault = tokyoGhoulMemory3.tsukiyamaCountDefault
        tokyoGhoul.tsukiyamaCountRemainGame = tokyoGhoulMemory3.tsukiyamaCountRemainGame
        tokyoGhoul.tsukiyamaCountSum = tokyoGhoulMemory3.tsukiyamaCountSum
        tokyoGhoul.inputGame = tokyoGhoulMemory3.inputGame
        let memoryGameArrayData = decodeIntArray(from: tokyoGhoulMemory3.gameArrayData)
        saveArray(memoryGameArrayData, forKey: tokyoGhoul.gameArrayKey)
        let memoryKindArrayData = decodeStringArray(from: tokyoGhoulMemory3.kindArrayData)
        saveArray(memoryKindArrayData, forKey: tokyoGhoul.kindArrayKey)
        let memoryTriggerArrayData = decodeStringArray(from: tokyoGhoulMemory3.triggerArrayData)
        saveArray(memoryTriggerArrayData, forKey: tokyoGhoul.triggerArrayKey)
        let memoryAtHitArrayData = decodeStringArray(from: tokyoGhoulMemory3.atHitArrayData)
        saveArray(memoryAtHitArrayData, forKey: tokyoGhoul.atHitArrayKey)
//        tokyoGhoul.gameArrayData = tokyoGhoulMemory3.gameArrayData
//        tokyoGhoul.kindArrayData = tokyoGhoulMemory3.kindArrayData
//        tokyoGhoul.triggerArrayData = tokyoGhoulMemory3.triggerArrayData
//        tokyoGhoul.atHitArrayData = tokyoGhoulMemory3.atHitArrayData
        tokyoGhoul.playGameSum = tokyoGhoulMemory3.playGameSum
        tokyoGhoul.czCountRemini = tokyoGhoulMemory3.czCountRemini
        tokyoGhoul.czCountRise = tokyoGhoulMemory3.czCountRise
        tokyoGhoul.czCountSum = tokyoGhoulMemory3.czCountSum
        tokyoGhoul.atCount = tokyoGhoulMemory3.atCount
        tokyoGhoul.screenCountDefault = tokyoGhoulMemory3.screenCountDefault
        tokyoGhoul.screenCountKisu = tokyoGhoulMemory3.screenCountKisu
        tokyoGhoul.screenCountGusu = tokyoGhoulMemory3.screenCountGusu
        tokyoGhoul.screenCountNot1 = tokyoGhoulMemory3.screenCountNot1
        tokyoGhoul.screenCountHighJaku = tokyoGhoulMemory3.screenCountHighJaku
        tokyoGhoul.screenCountHighKyo = tokyoGhoulMemory3.screenCountHighKyo
        tokyoGhoul.screenCountOver4 = tokyoGhoulMemory3.screenCountOver4
        tokyoGhoul.screenCountOver6 = tokyoGhoulMemory3.screenCountOver6
        tokyoGhoul.screenCountSum = tokyoGhoulMemory3.screenCountSum
        
        tokyoGhoul.czCountEpisode = tokyoGhoulMemory3.czCountEpisode
        tokyoGhoul.morningModeEnable = tokyoGhoulMemory3.morningModeEnable
        tokyoGhoul.under100CountHit = tokyoGhoulMemory3.under100CountHit
        tokyoGhoul.firstHitCountSum = tokyoGhoulMemory3.firstHitCountSum
        tokyoGhoul.endingCountKisuJaku = tokyoGhoulMemory3.endingCountKisuJaku
        tokyoGhoul.endingCountKisuKyo = tokyoGhoulMemory3.endingCountKisuKyo
        tokyoGhoul.endingCountGusuJaku = tokyoGhoulMemory3.endingCountGusuJaku
        tokyoGhoul.endingCountGusuKyo = tokyoGhoulMemory3.endingCountGusuKyo
        tokyoGhoul.endingCountHighJaku = tokyoGhoulMemory3.endingCountHighJaku
        tokyoGhoul.endingCountHighKyo = tokyoGhoulMemory3.endingCountHighKyo
        tokyoGhoul.endingCountSum = tokyoGhoulMemory3.endingCountSum
        // ///////////////////////
        // ver240追加
        // ///////////////////////
        tokyoGhoul.endingCountExcept1 = tokyoGhoulMemory3.endingCountExcept1
        tokyoGhoul.endingCountExcept2 = tokyoGhoulMemory3.endingCountExcept2
        tokyoGhoul.endingCountExcept3 = tokyoGhoulMemory3.endingCountExcept3
        tokyoGhoul.endingCountExcept4 = tokyoGhoulMemory3.endingCountExcept4
        tokyoGhoul.endingCountOver3 = tokyoGhoulMemory3.endingCountOver3
        tokyoGhoul.endingCountOver4 = tokyoGhoulMemory3.endingCountOver4
        tokyoGhoul.endingCountOver5 = tokyoGhoulMemory3.endingCountOver5
        tokyoGhoul.endingCountOver6 = tokyoGhoulMemory3.endingCountOver6
    }
}

#Preview {
    tokyoGhoulViewTop(
        ver351: Ver351(),
        ver352: Ver352(),
    )
}
