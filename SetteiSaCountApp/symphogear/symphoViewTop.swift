//
//  symphoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/14.
//

import SwiftUI
import TipKit
import FirebaseAnalytics

// ////////////////////////
// 変数
// ////////////////////////
class Symphogear: ObservableObject {
    // //////////////////////
    // AT初当り履歴
    // //////////////////////
    // 選択肢の設定
    @Published var selectListBonus = ["AT", "現在"]
    @Published var selectListAtTrigger = ["AXZバトル", "最終決戦", "ゲーム数", "天国", "ギアフラグ", "チェリー", "てがみ", "即前兆", "引き戻し", "天井", "その他"]
    @Published var selectListCurrentTrigger = ["-"]
    // 選択結果の設定
    @Published var inputGame = 0
    @Published var selectedBonus = "AT"
    @Published var selectedAtTrigger = "ギアフラグ"
    @Published var selectedCurrentTrigger = "-"
    // //// 配列の設定
    // 当選ゲーム数配列
    let gameArrayKey = "symphoGameArrayData"
    @AppStorage("symphoGameArrayData") var gameArrayData: Data?
    // ボーナス種類配列
    let bonusArrayKey = "symphoBonusArrayKey"
    @AppStorage("symphoBonusArrayKey") var bonusArrayData: Data?
    // 当選契機配列
    let triggerArrayKey = "symphoTriggerArrayKey"
    @AppStorage("symphoTriggerArrayKey") var triggerArrayData: Data?
    // 集計結果の変数設定
    @AppStorage("symphoAtCount") var atCount = 0
    @AppStorage("symphoCzSaishuCount") var czSaishuCount = 0
    @AppStorage("symphoPlayGame") var playGame = 0
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: bonusArrayData, key: bonusArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        atCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "AT")
        czSaishuCount = arrayStringDataCount(arrayData: triggerArrayData, countString: "最終決戦")
        playGame = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedBonus = "AT"
        selectedAtTrigger = "ゲーム数"
        selectedCurrentTrigger = "-"
    }
    
    // データ追加 AT
    func addDataHistoryAt() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedAtTrigger, key: triggerArrayKey)
        atCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "AT")
        czSaishuCount = arrayStringDataCount(arrayData: triggerArrayData, countString: "最終決戦")
        playGame = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedBonus = "AT"
        selectedAtTrigger = "ゲーム数"
        selectedCurrentTrigger = "-"
    }
    // データ追加 現在
    func addDataHistoryCurrent() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedCurrentTrigger, key: triggerArrayKey)
        atCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "AT")
        czSaishuCount = arrayStringDataCount(arrayData: triggerArrayData, countString: "最終決戦")
        playGame = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedBonus = "AT"
        selectedAtTrigger = "ゲーム数"
        selectedCurrentTrigger = "-"
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: bonusArrayData, key: bonusArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        atCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "AT")
        czSaishuCount = arrayStringDataCount(arrayData: triggerArrayData, countString: "最終決戦")
        playGame = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedBonus = "AT"
        selectedAtTrigger = "ゲーム数"
        selectedCurrentTrigger = "-"
    }
    
    // ///////////////////////
    // AT終了画面
    // ///////////////////////
    @AppStorage("symphoScreenCurrentKeyword") var screenCurrentKeyword = ""
    @Published var screenKeywordList = ["枠なし", "白枠A", "白枠B", "赤枠A", "赤枠B", "紫枠A", "紫枠B", "紫枠C", "紫枠D", "紫枠E", "銀枠", "金枠"]
    @AppStorage("symphoScreenCountNone") var screenCountNone = 0 {
        didSet {
            screenCountSum = countSum(screenCountNone, screenCountWhiteA, screenCountWhiteB, screenCountRedA, screenCountRedB, screenCountPurpleAB, screenCountPurpleC, screenCountPurpleD, screenCountPurpleE, screenCountSilver, screenCountGold)
        }
    }
        @AppStorage("symphoScreenCountWhiteA") var screenCountWhiteA = 0 {
            didSet {
                screenCountSum = countSum(screenCountNone, screenCountWhiteA, screenCountWhiteB, screenCountRedA, screenCountRedB, screenCountPurpleAB, screenCountPurpleC, screenCountPurpleD, screenCountPurpleE, screenCountSilver, screenCountGold)
            }
        }
            @AppStorage("symphoScreenCountWhiteB") var screenCountWhiteB = 0 {
                didSet {
                    screenCountSum = countSum(screenCountNone, screenCountWhiteA, screenCountWhiteB, screenCountRedA, screenCountRedB, screenCountPurpleAB, screenCountPurpleC, screenCountPurpleD, screenCountPurpleE, screenCountSilver, screenCountGold)
                }
            }
                @AppStorage("symphoScreenCountRedA") var screenCountRedA = 0 {
                    didSet {
                        screenCountSum = countSum(screenCountNone, screenCountWhiteA, screenCountWhiteB, screenCountRedA, screenCountRedB, screenCountPurpleAB, screenCountPurpleC, screenCountPurpleD, screenCountPurpleE, screenCountSilver, screenCountGold)
                    }
                }
                    @AppStorage("symphoScreenCountRedB") var screenCountRedB = 0 {
                        didSet {
                            screenCountSum = countSum(screenCountNone, screenCountWhiteA, screenCountWhiteB, screenCountRedA, screenCountRedB, screenCountPurpleAB, screenCountPurpleC, screenCountPurpleD, screenCountPurpleE, screenCountSilver, screenCountGold)
                        }
                    }
                        @AppStorage("symphoScreenCountPurpleAB") var screenCountPurpleAB = 0 {
                            didSet {
                                screenCountSum = countSum(screenCountNone, screenCountWhiteA, screenCountWhiteB, screenCountRedA, screenCountRedB, screenCountPurpleAB, screenCountPurpleC, screenCountPurpleD, screenCountPurpleE, screenCountSilver, screenCountGold)
                            }
                        }
                            @AppStorage("symphoScreenCountPurpleC") var screenCountPurpleC = 0 {
                                didSet {
                                    screenCountSum = countSum(screenCountNone, screenCountWhiteA, screenCountWhiteB, screenCountRedA, screenCountRedB, screenCountPurpleAB, screenCountPurpleC, screenCountPurpleD, screenCountPurpleE, screenCountSilver, screenCountGold)
                                }
                            }
                                @AppStorage("symphoScreenCountPurpleD") var screenCountPurpleD = 0 {
                                    didSet {
                                        screenCountSum = countSum(screenCountNone, screenCountWhiteA, screenCountWhiteB, screenCountRedA, screenCountRedB, screenCountPurpleAB, screenCountPurpleC, screenCountPurpleD, screenCountPurpleE, screenCountSilver, screenCountGold)
                                    }
                                }
                                    @AppStorage("symphoScreenCountPurpleE") var screenCountPurpleE = 0 {
                                        didSet {
                                            screenCountSum = countSum(screenCountNone, screenCountWhiteA, screenCountWhiteB, screenCountRedA, screenCountRedB, screenCountPurpleAB, screenCountPurpleC, screenCountPurpleD, screenCountPurpleE, screenCountSilver, screenCountGold)
                                        }
                                    }
                                        @AppStorage("symphoScreenCountSilver") var screenCountSilver = 0 {
                                            didSet {
                                                screenCountSum = countSum(screenCountNone, screenCountWhiteA, screenCountWhiteB, screenCountRedA, screenCountRedB, screenCountPurpleAB, screenCountPurpleC, screenCountPurpleD, screenCountPurpleE, screenCountSilver, screenCountGold)
                                            }
                                        }
                                            @AppStorage("symphoScreenCountGold") var screenCountGold = 0 {
                                                didSet {
                                                    screenCountSum = countSum(screenCountNone, screenCountWhiteA, screenCountWhiteB, screenCountRedA, screenCountRedB, screenCountPurpleAB, screenCountPurpleC, screenCountPurpleD, screenCountPurpleE, screenCountSilver, screenCountGold)
                                                }
                                            }
    @AppStorage("symphoScreenCountSum") var screenCountSum = 0
    
    func resetScreen() {
        screenCurrentKeyword = ""
        minusCheck = false
        screenCountNone = 0
        screenCountWhiteA = 0
        screenCountWhiteB = 0
        screenCountRedA = 0
        screenCountRedB = 0
        screenCountPurpleAB = 0
        screenCountPurpleC = 0
        screenCountPurpleD = 0
        screenCountPurpleE = 0
        screenCountSilver = 0
        screenCountGold = 0
    }
    
    // //////////////////////
    // AT終了後のボイス
    // //////////////////////
    @Published var selectListVoice = ["結局わがままなんだよね", "簡単には離さないよ！", "急いで戻らなきゃ！", "私が今を守ってみせますね！", "壁呼ばわりとは不躾な・・剣だ！", "どうなってやがる！", "闇の奥底だ・・", "何もできないもどかしさ・・", "次があれば必ず！", "頑張るしかないわね", "いつかきっと、嫌なことを全部解決してくれるんだから！", "パンパカパーン！　デース！"]
    @AppStorage("symphoSelectedVoice") var selectedVoice = "結局わがままなんだよね"
    
    func resetVoice() {
        minusCheck = false
    }
    
    // //////////////////////
    // 共通
    // //////////////////////
    @AppStorage("symphoMinusCheck") var minusCheck = false
    @AppStorage("symphoSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetHistory()
        resetScreen()
        resetVoice()
    }
}


