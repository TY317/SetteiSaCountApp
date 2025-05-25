//
//  gundamSeedViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/05.
//

import SwiftUI
import FirebaseAnalytics

struct gundamSeedViewTop: View {
    @ObservedObject var ver310: Ver310
    @StateObject var gundamSeed = GundamSeed()
    @State var isShowAlert: Bool = false
    @StateObject var gundamSeedMemory1 = GundamSeedMemory1()
    @StateObject var gundamSeedMemory2 = GundamSeedMemory2()
    @StateObject var gundamSeedMemory3 = GundamSeedMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: gundamSeedViewNormal()) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // CZ,AT 初当り
                    NavigationLink(destination: gundamSeedViewFirstHit(
                        gundamSeed: gundamSeed
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "CZ,AT 初当り履歴"
                        )
                    }
                    // CZ,AT 終了画面
                    NavigationLink(destination: gundamSeedViewScreen(
                        gundamSeed: gundamSeed
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "CZ,AT 終了画面"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "ガンダムSEED")
                }
                
                // 設定推測グラフ
                NavigationLink(destination: gundamSeedView95Ci(
                    gundamSeed: gundamSeed,
                    selection: 1
                )) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4788")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ガンダムSEED",
                screenClass: screenClass
            )
        }
        // 画面ログイベントの収集
