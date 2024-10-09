//
//  symphoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/14.
//

import SwiftUI
import TipKit

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
    
    func resetAll() {
        resetHistory()
        resetScreen()
        resetVoice()
    }
}

struct symphoViewTop: View {
    @ObservedObject var sympho = Symphogear()
    @State var isShowAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // AT初当り履歴
                    NavigationLink(destination: symphoViewHistory()) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "AT初当り履歴")
                    }
                    // AT終了画面
                    NavigationLink(destination: symphoViewScreen()) {
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
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButtonReset(isShowAlert: $isShowAlert, action: sympho.resetAll, message: "この機種のデータを全てリセットします")
            }
        }
    }
}

#Preview {
    symphoViewTop()
}