// //// メモリー1
class SymphogearMemory1: ObservableObject {
    @AppStorage("symphoGameArrayDataMemory1") var gameArrayData: Data?
    @AppStorage("symphoBonusArrayKeyMemory1") var bonusArrayData: Data?
    @AppStorage("symphoTriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("symphoAtCountMemory1") var atCount = 0
    @AppStorage("symphoCzSaishuCountMemory1") var czSaishuCount = 0
    @AppStorage("symphoPlayGameMemory1") var playGame = 0
    @AppStorage("symphoScreenCountNoneMemory1") var screenCountNone = 0
    @AppStorage("symphoScreenCountWhiteAMemory1") var screenCountWhiteA = 0
    @AppStorage("symphoScreenCountWhiteBMemory1") var screenCountWhiteB = 0
    @AppStorage("symphoScreenCountRedAMemory1") var screenCountRedA = 0
    @AppStorage("symphoScreenCountRedBMemory1") var screenCountRedB = 0
    @AppStorage("symphoScreenCountPurpleABMemory1") var screenCountPurpleAB = 0
    @AppStorage("symphoScreenCountPurpleCMemory1") var screenCountPurpleC = 0
    @AppStorage("symphoScreenCountPurpleDMemory1") var screenCountPurpleD = 0
    @AppStorage("symphoScreenCountPurpleEMemory1") var screenCountPurpleE = 0
    @AppStorage("symphoScreenCountSilverMemory1") var screenCountSilver = 0
    @AppStorage("symphoScreenCountGoldMemory1") var screenCountGold = 0
    @AppStorage("symphoScreenCountSumMemory1") var screenCountSum = 0
    @AppStorage("symphoMemoMemory1") var memo = ""
    @AppStorage("symphoDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class SymphogearMemory2: ObservableObject {
    @AppStorage("symphoGameArrayDataMemory2") var gameArrayData: Data?
    @AppStorage("symphoBonusArrayKeyMemory2") var bonusArrayData: Data?
    @AppStorage("symphoTriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("symphoAtCountMemory2") var atCount = 0
    @AppStorage("symphoCzSaishuCountMemory2") var czSaishuCount = 0
    @AppStorage("symphoPlayGameMemory2") var playGame = 0
    @AppStorage("symphoScreenCountNoneMemory2") var screenCountNone = 0
    @AppStorage("symphoScreenCountWhiteAMemory2") var screenCountWhiteA = 0
    @AppStorage("symphoScreenCountWhiteBMemory2") var screenCountWhiteB = 0
    @AppStorage("symphoScreenCountRedAMemory2") var screenCountRedA = 0
    @AppStorage("symphoScreenCountRedBMemory2") var screenCountRedB = 0
    @AppStorage("symphoScreenCountPurpleABMemory2") var screenCountPurpleAB = 0
    @AppStorage("symphoScreenCountPurpleCMemory2") var screenCountPurpleC = 0
    @AppStorage("symphoScreenCountPurpleDMemory2") var screenCountPurpleD = 0
    @AppStorage("symphoScreenCountPurpleEMemory2") var screenCountPurpleE = 0
    @AppStorage("symphoScreenCountSilverMemory2") var screenCountSilver = 0
    @AppStorage("symphoScreenCountGoldMemory2") var screenCountGold = 0
    @AppStorage("symphoScreenCountSumMemory2") var screenCountSum = 0
    @AppStorage("symphoMemoMemory2") var memo = ""
    @AppStorage("symphoDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class SymphogearMemory3: ObservableObject {
    @AppStorage("symphoGameArrayDataMemory3") var gameArrayData: Data?
    @AppStorage("symphoBonusArrayKeyMemory3") var bonusArrayData: Data?
    @AppStorage("symphoTriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("symphoAtCountMemory3") var atCount = 0
    @AppStorage("symphoCzSaishuCountMemory3") var czSaishuCount = 0
    @AppStorage("symphoPlayGameMemory3") var playGame = 0
    @AppStorage("symphoScreenCountNoneMemory3") var screenCountNone = 0
    @AppStorage("symphoScreenCountWhiteAMemory3") var screenCountWhiteA = 0
    @AppStorage("symphoScreenCountWhiteBMemory3") var screenCountWhiteB = 0
    @AppStorage("symphoScreenCountRedAMemory3") var screenCountRedA = 0
    @AppStorage("symphoScreenCountRedBMemory3") var screenCountRedB = 0
    @AppStorage("symphoScreenCountPurpleABMemory3") var screenCountPurpleAB = 0
    @AppStorage("symphoScreenCountPurpleCMemory3") var screenCountPurpleC = 0
    @AppStorage("symphoScreenCountPurpleDMemory3") var screenCountPurpleD = 0
    @AppStorage("symphoScreenCountPurpleEMemory3") var screenCountPurpleE = 0
    @AppStorage("symphoScreenCountSilverMemory3") var screenCountSilver = 0
    @AppStorage("symphoScreenCountGoldMemory3") var screenCountGold = 0
    @AppStorage("symphoScreenCountSumMemory3") var screenCountSum = 0
    @AppStorage("symphoMemoMemory3") var memo = ""
    @AppStorage("symphoDateMemory3") var dateDouble = 0.0
}

struct symphoViewTop: View {
//    @ObservedObject var sympho = Symphogear()
    @StateObject var sympho = Symphogear()
    @State var isShowAlert = false
    @State var isShowSaveView: Bool = false
    @State var isShowLoadView: Bool = false
    @StateObject var symphoMemory1 = SymphogearMemory1()
    @StateObject var symphoMemory2 = SymphogearMemory2()
    @StateObject var symphoMemory3 = SymphogearMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // AT初当り履歴
                    NavigationLink(destination: symphoViewHistory(sympho: sympho)) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "AT初当り履歴")
                    }
                    // AT終了画面
                    NavigationLink(destination: symphoViewScreen(sympho: sympho)) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "AT終了画面")
                    }
                    // AT終了後のボイス
                    NavigationLink(destination: symphoViewVoice()) {
                        unitLabelMenu(imageSystemName: "message", textBody: "AT終了後のボイス")
                    }
                    // ギアVアタック
                    NavigationLink(destination: symphoViewGearv()) {
                        unitLabelMenu(imageSystemName: "music.quarternote.3", textBody: "ギアVアタック中の示唆")
                    }
                    // エンディング
                    NavigationLink(destination: symphoViewEnding()) {
                        unitLabelMenu(imageSystemName: "flag.checkered", textBody: "エンディング")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "シンフォギア 正義の歌")
                }
                // 設定推測グラフ
                NavigationLink(destination: symphoView95Ci(sympho: sympho)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4579")
//                    .popoverTip(tipVer220AddLink())
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "シンフォギア 正義の歌",
                screenClass: screenClass
            )
        }
        // 画面ログイベントの収集