//        .onAppear {
//            // Viewが表示されたタイミングでログを送信します
//            Analytics.logEvent(AnalyticsEventScreenView, parameters: [
//                AnalyticsParameterScreenName: "ガンダムSEED", // この画面の名前を識別できるように設定
//                AnalyticsParameterScreenClass: "gundamSeedViewTop" // 通常はViewのクラス名（構造体名）を設定
//                // その他、この画面に関連するパラメータを追加できます
//            ])
//            print("Firebase Analytics: gundamSeedViewTop appeared.") // デバッグ用にログ出力
//        }
        .onAppear {
            if ver310.gundamSeedMachineIconBadgeStatus != "none" {
                ver310.gundamSeedMachineIconBadgeStatus = "none"
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(gundamSeedSubViewLoadMemory(
                        gundamSeed: gundamSeed,
                        gundamSeedMemory1: gundamSeedMemory1,
                        gundamSeedMemory2: gundamSeedMemory2,
                        gundamSeedMemory3: gundamSeedMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(gundamSeedSubViewSaveMemory(
                        gundamSeed: gundamSeed,
                        gundamSeedMemory1: gundamSeedMemory1,
                        gundamSeedMemory2: gundamSeedMemory2,
                        gundamSeedMemory3: gundamSeedMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: gundamSeed.resetAll, message: "この機種のデータを全てリセットします")
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct gundamSeedSubViewSaveMemory: View {
    @ObservedObject var gundamSeed: GundamSeed
    @ObservedObject var gundamSeedMemory1: GundamSeedMemory1
    @ObservedObject var gundamSeedMemory2: GundamSeedMemory2
    @ObservedObject var gundamSeedMemory3: GundamSeedMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ガンダムSEED",
            selectedMemory: $gundamSeed.selectedMemory,
            memoMemory1: $gundamSeedMemory1.memo,
            dateDoubleMemory1: $gundamSeedMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $gundamSeedMemory2.memo,
            dateDoubleMemory2: $gundamSeedMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $gundamSeedMemory3.memo,
            dateDoubleMemory3: $gundamSeedMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        gundamSeedMemory1.gameArrayData = gundamSeed.gameArrayData
        gundamSeedMemory1.bonusKindArrayData = gundamSeed.bonusKindArrayData
        gundamSeedMemory1.atHitArrayData = gundamSeed.atHitArrayData
        gundamSeedMemory1.playGameSum = gundamSeed.playGameSum
        gundamSeedMemory1.atCount = gundamSeed.atCount
        gundamSeedMemory1.czCount = gundamSeed.czCount
        gundamSeedMemory1.under100Count49 = gundamSeed.under100Count49
        gundamSeedMemory1.under100Count99 = gundamSeed.under100Count99
        gundamSeedMemory1.under100CountSum = gundamSeed.under100CountSum
        gundamSeedMemory1.over100Count = gundamSeed.over100Count
        gundamSeedMemory1.underOver100CountSum = gundamSeed.underOver100CountSum
        gundamSeedMemory1.screenCountDefault = gundamSeed.screenCountDefault
        gundamSeedMemory1.screenCountRebirth = gundamSeed.screenCountRebirth
        gundamSeedMemory1.screenCountKisu = gundamSeed.screenCountKisu
        gundamSeedMemory1.screenCountGusu = gundamSeed.screenCountGusu
        gundamSeedMemory1.screenCountHighJaku = gundamSeed.screenCountHighJaku
        gundamSeedMemory1.screenCountHighKyo = gundamSeed.screenCountHighKyo
        gundamSeedMemory1.screenCountChangeHigh = gundamSeed.screenCountChangeHigh
        gundamSeedMemory1.screenCountGusuFix = gundamSeed.screenCountGusuFix
        gundamSeedMemory1.screenCountNegate1 = gundamSeed.screenCountNegate1
        gundamSeedMemory1.screenCountNegate2 = gundamSeed.screenCountNegate2
        gundamSeedMemory1.screenCountNegate3High = gundamSeed.screenCountNegate3High
        gundamSeedMemory1.screenCountOver4 = gundamSeed.screenCountOver4
        gundamSeedMemory1.screenCountOver6 = gundamSeed.screenCountOver6
        gundamSeedMemory1.screenCountSum = gundamSeed.screenCountSum
    }
    func saveMemory2() {
        gundamSeedMemory2.gameArrayData = gundamSeed.gameArrayData
        gundamSeedMemory2.bonusKindArrayData = gundamSeed.bonusKindArrayData
        gundamSeedMemory2.atHitArrayData = gundamSeed.atHitArrayData
        gundamSeedMemory2.playGameSum = gundamSeed.playGameSum
        gundamSeedMemory2.atCount = gundamSeed.atCount
        gundamSeedMemory2.czCount = gundamSeed.czCount
        gundamSeedMemory2.under100Count49 = gundamSeed.under100Count49
        gundamSeedMemory2.under100Count99 = gundamSeed.under100Count99
        gundamSeedMemory2.under100CountSum = gundamSeed.under100CountSum
        gundamSeedMemory2.over100Count = gundamSeed.over100Count
        gundamSeedMemory2.underOver100CountSum = gundamSeed.underOver100CountSum
        gundamSeedMemory2.screenCountDefault = gundamSeed.screenCountDefault
        gundamSeedMemory2.screenCountRebirth = gundamSeed.screenCountRebirth
        gundamSeedMemory2.screenCountKisu = gundamSeed.screenCountKisu
        gundamSeedMemory2.screenCountGusu = gundamSeed.screenCountGusu
        gundamSeedMemory2.screenCountHighJaku = gundamSeed.screenCountHighJaku
        gundamSeedMemory2.screenCountHighKyo = gundamSeed.screenCountHighKyo
        gundamSeedMemory2.screenCountChangeHigh = gundamSeed.screenCountChangeHigh
        gundamSeedMemory2.screenCountGusuFix = gundamSeed.screenCountGusuFix
        gundamSeedMemory2.screenCountNegate1 = gundamSeed.screenCountNegate1
        gundamSeedMemory2.screenCountNegate2 = gundamSeed.screenCountNegate2
        gundamSeedMemory2.screenCountNegate3High = gundamSeed.screenCountNegate3High
        gundamSeedMemory2.screenCountOver4 = gundamSeed.screenCountOver4
        gundamSeedMemory2.screenCountOver6 = gundamSeed.screenCountOver6
        gundamSeedMemory2.screenCountSum = gundamSeed.screenCountSum
    }
    func saveMemory3() {
        gundamSeedMemory3.gameArrayData = gundamSeed.gameArrayData
        gundamSeedMemory3.bonusKindArrayData = gundamSeed.bonusKindArrayData
        gundamSeedMemory3.atHitArrayData = gundamSeed.atHitArrayData
        gundamSeedMemory3.playGameSum = gundamSeed.playGameSum
        gundamSeedMemory3.atCount = gundamSeed.atCount
        gundamSeedMemory3.czCount = gundamSeed.czCount
        gundamSeedMemory3.under100Count49 = gundamSeed.under100Count49
        gundamSeedMemory3.under100Count99 = gundamSeed.under100Count99
        gundamSeedMemory3.under100CountSum = gundamSeed.under100CountSum
        gundamSeedMemory3.over100Count = gundamSeed.over100Count
        gundamSeedMemory3.underOver100CountSum = gundamSeed.underOver100CountSum
        gundamSeedMemory3.screenCountDefault = gundamSeed.screenCountDefault
        gundamSeedMemory3.screenCountRebirth = gundamSeed.screenCountRebirth
        gundamSeedMemory3.screenCountKisu = gundamSeed.screenCountKisu
        gundamSeedMemory3.screenCountGusu = gundamSeed.screenCountGusu
        gundamSeedMemory3.screenCountHighJaku = gundamSeed.screenCountHighJaku
        gundamSeedMemory3.screenCountHighKyo = gundamSeed.screenCountHighKyo
        gundamSeedMemory3.screenCountChangeHigh = gundamSeed.screenCountChangeHigh
        gundamSeedMemory3.screenCountGusuFix = gundamSeed.screenCountGusuFix
        gundamSeedMemory3.screenCountNegate1 = gundamSeed.screenCountNegate1
        gundamSeedMemory3.screenCountNegate2 = gundamSeed.screenCountNegate2
        gundamSeedMemory3.screenCountNegate3High = gundamSeed.screenCountNegate3High
        gundamSeedMemory3.screenCountOver4 = gundamSeed.screenCountOver4
        gundamSeedMemory3.screenCountOver6 = gundamSeed.screenCountOver6
        gundamSeedMemory3.screenCountSum = gundamSeed.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct gundamSeedSubViewLoadMemory: View {
    @ObservedObject var gundamSeed: GundamSeed
    @ObservedObject var gundamSeedMemory1: GundamSeedMemory1
    @ObservedObject var gundamSeedMemory2: GundamSeedMemory2
    @ObservedObject var gundamSeedMemory3: GundamSeedMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ガンダムSEED",
            selectedMemory: $gundamSeed.selectedMemory,
            memoMemory1: gundamSeedMemory1.memo,
            dateDoubleMemory1: gundamSeedMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: gundamSeedMemory2.memo,
            dateDoubleMemory2: gundamSeedMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: gundamSeedMemory3.memo,
            dateDoubleMemory3: gundamSeedMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        let memoryGameArrayData = decodeIntArray(from: gundamSeedMemory1.gameArrayData)
        saveArray(memoryGameArrayData, forKey: gundamSeed.gameArrayKey)
        let memoryKindArrayData = decodeStringArray(from: gundamSeedMemory1.bonusKindArrayData)
        saveArray(memoryKindArrayData, forKey: gundamSeed.bonusKindArrayKey)
        let memoryAtHitArrayData = decodeStringArray(from: gundamSeedMemory1.atHitArrayData)
        saveArray(memoryAtHitArrayData, forKey: gundamSeed.atHitArrayKey)
        gundamSeed.playGameSum = gundamSeedMemory1.playGameSum
        gundamSeed.atCount = gundamSeedMemory1.atCount
        gundamSeed.czCount = gundamSeedMemory1.czCount
        gundamSeed.under100Count49 = gundamSeedMemory1.under100Count49
        gundamSeed.under100Count99 = gundamSeedMemory1.under100Count99
        gundamSeed.under100CountSum = gundamSeedMemory1.under100CountSum
        gundamSeed.over100Count = gundamSeedMemory1.over100Count
        gundamSeed.underOver100CountSum = gundamSeedMemory1.underOver100CountSum
        gundamSeed.screenCountDefault = gundamSeedMemory1.screenCountDefault
        gundamSeed.screenCountRebirth = gundamSeedMemory1.screenCountRebirth
        gundamSeed.screenCountKisu = gundamSeedMemory1.screenCountKisu
        gundamSeed.screenCountGusu = gundamSeedMemory1.screenCountGusu
        gundamSeed.screenCountHighJaku = gundamSeedMemory1.screenCountHighJaku
        gundamSeed.screenCountHighKyo = gundamSeedMemory1.screenCountHighKyo
        gundamSeed.screenCountChangeHigh = gundamSeedMemory1.screenCountChangeHigh
        gundamSeed.screenCountGusuFix = gundamSeedMemory1.screenCountGusuFix
        gundamSeed.screenCountNegate1 = gundamSeedMemory1.screenCountNegate1
        gundamSeed.screenCountNegate2 = gundamSeedMemory1.screenCountNegate2
        gundamSeed.screenCountNegate3High = gundamSeedMemory1.screenCountNegate3High
        gundamSeed.screenCountOver4 = gundamSeedMemory1.screenCountOver4
        gundamSeed.screenCountOver6 = gundamSeedMemory1.screenCountOver6
        gundamSeed.screenCountSum = gundamSeedMemory1.screenCountSum
    }
    func loadMemory2() {
        let memoryGameArrayData = decodeIntArray(from: gundamSeedMemory2.gameArrayData)
        saveArray(memoryGameArrayData, forKey: gundamSeed.gameArrayKey)
        let memoryKindArrayData = decodeStringArray(from: gundamSeedMemory2.bonusKindArrayData)
        saveArray(memoryKindArrayData, forKey: gundamSeed.bonusKindArrayKey)
        let memoryAtHitArrayData = decodeStringArray(from: gundamSeedMemory2.atHitArrayData)
        saveArray(memoryAtHitArrayData, forKey: gundamSeed.atHitArrayKey)
        gundamSeed.playGameSum = gundamSeedMemory2.playGameSum
        gundamSeed.atCount = gundamSeedMemory2.atCount
        gundamSeed.czCount = gundamSeedMemory2.czCount
        gundamSeed.under100Count49 = gundamSeedMemory2.under100Count49
        gundamSeed.under100Count99 = gundamSeedMemory2.under100Count99
        gundamSeed.under100CountSum = gundamSeedMemory2.under100CountSum
        gundamSeed.over100Count = gundamSeedMemory2.over100Count
        gundamSeed.underOver100CountSum = gundamSeedMemory2.underOver100CountSum
        gundamSeed.screenCountDefault = gundamSeedMemory2.screenCountDefault
        gundamSeed.screenCountRebirth = gundamSeedMemory2.screenCountRebirth
        gundamSeed.screenCountKisu = gundamSeedMemory2.screenCountKisu
        gundamSeed.screenCountGusu = gundamSeedMemory2.screenCountGusu
        gundamSeed.screenCountHighJaku = gundamSeedMemory2.screenCountHighJaku
        gundamSeed.screenCountHighKyo = gundamSeedMemory2.screenCountHighKyo
        gundamSeed.screenCountChangeHigh = gundamSeedMemory2.screenCountChangeHigh
        gundamSeed.screenCountGusuFix = gundamSeedMemory2.screenCountGusuFix
        gundamSeed.screenCountNegate1 = gundamSeedMemory2.screenCountNegate1
        gundamSeed.screenCountNegate2 = gundamSeedMemory2.screenCountNegate2
        gundamSeed.screenCountNegate3High = gundamSeedMemory2.screenCountNegate3High
        gundamSeed.screenCountOver4 = gundamSeedMemory2.screenCountOver4
        gundamSeed.screenCountOver6 = gundamSeedMemory2.screenCountOver6
        gundamSeed.screenCountSum = gundamSeedMemory2.screenCountSum
    }
    func loadMemory3() {
        let memoryGameArrayData = decodeIntArray(from: gundamSeedMemory3.gameArrayData)
        saveArray(memoryGameArrayData, forKey: gundamSeed.gameArrayKey)
        let memoryKindArrayData = decodeStringArray(from: gundamSeedMemory3.bonusKindArrayData)
        saveArray(memoryKindArrayData, forKey: gundamSeed.bonusKindArrayKey)
        let memoryAtHitArrayData = decodeStringArray(from: gundamSeedMemory3.atHitArrayData)
        saveArray(memoryAtHitArrayData, forKey: gundamSeed.atHitArrayKey)
        gundamSeed.playGameSum = gundamSeedMemory3.playGameSum
        gundamSeed.atCount = gundamSeedMemory3.atCount
        gundamSeed.czCount = gundamSeedMemory3.czCount
        gundamSeed.under100Count49 = gundamSeedMemory3.under100Count49
        gundamSeed.under100Count99 = gundamSeedMemory3.under100Count99
        gundamSeed.under100CountSum = gundamSeedMemory3.under100CountSum
        gundamSeed.over100Count = gundamSeedMemory3.over100Count
        gundamSeed.underOver100CountSum = gundamSeedMemory3.underOver100CountSum
        gundamSeed.screenCountDefault = gundamSeedMemory3.screenCountDefault
        gundamSeed.screenCountRebirth = gundamSeedMemory3.screenCountRebirth
        gundamSeed.screenCountKisu = gundamSeedMemory3.screenCountKisu
        gundamSeed.screenCountGusu = gundamSeedMemory3.screenCountGusu
        gundamSeed.screenCountHighJaku = gundamSeedMemory3.screenCountHighJaku
        gundamSeed.screenCountHighKyo = gundamSeedMemory3.screenCountHighKyo
        gundamSeed.screenCountChangeHigh = gundamSeedMemory3.screenCountChangeHigh
        gundamSeed.screenCountGusuFix = gundamSeedMemory3.screenCountGusuFix
        gundamSeed.screenCountNegate1 = gundamSeedMemory3.screenCountNegate1
        gundamSeed.screenCountNegate2 = gundamSeedMemory3.screenCountNegate2
        gundamSeed.screenCountNegate3High = gundamSeedMemory3.screenCountNegate3High
        gundamSeed.screenCountOver4 = gundamSeedMemory3.screenCountOver4
        gundamSeed.screenCountOver6 = gundamSeedMemory3.screenCountOver6
        gundamSeed.screenCountSum = gundamSeedMemory3.screenCountSum
    }
}

#Preview {
    gundamSeedViewTop(
        ver310: Ver310()
    )
}
