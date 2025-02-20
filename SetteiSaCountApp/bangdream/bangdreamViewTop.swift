//
//  bangdreamViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/06.
//

import SwiftUI
import TipKit

// ///////////////////////////
// 変数
// ///////////////////////////
class Bangdream: ObservableObject {
    // /////////////////////////
    // ST初当たり履歴
    // /////////////////////////
    // 選択肢の設定
    let selectListCycle = ["1周期", "2周期", "3周期", "4周期", "5周期", "6周期", "7周期", "8周期", "9周期", "10周期"]
    let selectListTrigger = ["周期", "直撃", "その他"]
    // 選択結果の設定
    @Published var selectedCycle: String = "1周期"
    @Published var selectedTrigger: String = "周期"
    @Published var selectedCycleNumber: Int = 1
    // //// 配列の設定
    // 周期配列
    let cycleArrayKey = "bangdreamCycleArrayKey"
    @AppStorage("bangdreamCycleArrayKey") var cycleArrayData: Data?
    // 当選契機配列
    let triggerArrayKey = "bangdreamTriggerArrayKey"
    @AppStorage("bangdreamTriggerArrayKey") var triggerArrayData: Data?
    // 消化周期数配列
    let cycleNumberArrayKey = "bangdreamCycleNumberArrayKey"
    @AppStorage("bangdreamCycleNumberArrayKey") var cycleNumberArrayData: Data?
    // //// ストーリーステージの消化数カウント用
    @AppStorage("bangdreamStoryCountSum") var storyCountSum: Int = 0
    @AppStorage("bangdreamCycleHitCountSum") var cycleHitCountSum: Int = 0
    @Published var cycleSum = 0
    @Published var chokugekiCountSum = 0
    