//        .onAppear {
//            // Viewが表示されたタイミングでログを送信します
//            Analytics.logEvent(AnalyticsEventScreenView, parameters: [
//                AnalyticsParameterScreenName: "シンフォギア 正義の歌", // この画面の名前を識別できるように設定
//                AnalyticsParameterScreenClass: "symphoViewTop" // 通常はViewのクラス名（構造体名）を設定
//                // その他、この画面に関連するパラメータを追加できます
//            ])
//            print("Firebase Analytics: symphoViewTop appeared.") // デバッグ用にログ出力
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    HStack {
                        // //// データ読み出し
                        unitButtonLoadMemory(loadView: AnyView(symphoViewLoadMemory(
                            sympho: sympho,
                            symphoMemory1: symphoMemory1,
                            symphoMemory2: symphoMemory2,
                            symphoMemory3: symphoMemory3
                        )))
                        // //// データ保存
                        unitButtonSaveMemory(saveView: AnyView(symphoViewSaveMemory(
                            sympho: sympho,
                            symphoMemory1: symphoMemory1,
                            symphoMemory2: symphoMemory2,
                            symphoMemory3: symphoMemory3
                        )))
                    }
//                    .popoverTip(tipUnitButtonMemory())
                    unitButtonReset(isShowAlert: $isShowAlert, action: sympho.resetAll, message: "この機種のデータを全てリセットします")
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct symphoViewSaveMemory: View {
    @ObservedObject var sympho: Symphogear
    @ObservedObject var symphoMemory1: SymphogearMemory1
    @ObservedObject var symphoMemory2: SymphogearMemory2
    @ObservedObject var symphoMemory3: SymphogearMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "シンフォギア 正義の歌",
            selectedMemory: $sympho.selectedMemory,
            memoMemory1: $symphoMemory1.memo,
            dateDoubleMemory1: $symphoMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $symphoMemory2.memo,
            dateDoubleMemory2: $symphoMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $symphoMemory3.memo,
            dateDoubleMemory3: $symphoMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        symphoMemory1.gameArrayData = sympho.gameArrayData
        symphoMemory1.bonusArrayData = sympho.bonusArrayData
        symphoMemory1.triggerArrayData = sympho.triggerArrayData
        symphoMemory1.atCount = sympho.atCount
        symphoMemory1.czSaishuCount = sympho.czSaishuCount
        symphoMemory1.playGame = sympho.playGame
        symphoMemory1.screenCountNone = sympho.screenCountNone
        symphoMemory1.screenCountWhiteA = sympho.screenCountWhiteA
        symphoMemory1.screenCountWhiteB = sympho.screenCountWhiteB
        symphoMemory1.screenCountRedA = sympho.screenCountRedA
        symphoMemory1.screenCountRedB = sympho.screenCountRedB
        symphoMemory1.screenCountPurpleAB = sympho.screenCountPurpleAB
        symphoMemory1.screenCountPurpleC = sympho.screenCountPurpleC
        symphoMemory1.screenCountPurpleD = sympho.screenCountPurpleD
        symphoMemory1.screenCountPurpleE = sympho.screenCountPurpleE
        symphoMemory1.screenCountSilver = sympho.screenCountSilver
        symphoMemory1.screenCountGold = sympho.screenCountGold
        symphoMemory1.screenCountSum = sympho.screenCountSum
    }
    func saveMemory2() {
        symphoMemory2.gameArrayData = sympho.gameArrayData
        symphoMemory2.bonusArrayData = sympho.bonusArrayData
        symphoMemory2.triggerArrayData = sympho.triggerArrayData
        symphoMemory2.atCount = sympho.atCount
        symphoMemory2.czSaishuCount = sympho.czSaishuCount
        symphoMemory2.playGame = sympho.playGame
        symphoMemory2.screenCountNone = sympho.screenCountNone
        symphoMemory2.screenCountWhiteA = sympho.screenCountWhiteA
        symphoMemory2.screenCountWhiteB = sympho.screenCountWhiteB
        symphoMemory2.screenCountRedA = sympho.screenCountRedA
        symphoMemory2.screenCountRedB = sympho.screenCountRedB
        symphoMemory2.screenCountPurpleAB = sympho.screenCountPurpleAB
        symphoMemory2.screenCountPurpleC = sympho.screenCountPurpleC
        symphoMemory2.screenCountPurpleD = sympho.screenCountPurpleD
        symphoMemory2.screenCountPurpleE = sympho.screenCountPurpleE
        symphoMemory2.screenCountSilver = sympho.screenCountSilver
        symphoMemory2.screenCountGold = sympho.screenCountGold
        symphoMemory2.screenCountSum = sympho.screenCountSum
    }
    func saveMemory3() {
        symphoMemory3.gameArrayData = sympho.gameArrayData
        symphoMemory3.bonusArrayData = sympho.bonusArrayData
        symphoMemory3.triggerArrayData = sympho.triggerArrayData
        symphoMemory3.atCount = sympho.atCount
        symphoMemory3.czSaishuCount = sympho.czSaishuCount
        symphoMemory3.playGame = sympho.playGame
        symphoMemory3.screenCountNone = sympho.screenCountNone
        symphoMemory3.screenCountWhiteA = sympho.screenCountWhiteA
        symphoMemory3.screenCountWhiteB = sympho.screenCountWhiteB
        symphoMemory3.screenCountRedA = sympho.screenCountRedA
        symphoMemory3.screenCountRedB = sympho.screenCountRedB
        symphoMemory3.screenCountPurpleAB = sympho.screenCountPurpleAB
        symphoMemory3.screenCountPurpleC = sympho.screenCountPurpleC
        symphoMemory3.screenCountPurpleD = sympho.screenCountPurpleD
        symphoMemory3.screenCountPurpleE = sympho.screenCountPurpleE
        symphoMemory3.screenCountSilver = sympho.screenCountSilver
        symphoMemory3.screenCountGold = sympho.screenCountGold
        symphoMemory3.screenCountSum = sympho.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct symphoViewLoadMemory: View {
    @ObservedObject var sympho: Symphogear
    @ObservedObject var symphoMemory1: SymphogearMemory1
    @ObservedObject var symphoMemory2: SymphogearMemory2
    @ObservedObject var symphoMemory3: SymphogearMemory3
    @State var isShowLoadAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "シンフォギア 正義の歌",
            selectedMemory: $sympho.selectedMemory,
            memoMemory1: symphoMemory1.memo,
            dateDoubleMemory1: symphoMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: symphoMemory2.memo,
            dateDoubleMemory2: symphoMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: symphoMemory3.memo,
            dateDoubleMemory3: symphoMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        let memoryGameArray = decodeIntArray(from: symphoMemory1.gameArrayData)
        saveArray(memoryGameArray, forKey: sympho.gameArrayKey)
        let memoryBonusArray = decodeStringArray(from: symphoMemory1.bonusArrayData)
        saveArray(memoryBonusArray, forKey: sympho.bonusArrayKey)
        let memoryTriggerArray = decodeStringArray(from: symphoMemory1.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: sympho.triggerArrayKey)
//        sympho.gameArrayData = symphoMemory1.gameArrayData
//        sympho.bonusArrayData = symphoMemory1.bonusArrayData
//        sympho.triggerArrayData = symphoMemory1.triggerArrayData
        sympho.atCount = symphoMemory1.atCount
        sympho.czSaishuCount = symphoMemory1.czSaishuCount
        sympho.playGame = symphoMemory1.playGame
        sympho.screenCountNone = symphoMemory1.screenCountNone
        sympho.screenCountWhiteA = symphoMemory1.screenCountWhiteA
        sympho.screenCountWhiteB = symphoMemory1.screenCountWhiteB
        sympho.screenCountRedA = symphoMemory1.screenCountRedA
        sympho.screenCountRedB = symphoMemory1.screenCountRedB
        sympho.screenCountPurpleAB = symphoMemory1.screenCountPurpleAB
        sympho.screenCountPurpleC = symphoMemory1.screenCountPurpleC
        sympho.screenCountPurpleD = symphoMemory1.screenCountPurpleD
        sympho.screenCountPurpleE = symphoMemory1.screenCountPurpleE
        sympho.screenCountSilver = symphoMemory1.screenCountSilver
        sympho.screenCountGold = symphoMemory1.screenCountGold
        sympho.screenCountSum = symphoMemory1.screenCountSum
    }
    func loadMemory2() {
        let memoryGameArray = decodeIntArray(from: symphoMemory2.gameArrayData)
        saveArray(memoryGameArray, forKey: sympho.gameArrayKey)
        let memoryBonusArray = decodeStringArray(from: symphoMemory2.bonusArrayData)
        saveArray(memoryBonusArray, forKey: sympho.bonusArrayKey)
        let memoryTriggerArray = decodeStringArray(from: symphoMemory2.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: sympho.triggerArrayKey)
//        sympho.gameArrayData = symphoMemory2.gameArrayData
//        sympho.bonusArrayData = symphoMemory2.bonusArrayData
//        sympho.triggerArrayData = symphoMemory2.triggerArrayData
        sympho.atCount = symphoMemory2.atCount
        sympho.czSaishuCount = symphoMemory2.czSaishuCount
        sympho.playGame = symphoMemory2.playGame
        sympho.screenCountNone = symphoMemory2.screenCountNone
        sympho.screenCountWhiteA = symphoMemory2.screenCountWhiteA
        sympho.screenCountWhiteB = symphoMemory2.screenCountWhiteB
        sympho.screenCountRedA = symphoMemory2.screenCountRedA
        sympho.screenCountRedB = symphoMemory2.screenCountRedB
        sympho.screenCountPurpleAB = symphoMemory2.screenCountPurpleAB
        sympho.screenCountPurpleC = symphoMemory2.screenCountPurpleC
        sympho.screenCountPurpleD = symphoMemory2.screenCountPurpleD
        sympho.screenCountPurpleE = symphoMemory2.screenCountPurpleE
        sympho.screenCountSilver = symphoMemory2.screenCountSilver
        sympho.screenCountGold = symphoMemory2.screenCountGold
        sympho.screenCountSum = symphoMemory2.screenCountSum
    }
    func loadMemory3() {
        let memoryGameArray = decodeIntArray(from: symphoMemory3.gameArrayData)
        saveArray(memoryGameArray, forKey: sympho.gameArrayKey)
        let memoryBonusArray = decodeStringArray(from: symphoMemory3.bonusArrayData)
        saveArray(memoryBonusArray, forKey: sympho.bonusArrayKey)
        let memoryTriggerArray = decodeStringArray(from: symphoMemory3.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: sympho.triggerArrayKey)
//        sympho.gameArrayData = symphoMemory3.gameArrayData
//        sympho.bonusArrayData = symphoMemory3.bonusArrayData
//        sympho.triggerArrayData = symphoMemory3.triggerArrayData
        sympho.atCount = symphoMemory3.atCount
        sympho.czSaishuCount = symphoMemory3.czSaishuCount
        sympho.playGame = symphoMemory3.playGame
        sympho.screenCountNone = symphoMemory3.screenCountNone
        sympho.screenCountWhiteA = symphoMemory3.screenCountWhiteA
        sympho.screenCountWhiteB = symphoMemory3.screenCountWhiteB
        sympho.screenCountRedA = symphoMemory3.screenCountRedA
        sympho.screenCountRedB = symphoMemory3.screenCountRedB
        sympho.screenCountPurpleAB = symphoMemory3.screenCountPurpleAB
        sympho.screenCountPurpleC = symphoMemory3.screenCountPurpleC
        sympho.screenCountPurpleD = symphoMemory3.screenCountPurpleD
        sympho.screenCountPurpleE = symphoMemory3.screenCountPurpleE
        sympho.screenCountSilver = symphoMemory3.screenCountSilver
        sympho.screenCountGold = symphoMemory3.screenCountGold
        sympho.screenCountSum = symphoMemory3.screenCountSum
    }
}

#Preview {
    symphoViewTop()
}