    // 1行削除
    func removeLastHistory() {
        arrayStringRemoveLast(arrayData: cycleArrayData, key: cycleArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayIntRemoveLast(arrayData: cycleNumberArrayData, key: cycleNumberArrayKey)
        cycleSum = arrayIntAllDataSum(arrayData: cycleNumberArrayData)
        chokugekiCountSum = arrayStringDataCount(arrayData: triggerArrayData, countString: "直撃")
        storyCountSum = (cycleSum - chokugekiCountSum) > 0 ? (cycleSum - chokugekiCountSum) : 0
        cycleHitCountSum = arrayStringDataCount(arrayData: triggerArrayData, countString: "周期")
        selectedCycle = "1周期"
        selectedTrigger = "周期"
        selectedCycleNumber = 1
    }
    
    // データ追加
    func addDataHistory() {
        arrayStringAddData(arrayData: cycleArrayData, addData: selectedCycle, key: cycleArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedTrigger, key: triggerArrayKey)
        // ストーリーステージの消化数を変数に代入
        if selectedCycle == selectListCycle[1] {
            selectedCycleNumber = 2
        } else if selectedCycle == selectListCycle[2] {
            selectedCycleNumber = 3
        } else if selectedCycle == selectListCycle[3] {
            selectedCycleNumber = 4
        } else if selectedCycle == selectListCycle[4] {
            selectedCycleNumber = 5
        } else if selectedCycle == selectListCycle[5] {
            selectedCycleNumber = 6
        } else if selectedCycle == selectListCycle[6] {
            selectedCycleNumber = 7
        } else if selectedCycle == selectListCycle[7] {
            selectedCycleNumber = 8
        } else if selectedCycle == selectListCycle[8] {
            selectedCycleNumber = 9
        } else if selectedCycle == selectListCycle[9] {
            selectedCycleNumber = 10
        } else {
            selectedCycleNumber = 1
        }
        arrayIntAddData(arrayData: cycleNumberArrayData, addData: selectedCycleNumber, key: cycleNumberArrayKey)
        cycleSum = arrayIntAllDataSum(arrayData: cycleNumberArrayData)
        chokugekiCountSum = arrayStringDataCount(arrayData: triggerArrayData, countString: "直撃")
        storyCountSum = (cycleSum - chokugekiCountSum) > 0 ? (cycleSum - chokugekiCountSum) : 0
        cycleHitCountSum = arrayStringDataCount(arrayData: triggerArrayData, countString: "周期")
        selectedCycle = "1周期"
        selectedTrigger = "周期"
        selectedCycleNumber = 1
    }
    
    func resetHistory() {
        arrayStringRemoveAll(arrayData: cycleArrayData, key: cycleArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayIntRemoveAll(arrayData: cycleNumberArrayData, key: cycleNumberArrayKey)
        storyCountSum = 0
        cycleSum = 0
        chokugekiCountSum = 0
        cycleHitCountSum = 0
        selectedCycle = "1周期"
        selectedTrigger = "周期"
        selectedCycleNumber = 1
        minusCheck = false
    }
    
    // /////////////////////////
    // ST終了画面
    // /////////////////////////
    @AppStorage("bangdreamScreenCurrentKeyword") var screenCurrentKeyword = ""
    let screenKeywordList = ["bangdreamScreenKasumi", "bangdreamScreenPhoto", "bangdreamScreenMiniChara", "bangdreamScreenRyo", "bangdreamScreenYu", "bangdreamScreenKiwami"]
    @AppStorage("bangdreamScreenCountKasumi") var screenCountKasumi = 0 {
        didSet {
            screenCountSum = countSum(screenCountKasumi, screenCountPhoto, screenCountMinichara, screenCountRyoStamp, screenCountYuStamp, screenCountKiwamiStamp)
        }
    }
        @AppStorage("bangdreamScreenCountPhoto") var screenCountPhoto = 0 {
            didSet {
                screenCountSum = countSum(screenCountKasumi, screenCountPhoto, screenCountMinichara, screenCountRyoStamp, screenCountYuStamp, screenCountKiwamiStamp)
            }
        }
            @AppStorage("bangdreamScreenCountMinichara") var screenCountMinichara = 0 {
                didSet {
                    screenCountSum = countSum(screenCountKasumi, screenCountPhoto, screenCountMinichara, screenCountRyoStamp, screenCountYuStamp, screenCountKiwamiStamp)
                }
            }
                @AppStorage("bangdreamScreenCountRyoStamp") var screenCountRyoStamp = 0 {
                    didSet {
                        screenCountSum = countSum(screenCountKasumi, screenCountPhoto, screenCountMinichara, screenCountRyoStamp, screenCountYuStamp, screenCountKiwamiStamp)
                    }
                }
                    @AppStorage("bangdreamScreenCountYuStamp") var screenCountYuStamp = 0 {
                        didSet {
                            screenCountSum = countSum(screenCountKasumi, screenCountPhoto, screenCountMinichara, screenCountRyoStamp, screenCountYuStamp, screenCountKiwamiStamp)
                        }
                    }
                        @AppStorage("bangdreamScreenCountKiwamiStamp") var screenCountKiwamiStamp = 0 {
                            didSet {
                                screenCountSum = countSum(screenCountKasumi, screenCountPhoto, screenCountMinichara, screenCountRyoStamp, screenCountYuStamp, screenCountKiwamiStamp)
                            }
                        }
    @AppStorage("bangdreamScreenCountSum") var screenCountSum = 0
    
    func resetScreen() {
        screenCountKasumi = 0
        screenCountPhoto = 0
        screenCountMinichara = 0
        screenCountRyoStamp = 0
        screenCountYuStamp = 0
        screenCountKiwamiStamp = 0
        minusCheck = false
    }
    
    // /////////////////////////
    // ピコアタック
    // /////////////////////////
    @AppStorage("bangdreamPicoAttackCountSingleWin") var picoAttackCountSingleWin = 0 {
        didSet {
            picoAttackCountSingleSum = countSum(picoAttackCountSingleWin, picoAttackCountSingleLose)
            picoAttackCountWinSum = countSum(picoAttackCountSingleWin, picoAttackCountMultiWin)
            picoAttackCountAllSum = picoAttackCountSingleSum + picoAttackCountMultiSum
        }
    }
        @AppStorage("bangdreamPicoAttackCountSingleLose") var picoAttackCountSingleLose = 0 {
            didSet {
                picoAttackCountSingleSum = countSum(picoAttackCountSingleWin, picoAttackCountSingleLose)
                picoAttackCountLoseSum = countSum(picoAttackCountSingleLose, picoAttackCountMultiLose)
                picoAttackCountAllSum = picoAttackCountSingleSum + picoAttackCountMultiSum
            }
        }
    @AppStorage("bangdreamPicoAttackCountSingleSum") var picoAttackCountSingleSum = 0
    @AppStorage("bangdreamPicoAttackCountMultiWin") var picoAttackCountMultiWin = 0 {
        didSet {
            picoAttackCountMultiSum = countSum(picoAttackCountMultiWin, picoAttackCountMultiLose)
            picoAttackCountWinSum = countSum(picoAttackCountSingleWin, picoAttackCountMultiWin)
            picoAttackCountAllSum = picoAttackCountSingleSum + picoAttackCountMultiSum
        }
    }
        @AppStorage("bangdreamPicoAttackCountMultiLose") var picoAttackCountMultiLose = 0 {
            didSet {
                picoAttackCountMultiSum = countSum(picoAttackCountMultiWin, picoAttackCountMultiLose)
                picoAttackCountLoseSum = countSum(picoAttackCountSingleLose, picoAttackCountMultiLose)
                picoAttackCountAllSum = picoAttackCountSingleSum + picoAttackCountMultiSum
            }
        }
    @AppStorage("bangdreamPicoAttackCountMultiSum") var picoAttackCountMultiSum = 0
    @AppStorage("bangdreamPicoAttackCountWinSum") var picoAttackCountWinSum = 0
    @AppStorage("bangdreamPicoAttackCountLoseSum") var picoAttackCountLoseSum = 0
    @AppStorage("bangdreamPicoAttackCountAllSum") var picoAttackCountAllSum = 0
    
    func resetPicoAttack() {
        picoAttackCountSingleWin = 0
        picoAttackCountSingleLose = 0
        picoAttackCountMultiWin = 0
        picoAttackCountMultiLose = 0
    }
    
    // /////////////////////////
    // 共通
    // /////////////////////////
    @AppStorage("bangdreamMinusCheck") var minusCheck: Bool = false
    @AppStorage("bangdreamSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetHistory()
        resetScreen()
        resetPicoAttack()
    }
}

// //// メモリー1
class BangdreamMemory1: ObservableObject {
    @AppStorage("bangdreamCycleArrayKeyMemory1") var cycleArrayData: Data?
    @AppStorage("bangdreamTriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("bangdreamCycleNumberArrayKeyMemory1") var cycleNumberArrayData: Data?
    @AppStorage("bangdreamStoryCountSumMemory1") var storyCountSum: Int = 0
    @AppStorage("bangdreamCycleHitCountSumMemory1") var cycleHitCountSum: Int = 0
    @AppStorage("bangdreamScreenCountKasumiMemory1") var screenCountKasumi = 0
    @AppStorage("bangdreamScreenCountPhotoMemory1") var screenCountPhoto = 0
    @AppStorage("bangdreamScreenCountMinicharaMemory1") var screenCountMinichara = 0
    @AppStorage("bangdreamScreenCountRyoStampMemory1") var screenCountRyoStamp = 0
    @AppStorage("bangdreamScreenCountYuStampMemory1") var screenCountYuStamp = 0
    @AppStorage("bangdreamScreenCountKiwamiStampMemory1") var screenCountKiwamiStamp = 0
    @AppStorage("bangdreamScreenCountSumMemory1") var screenCountSum = 0
    @AppStorage("bangdreamPicoAttackCountSingleWinMemory1") var picoAttackCountSingleWin = 0
    @AppStorage("bangdreamPicoAttackCountSingleLoseMemory1") var picoAttackCountSingleLose = 0
    @AppStorage("bangdreamPicoAttackCountSingleSumMemory1") var picoAttackCountSingleSum = 0
    @AppStorage("bangdreamPicoAttackCountMultiWinMemory1") var picoAttackCountMultiWin = 0
    @AppStorage("bangdreamPicoAttackCountMultiLoseMemory1") var picoAttackCountMultiLose = 0
    @AppStorage("bangdreamPicoAttackCountMultiSumMemory1") var picoAttackCountMultiSum = 0
    @AppStorage("bangdreamPicoAttackCountWinSumMemory1") var picoAttackCountWinSum = 0
    @AppStorage("bangdreamPicoAttackCountLoseSumMemory1") var picoAttackCountLoseSum = 0
    @AppStorage("bangdreamPicoAttackCountAllSumMemory1") var picoAttackCountAllSum = 0
    @AppStorage("bangdreamMemoMemory1") var memo = ""
    @AppStorage("bangdreamDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class BangdreamMemory2: ObservableObject {
    @AppStorage("bangdreamCycleArrayKeyMemory2") var cycleArrayData: Data?
    @AppStorage("bangdreamTriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("bangdreamCycleNumberArrayKeyMemory2") var cycleNumberArrayData: Data?
    @AppStorage("bangdreamStoryCountSumMemory2") var storyCountSum: Int = 0
    @AppStorage("bangdreamCycleHitCountSumMemory2") var cycleHitCountSum: Int = 0
    @AppStorage("bangdreamScreenCountKasumiMemory2") var screenCountKasumi = 0
    @AppStorage("bangdreamScreenCountPhotoMemory2") var screenCountPhoto = 0
    @AppStorage("bangdreamScreenCountMinicharaMemory2") var screenCountMinichara = 0
    @AppStorage("bangdreamScreenCountRyoStampMemory2") var screenCountRyoStamp = 0
    @AppStorage("bangdreamScreenCountYuStampMemory2") var screenCountYuStamp = 0
    @AppStorage("bangdreamScreenCountKiwamiStampMemory2") var screenCountKiwamiStamp = 0
    @AppStorage("bangdreamScreenCountSumMemory2") var screenCountSum = 0
    @AppStorage("bangdreamPicoAttackCountSingleWinMemory2") var picoAttackCountSingleWin = 0
    @AppStorage("bangdreamPicoAttackCountSingleLoseMemory2") var picoAttackCountSingleLose = 0
    @AppStorage("bangdreamPicoAttackCountSingleSumMemory2") var picoAttackCountSingleSum = 0
    @AppStorage("bangdreamPicoAttackCountMultiWinMemory2") var picoAttackCountMultiWin = 0
    @AppStorage("bangdreamPicoAttackCountMultiLoseMemory2") var picoAttackCountMultiLose = 0
    @AppStorage("bangdreamPicoAttackCountMultiSumMemory2") var picoAttackCountMultiSum = 0
    @AppStorage("bangdreamPicoAttackCountWinSumMemory2") var picoAttackCountWinSum = 0
    @AppStorage("bangdreamPicoAttackCountLoseSumMemory2") var picoAttackCountLoseSum = 0
    @AppStorage("bangdreamPicoAttackCountAllSumMemory2") var picoAttackCountAllSum = 0
    @AppStorage("bangdreamMemoMemory2") var memo = ""
    @AppStorage("bangdreamDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class BangdreamMemory3: ObservableObject {
    @AppStorage("bangdreamCycleArrayKeyMemory3") var cycleArrayData: Data?
    @AppStorage("bangdreamTriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("bangdreamCycleNumberArrayKeyMemory3") var cycleNumberArrayData: Data?
    @AppStorage("bangdreamStoryCountSumMemory3") var storyCountSum: Int = 0
    @AppStorage("bangdreamCycleHitCountSumMemory3") var cycleHitCountSum: Int = 0
    @AppStorage("bangdreamScreenCountKasumiMemory3") var screenCountKasumi = 0
    @AppStorage("bangdreamScreenCountPhotoMemory3") var screenCountPhoto = 0
    @AppStorage("bangdreamScreenCountMinicharaMemory3") var screenCountMinichara = 0
    @AppStorage("bangdreamScreenCountRyoStampMemory3") var screenCountRyoStamp = 0
    @AppStorage("bangdreamScreenCountYuStampMemory3") var screenCountYuStamp = 0
    @AppStorage("bangdreamScreenCountKiwamiStampMemory3") var screenCountKiwamiStamp = 0
    @AppStorage("bangdreamScreenCountSumMemory3") var screenCountSum = 0
    @AppStorage("bangdreamPicoAttackCountSingleWinMemory3") var picoAttackCountSingleWin = 0
    @AppStorage("bangdreamPicoAttackCountSingleLoseMemory3") var picoAttackCountSingleLose = 0
    @AppStorage("bangdreamPicoAttackCountSingleSumMemory3") var picoAttackCountSingleSum = 0
    @AppStorage("bangdreamPicoAttackCountMultiWinMemory3") var picoAttackCountMultiWin = 0
    @AppStorage("bangdreamPicoAttackCountMultiLoseMemory3") var picoAttackCountMultiLose = 0
    @AppStorage("bangdreamPicoAttackCountMultiSumMemory3") var picoAttackCountMultiSum = 0
    @AppStorage("bangdreamPicoAttackCountWinSumMemory3") var picoAttackCountWinSum = 0
    @AppStorage("bangdreamPicoAttackCountLoseSumMemory3") var picoAttackCountLoseSum = 0
    @AppStorage("bangdreamPicoAttackCountAllSumMemory3") var picoAttackCountAllSum = 0
    @AppStorage("bangdreamMemoMemory3") var memo = ""
    @AppStorage("bangdreamDateMemory3") var dateDouble = 0.0
}

struct bangdreamViewTop: View {
    @ObservedObject var bangdream = Bangdream()
    @State var isshowalert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // ST初当たり履歴
                    NavigationLink(destination: bangdreamViewHistory()) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "ST初当たり履歴")
                    }
                    // ST終了画面
                    NavigationLink(destination: bangdreamViewScreen()) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "ST終了画面")
                    }
                    // ピコアタック
                    NavigationLink(destination: bangdreamViewPicoAttack()) {
                        unitLabelMenu(imageSystemName: "figure.boxing", textBody: "ピコアタック")
                    }
                    // 隠れ凪
                    NavigationLink(destination: commonViewKakureNagi()) {
                        unitLabelMenu(imageSystemName: "bubble", textBody: "隠れ凪")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "バンドリ!")
                }
                // 設定推測グラフ
                NavigationLink(destination: bangdreamView95Ci()) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4641")
                    .popoverTip(tipVer220AddLink())
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    HStack {
                        // データ読出し
                        unitButtonLoadMemory(loadView: AnyView(bangdreamSubViewLoadMemory()))
                        // データ保存
                        unitButtonSaveMemory(saveView: AnyView(bangdreamSubViewSaveMemory()))
                    }
                    .popoverTip(tipUnitButtonMemory())
                    // データリセット
                    unitButtonReset(isShowAlert: $isshowalert, action: bangdream.resetAll, message: "この機種のデータを全てリセットします")
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct bangdreamSubViewSaveMemory: View {
    @ObservedObject var bangdream = Bangdream()
    @ObservedObject var bangdreamMemory1 = BangdreamMemory1()
    @ObservedObject var bangdreamMemory2 = BangdreamMemory2()
    @ObservedObject var bangdreamMemory3 = BangdreamMemory3()
    @State var isShowSaveAlert: Bool = false
    var body: some View {
        unitViewSaveMemory(
            machineName: "バンドリ!",
            selectedMemory: $bangdream.selectedMemory,
            memoMemory1: $bangdreamMemory1.memo,
            dateDoubleMemory1: $bangdreamMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $bangdreamMemory2.memo,
            dateDoubleMemory2: $bangdreamMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $bangdreamMemory3.memo,
            dateDoubleMemory3: $bangdreamMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        bangdreamMemory1.cycleArrayData = bangdream.cycleArrayData
        bangdreamMemory1.triggerArrayData = bangdream.triggerArrayData
        bangdreamMemory1.cycleNumberArrayData = bangdream.cycleNumberArrayData
        bangdreamMemory1.storyCountSum = bangdream.storyCountSum
        bangdreamMemory1.cycleHitCountSum = bangdream.cycleHitCountSum
        bangdreamMemory1.screenCountKasumi = bangdream.screenCountKasumi
        bangdreamMemory1.screenCountPhoto = bangdream.screenCountPhoto
        bangdreamMemory1.screenCountMinichara = bangdream.screenCountMinichara
        bangdreamMemory1.screenCountRyoStamp = bangdream.screenCountRyoStamp
        bangdreamMemory1.screenCountYuStamp = bangdream.screenCountYuStamp
        bangdreamMemory1.screenCountKiwamiStamp = bangdream.screenCountKiwamiStamp
        bangdreamMemory1.screenCountSum = bangdream.screenCountSum
        bangdreamMemory1.picoAttackCountSingleWin = bangdream.picoAttackCountSingleWin
        bangdreamMemory1.picoAttackCountSingleLose = bangdream.picoAttackCountSingleLose
        bangdreamMemory1.picoAttackCountSingleSum = bangdream.picoAttackCountSingleSum
        bangdreamMemory1.picoAttackCountMultiWin = bangdream.picoAttackCountMultiWin
        bangdreamMemory1.picoAttackCountMultiLose = bangdream.picoAttackCountMultiLose
        bangdreamMemory1.picoAttackCountMultiSum = bangdream.picoAttackCountMultiSum
        bangdreamMemory1.picoAttackCountWinSum = bangdream.picoAttackCountWinSum
        bangdreamMemory1.picoAttackCountLoseSum = bangdream.picoAttackCountLoseSum
        bangdreamMemory1.picoAttackCountAllSum = bangdream.picoAttackCountAllSum
    }
    func saveMemory2() {
        bangdreamMemory2.cycleArrayData = bangdream.cycleArrayData
        bangdreamMemory2.triggerArrayData = bangdream.triggerArrayData
        bangdreamMemory2.cycleNumberArrayData = bangdream.cycleNumberArrayData
        bangdreamMemory2.storyCountSum = bangdream.storyCountSum
        bangdreamMemory2.cycleHitCountSum = bangdream.cycleHitCountSum
        bangdreamMemory2.screenCountKasumi = bangdream.screenCountKasumi
        bangdreamMemory2.screenCountPhoto = bangdream.screenCountPhoto
        bangdreamMemory2.screenCountMinichara = bangdream.screenCountMinichara
        bangdreamMemory2.screenCountRyoStamp = bangdream.screenCountRyoStamp
        bangdreamMemory2.screenCountYuStamp = bangdream.screenCountYuStamp
        bangdreamMemory2.screenCountKiwamiStamp = bangdream.screenCountKiwamiStamp
        bangdreamMemory2.screenCountSum = bangdream.screenCountSum
        bangdreamMemory2.picoAttackCountSingleWin = bangdream.picoAttackCountSingleWin
        bangdreamMemory2.picoAttackCountSingleLose = bangdream.picoAttackCountSingleLose
        bangdreamMemory2.picoAttackCountSingleSum = bangdream.picoAttackCountSingleSum
        bangdreamMemory2.picoAttackCountMultiWin = bangdream.picoAttackCountMultiWin
        bangdreamMemory2.picoAttackCountMultiLose = bangdream.picoAttackCountMultiLose
        bangdreamMemory2.picoAttackCountMultiSum = bangdream.picoAttackCountMultiSum
        bangdreamMemory2.picoAttackCountWinSum = bangdream.picoAttackCountWinSum
        bangdreamMemory2.picoAttackCountLoseSum = bangdream.picoAttackCountLoseSum
        bangdreamMemory2.picoAttackCountAllSum = bangdream.picoAttackCountAllSum
    }
    func saveMemory3() {
        bangdreamMemory3.cycleArrayData = bangdream.cycleArrayData
        bangdreamMemory3.triggerArrayData = bangdream.triggerArrayData
        bangdreamMemory3.cycleNumberArrayData = bangdream.cycleNumberArrayData
        bangdreamMemory3.storyCountSum = bangdream.storyCountSum
        bangdreamMemory3.cycleHitCountSum = bangdream.cycleHitCountSum
        bangdreamMemory3.screenCountKasumi = bangdream.screenCountKasumi
        bangdreamMemory3.screenCountPhoto = bangdream.screenCountPhoto
        bangdreamMemory3.screenCountMinichara = bangdream.screenCountMinichara
        bangdreamMemory3.screenCountRyoStamp = bangdream.screenCountRyoStamp
        bangdreamMemory3.screenCountYuStamp = bangdream.screenCountYuStamp
        bangdreamMemory3.screenCountKiwamiStamp = bangdream.screenCountKiwamiStamp
        bangdreamMemory3.screenCountSum = bangdream.screenCountSum
        bangdreamMemory3.picoAttackCountSingleWin = bangdream.picoAttackCountSingleWin
        bangdreamMemory3.picoAttackCountSingleLose = bangdream.picoAttackCountSingleLose
        bangdreamMemory3.picoAttackCountSingleSum = bangdream.picoAttackCountSingleSum
        bangdreamMemory3.picoAttackCountMultiWin = bangdream.picoAttackCountMultiWin
        bangdreamMemory3.picoAttackCountMultiLose = bangdream.picoAttackCountMultiLose
        bangdreamMemory3.picoAttackCountMultiSum = bangdream.picoAttackCountMultiSum
        bangdreamMemory3.picoAttackCountWinSum = bangdream.picoAttackCountWinSum
        bangdreamMemory3.picoAttackCountLoseSum = bangdream.picoAttackCountLoseSum
        bangdreamMemory3.picoAttackCountAllSum = bangdream.picoAttackCountAllSum
    }
}

// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct bangdreamSubViewLoadMemory: View {
    @ObservedObject var bangdream = Bangdream()
    @ObservedObject var bangdreamMemory1 = BangdreamMemory1()
    @ObservedObject var bangdreamMemory2 = BangdreamMemory2()
    @ObservedObject var bangdreamMemory3 = BangdreamMemory3()
    @State var isShowLoadAlert: Bool = false
    var body: some View {
        unitViewLoadMemory(
            machineName: "バンドリ!",
            selectedMemory: $bangdream.selectedMemory,
            memoMemory1: bangdreamMemory1.memo,
            dateDoubleMemory1: bangdreamMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: bangdreamMemory2.memo,
            dateDoubleMemory2: bangdreamMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: bangdreamMemory3.memo,
            dateDoubleMemory3: bangdreamMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        bangdream.cycleArrayData = bangdreamMemory1.cycleArrayData
        bangdream.triggerArrayData = bangdreamMemory1.triggerArrayData
        bangdream.cycleNumberArrayData = bangdreamMemory1.cycleNumberArrayData
        bangdream.storyCountSum = bangdreamMemory1.storyCountSum
        bangdream.cycleHitCountSum = bangdreamMemory1.cycleHitCountSum
        bangdream.screenCountKasumi = bangdreamMemory1.screenCountKasumi
        bangdream.screenCountPhoto = bangdreamMemory1.screenCountPhoto
        bangdream.screenCountMinichara = bangdreamMemory1.screenCountMinichara
        bangdream.screenCountRyoStamp = bangdreamMemory1.screenCountRyoStamp
        bangdream.screenCountYuStamp = bangdreamMemory1.screenCountYuStamp
        bangdream.screenCountKiwamiStamp = bangdreamMemory1.screenCountKiwamiStamp
        bangdream.screenCountSum = bangdreamMemory1.screenCountSum
        bangdream.picoAttackCountSingleWin = bangdreamMemory1.picoAttackCountSingleWin
        bangdream.picoAttackCountSingleLose = bangdreamMemory1.picoAttackCountSingleLose
        bangdream.picoAttackCountSingleSum = bangdreamMemory1.picoAttackCountSingleSum
        bangdream.picoAttackCountMultiWin = bangdreamMemory1.picoAttackCountMultiWin
        bangdream.picoAttackCountMultiLose = bangdreamMemory1.picoAttackCountMultiLose
        bangdream.picoAttackCountMultiSum = bangdreamMemory1.picoAttackCountMultiSum
        bangdream.picoAttackCountWinSum = bangdreamMemory1.picoAttackCountWinSum
        bangdream.picoAttackCountLoseSum = bangdreamMemory1.picoAttackCountLoseSum
        bangdream.picoAttackCountAllSum = bangdreamMemory1.picoAttackCountAllSum
    }
    func loadMemory2() {
        bangdream.cycleArrayData = bangdreamMemory2.cycleArrayData
        bangdream.triggerArrayData = bangdreamMemory2.triggerArrayData
        bangdream.cycleNumberArrayData = bangdreamMemory2.cycleNumberArrayData
        bangdream.storyCountSum = bangdreamMemory2.storyCountSum
        bangdream.cycleHitCountSum = bangdreamMemory2.cycleHitCountSum
        bangdream.screenCountKasumi = bangdreamMemory2.screenCountKasumi
        bangdream.screenCountPhoto = bangdreamMemory2.screenCountPhoto
        bangdream.screenCountMinichara = bangdreamMemory2.screenCountMinichara
        bangdream.screenCountRyoStamp = bangdreamMemory2.screenCountRyoStamp
        bangdream.screenCountYuStamp = bangdreamMemory2.screenCountYuStamp
        bangdream.screenCountKiwamiStamp = bangdreamMemory2.screenCountKiwamiStamp
        bangdream.screenCountSum = bangdreamMemory2.screenCountSum
        bangdream.picoAttackCountSingleWin = bangdreamMemory2.picoAttackCountSingleWin
        bangdream.picoAttackCountSingleLose = bangdreamMemory2.picoAttackCountSingleLose
        bangdream.picoAttackCountSingleSum = bangdreamMemory2.picoAttackCountSingleSum
        bangdream.picoAttackCountMultiWin = bangdreamMemory2.picoAttackCountMultiWin
        bangdream.picoAttackCountMultiLose = bangdreamMemory2.picoAttackCountMultiLose
        bangdream.picoAttackCountMultiSum = bangdreamMemory2.picoAttackCountMultiSum
        bangdream.picoAttackCountWinSum = bangdreamMemory2.picoAttackCountWinSum
        bangdream.picoAttackCountLoseSum = bangdreamMemory2.picoAttackCountLoseSum
        bangdream.picoAttackCountAllSum = bangdreamMemory2.picoAttackCountAllSum
    }
    func loadMemory3() {
        bangdream.cycleArrayData = bangdreamMemory3.cycleArrayData
        bangdream.triggerArrayData = bangdreamMemory3.triggerArrayData
        bangdream.cycleNumberArrayData = bangdreamMemory3.cycleNumberArrayData
        bangdream.storyCountSum = bangdreamMemory3.storyCountSum
        bangdream.cycleHitCountSum = bangdreamMemory3.cycleHitCountSum
        bangdream.screenCountKasumi = bangdreamMemory3.screenCountKasumi
        bangdream.screenCountPhoto = bangdreamMemory3.screenCountPhoto
        bangdream.screenCountMinichara = bangdreamMemory3.screenCountMinichara
        bangdream.screenCountRyoStamp = bangdreamMemory3.screenCountRyoStamp
        bangdream.screenCountYuStamp = bangdreamMemory3.screenCountYuStamp
        bangdream.screenCountKiwamiStamp = bangdreamMemory3.screenCountKiwamiStamp
        bangdream.screenCountSum = bangdreamMemory3.screenCountSum
        bangdream.picoAttackCountSingleWin = bangdreamMemory3.picoAttackCountSingleWin
        bangdream.picoAttackCountSingleLose = bangdreamMemory3.picoAttackCountSingleLose
        bangdream.picoAttackCountSingleSum = bangdreamMemory3.picoAttackCountSingleSum
        bangdream.picoAttackCountMultiWin = bangdreamMemory3.picoAttackCountMultiWin
        bangdream.picoAttackCountMultiLose = bangdreamMemory3.picoAttackCountMultiLose
        bangdream.picoAttackCountMultiSum = bangdreamMemory3.picoAttackCountMultiSum
        bangdream.picoAttackCountWinSum = bangdreamMemory3.picoAttackCountWinSum
        bangdream.picoAttackCountLoseSum = bangdreamMemory3.picoAttackCountLoseSum
        bangdream.picoAttackCountAllSum = bangdreamMemory3.picoAttackCountAllSum
    }
}



#Preview {
    bangdreamViewTop()
}
