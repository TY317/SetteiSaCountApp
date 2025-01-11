//
//  acceleratorViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/03.
//

import SwiftUI


// ///////////////////////
// 変数
// ///////////////////////
class Accelerator: ObservableObject {
    // ////////////////////////
    // CZ、AT履歴
    // ////////////////////////
    // //// 対応チャンス目カウント用
    @AppStorage("acceleratorChanceCountLose") var chanceCountLose = 0 {
        didSet {
            chanceCountSum = countSum(chanceCountLose, chanceCountWinAccelerator, chanceCountWinLastorder)
            chanceCountWinSum = countSum(chanceCountWinAccelerator, chanceCountWinLastorder)
        }
    }
        @AppStorage("acceleratorChanceCountWinAccelerator") var chanceCountWinAccelerator = 0 {
            didSet {
                chanceCountSum = countSum(chanceCountLose, chanceCountWinAccelerator, chanceCountWinLastorder)
                chanceCountWinSum = countSum(chanceCountWinAccelerator, chanceCountWinLastorder)
            }
        }
            @AppStorage("acceleratorChanceCountWinLastorder") var chanceCountWinLastorder = 0 {
                didSet {
                    chanceCountSum = countSum(chanceCountLose, chanceCountWinAccelerator, chanceCountWinLastorder)
                    chanceCountWinSum = countSum(chanceCountWinAccelerator, chanceCountWinLastorder)
                }
            }
    @AppStorage("acceleratorChanceCountSum") var chanceCountSum = 0
    @AppStorage("acceleratorChanceCountWinSum") var chanceCountWinSum = 0
    
    // //// 履歴メモ用
    // 選択肢の設定
    let selectListCz = [
        "一方通行",
        "打ち止め",
        "一通・打止",
        "直AT"
    ]
    let selectListResultCz = [
        "当選",
        "ハズレ"
    ]
    let selectListResultAt = [
        "当選"
    ]
    // 選択結果の設定
    @Published var inputGame = 0
    @Published var selectedCz = "一方通行"
    @Published var selectedResultCz = "当選"
    @Published var selectedResultAt = "当選"
    @Published var selectedResult = "当選"
    // ゲーム数配列
    let gameArrayKey = "acceleratorGameArrayKey"
    @AppStorage("acceleratorGameArrayKey") var gameArrayData: Data?
    // CZ種類配列
    let czArrayKey = "acceleratorCzArrayKey"
    @AppStorage("acceleratorCzArrayKey") var czArrayData: Data?
    // 結果配列
    let resultArrayKey = "acceleratorResultArrayKey"
    @AppStorage("acceleratorResultArrayKey") var resultArrayData: Data?
    // 結果集計用
    @AppStorage("acceleratorPlayGameSum") var playGameSum: Int = 0
    @AppStorage("acceleratorCzCount") var czCount = 0
    @AppStorage("acceleratorAtCount") var atCount = 0
    // データ追加
    func addDataHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: czArrayData, addData: selectedCz, key: czArrayKey)
        arrayStringAddData(arrayData: resultArrayData, addData: selectedResult, key: resultArrayKey)
        playGameSum = arraySumPlayGameResetWordOne(
            gameArrayData: gameArrayData,
            bonusArrayData: resultArrayData,
            resetWord: selectListResultAt[0]
        )
        atCount = arrayStringDataCount(arrayData: resultArrayData, countString: selectListResultAt[0])
        let directAtCount = arrayStringDataCount(arrayData: czArrayData, countString: selectListCz[3])
        czCount = arrayIntAllDataCount(arrayData: gameArrayData) - directAtCount
    }
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: czArrayData, key: czArrayKey)
        arrayStringRemoveLast(arrayData: resultArrayData, key: resultArrayKey)
        playGameSum = arraySumPlayGameResetWordOne(
            gameArrayData: gameArrayData,
            bonusArrayData: resultArrayData,
            resetWord: selectListResultAt[0]
        )
        atCount = arrayStringDataCount(arrayData: resultArrayData, countString: selectListResultAt[0])
        let directAtCount = arrayStringDataCount(arrayData: czArrayData, countString: selectListCz[3])
        czCount = arrayIntAllDataCount(arrayData: gameArrayData) - directAtCount
    }
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: czArrayData, key: czArrayKey)
        arrayStringRemoveAll(arrayData: resultArrayData, key: resultArrayKey)
        playGameSum = arraySumPlayGameResetWordOne(
            gameArrayData: gameArrayData,
            bonusArrayData: resultArrayData,
            resetWord: selectListResultAt[0]
        )
        atCount = arrayStringDataCount(arrayData: resultArrayData, countString: selectListResultAt[0])
        let directAtCount = arrayStringDataCount(arrayData: czArrayData, countString: selectListCz[3])
        czCount = arrayIntAllDataCount(arrayData: gameArrayData) - directAtCount
        chanceCountLose = 0
        chanceCountWinAccelerator = 0
        chanceCountWinLastorder = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // ビッグ、AT終了画面
    // ////////////////////////
    let screenKeywordList = [
        "acceleratorScreen5person",
        "acceleratorScreenNight",
        "acceleratorScreenUp",
        "acceleratorScreenDate",
        "acceleratorScreenKanetsuki",
        "acceleratorScreenMizugi",
        "acceleratorScreenNekomimi",
        "acceleratorScreenHelloween",
        "acceleratorScreenGold"
    ]
    @AppStorage("acceleratorScreenCurrentKeyword") var screenCurrentKeyword: String = ""
    @AppStorage("acceleratorScreenCountDefault") var screenCountDefault = 0 {
        didSet {
            screenCountSum = countSum(screenCountDefault, screenCountKeizoku, screenCountHighJaku, screenCountHighKyo, screenCountGusuSisa, screenCountGusuFix, screenCountOver2, screenCountOver4)
        }
    }
        @AppStorage("acceleratorScreenCountKeizoku") var screenCountKeizoku = 0 {
            didSet {
                screenCountSum = countSum(screenCountDefault, screenCountKeizoku, screenCountHighJaku, screenCountHighKyo, screenCountGusuSisa, screenCountGusuFix, screenCountOver2, screenCountOver4)
            }
        }
            @AppStorage("acceleratorScreenCountHighJaku") var screenCountHighJaku = 0 {
                didSet {
                    screenCountSum = countSum(screenCountDefault, screenCountKeizoku, screenCountHighJaku, screenCountHighKyo, screenCountGusuSisa, screenCountGusuFix, screenCountOver2, screenCountOver4)
                }
            }
                @AppStorage("acceleratorScreenCountHighKyo") var screenCountHighKyo = 0 {
                    didSet {
                        screenCountSum = countSum(screenCountDefault, screenCountKeizoku, screenCountHighJaku, screenCountHighKyo, screenCountGusuSisa, screenCountGusuFix, screenCountOver2, screenCountOver4)
                    }
                }
                    @AppStorage("acceleratorScreenCountGusuSisa") var screenCountGusuSisa = 0 {
                        didSet {
                            screenCountSum = countSum(screenCountDefault, screenCountKeizoku, screenCountHighJaku, screenCountHighKyo, screenCountGusuSisa, screenCountGusuFix, screenCountOver2, screenCountOver4)
                        }
                    }
                        @AppStorage("acceleratorScreenCountGusuFix") var screenCountGusuFix = 0 {
                            didSet {
                                screenCountSum = countSum(screenCountDefault, screenCountKeizoku, screenCountHighJaku, screenCountHighKyo, screenCountGusuSisa, screenCountGusuFix, screenCountOver2, screenCountOver4)
                            }
                        }
                            @AppStorage("acceleratorScreenCountOver2") var screenCountOver2 = 0 {
                                didSet {
                                    screenCountSum = countSum(screenCountDefault, screenCountKeizoku, screenCountHighJaku, screenCountHighKyo, screenCountGusuSisa, screenCountGusuFix, screenCountOver2, screenCountOver4)
                                }
                            }
                                @AppStorage("acceleratorScreenCountOver4") var screenCountOver4 = 0 {
                                    didSet {
                                        screenCountSum = countSum(screenCountDefault, screenCountKeizoku, screenCountHighJaku, screenCountHighKyo, screenCountGusuSisa, screenCountGusuFix, screenCountOver2, screenCountOver4)
                                    }
                                }
    @AppStorage("acceleratorScreenCountSum") var screenCountSum = 0
    
    func resetScreen() {
        screenCurrentKeyword = ""
        screenCountDefault = 0
        screenCountKeizoku = 0
        screenCountHighJaku = 0
        screenCountHighKyo = 0
        screenCountGusuSisa = 0
        screenCountGusuFix = 0
        screenCountOver2 = 0
        screenCountOver4 = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("acceleratorMinusCheck") var minusCheck: Bool = false
    @AppStorage("acceleratorSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetHistory()
        resetScreen()
    }
}


// //// メモリー1
class AcceleratorMemory1: ObservableObject {
    @AppStorage("acceleratorChanceCountLoseMemory1") var chanceCountLose = 0
    @AppStorage("acceleratorChanceCountWinAcceleratorMemory1") var chanceCountWinAccelerator = 0
    @AppStorage("acceleratorChanceCountWinLastorderMemory1") var chanceCountWinLastorder = 0
    @AppStorage("acceleratorChanceCountSumMemory1") var chanceCountSum = 0
    @AppStorage("acceleratorChanceCountWinSumMemory1") var chanceCountWinSum = 0
    @AppStorage("acceleratorGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("acceleratorCzArrayKeyMemory1") var czArrayData: Data?
    @AppStorage("acceleratorResultArrayKeyMemory1") var resultArrayData: Data?
    @AppStorage("acceleratorPlayGameSumMemory1") var playGameSum: Int = 0
    @AppStorage("acceleratorCzCountMemory1") var czCount = 0
    @AppStorage("acceleratorAtCountMemory1") var atCount = 0
    @AppStorage("acceleratorScreenCountDefaultMemory1") var screenCountDefault = 0
    @AppStorage("acceleratorScreenCountKeizokuMemory1") var screenCountKeizoku = 0
    @AppStorage("acceleratorScreenCountHighJakuMemory1") var screenCountHighJaku = 0
    @AppStorage("acceleratorScreenCountHighKyoMemory1") var screenCountHighKyo = 0
    @AppStorage("acceleratorScreenCountGusuSisaMemory1") var screenCountGusuSisa = 0
    @AppStorage("acceleratorScreenCountGusuFixMemory1") var screenCountGusuFix = 0
    @AppStorage("acceleratorScreenCountOver2Memory1") var screenCountOver2 = 0
    @AppStorage("acceleratorScreenCountOver4Memory1") var screenCountOver4 = 0
    @AppStorage("acceleratorScreenCountSumMemory1") var screenCountSum = 0
    @AppStorage("acceleratorMemoMemory1") var memo = ""
    @AppStorage("acceleratorDateMemory1") var dateDouble = 0.0
}


// //// メモリー2
class AcceleratorMemory2: ObservableObject {
    @AppStorage("acceleratorChanceCountLoseMemory2") var chanceCountLose = 0
    @AppStorage("acceleratorChanceCountWinAcceleratorMemory2") var chanceCountWinAccelerator = 0
    @AppStorage("acceleratorChanceCountWinLastorderMemory2") var chanceCountWinLastorder = 0
    @AppStorage("acceleratorChanceCountSumMemory2") var chanceCountSum = 0
    @AppStorage("acceleratorChanceCountWinSumMemory2") var chanceCountWinSum = 0
    @AppStorage("acceleratorGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("acceleratorCzArrayKeyMemory2") var czArrayData: Data?
    @AppStorage("acceleratorResultArrayKeyMemory2") var resultArrayData: Data?
    @AppStorage("acceleratorPlayGameSumMemory2") var playGameSum: Int = 0
    @AppStorage("acceleratorCzCountMemory2") var czCount = 0
    @AppStorage("acceleratorAtCountMemory2") var atCount = 0
    @AppStorage("acceleratorScreenCountDefaultMemory2") var screenCountDefault = 0
    @AppStorage("acceleratorScreenCountKeizokuMemory2") var screenCountKeizoku = 0
    @AppStorage("acceleratorScreenCountHighJakuMemory2") var screenCountHighJaku = 0
    @AppStorage("acceleratorScreenCountHighKyoMemory2") var screenCountHighKyo = 0
    @AppStorage("acceleratorScreenCountGusuSisaMemory2") var screenCountGusuSisa = 0
    @AppStorage("acceleratorScreenCountGusuFixMemory2") var screenCountGusuFix = 0
    @AppStorage("acceleratorScreenCountOver2Memory2") var screenCountOver2 = 0
    @AppStorage("acceleratorScreenCountOver4Memory2") var screenCountOver4 = 0
    @AppStorage("acceleratorScreenCountSumMemory2") var screenCountSum = 0
    @AppStorage("acceleratorMemoMemory2") var memo = ""
    @AppStorage("acceleratorDateMemory2") var dateDouble = 0.0
}


// //// メモリー3
class AcceleratorMemory3: ObservableObject {
    @AppStorage("acceleratorChanceCountLoseMemory3") var chanceCountLose = 0
    @AppStorage("acceleratorChanceCountWinAcceleratorMemory3") var chanceCountWinAccelerator = 0
    @AppStorage("acceleratorChanceCountWinLastorderMemory3") var chanceCountWinLastorder = 0
    @AppStorage("acceleratorChanceCountSumMemory3") var chanceCountSum = 0
    @AppStorage("acceleratorChanceCountWinSumMemory3") var chanceCountWinSum = 0
    @AppStorage("acceleratorGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("acceleratorCzArrayKeyMemory3") var czArrayData: Data?
    @AppStorage("acceleratorResultArrayKeyMemory3") var resultArrayData: Data?
    @AppStorage("acceleratorPlayGameSumMemory3") var playGameSum: Int = 0
    @AppStorage("acceleratorCzCountMemory3") var czCount = 0
    @AppStorage("acceleratorAtCountMemory3") var atCount = 0
    @AppStorage("acceleratorScreenCountDefaultMemory3") var screenCountDefault = 0
    @AppStorage("acceleratorScreenCountKeizokuMemory3") var screenCountKeizoku = 0
    @AppStorage("acceleratorScreenCountHighJakuMemory3") var screenCountHighJaku = 0
    @AppStorage("acceleratorScreenCountHighKyoMemory3") var screenCountHighKyo = 0
    @AppStorage("acceleratorScreenCountGusuSisaMemory3") var screenCountGusuSisa = 0
    @AppStorage("acceleratorScreenCountGusuFixMemory3") var screenCountGusuFix = 0
    @AppStorage("acceleratorScreenCountOver2Memory3") var screenCountOver2 = 0
    @AppStorage("acceleratorScreenCountOver4Memory3") var screenCountOver4 = 0
    @AppStorage("acceleratorScreenCountSumMemory3") var screenCountSum = 0
    @AppStorage("acceleratorMemoMemory3") var memo = ""
    @AppStorage("acceleratorDateMemory3") var dateDouble = 0.0
}


struct acceleratorViewTop: View {
    @ObservedObject var accelerator = Accelerator()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // CZ
                    NavigationLink(destination: acceleratorViewCz()) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "CZ,AT 初当り履歴")
                    }
                    // ビッグ,AT終了画面
                    NavigationLink(destination: acceleratorViewScreen()) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle",
                            textBody: "ビッグ,AT終了画面")
                    }
                    // 藤丸コイン
                    NavigationLink(destination: commonViewFujimaruCoin()) {
                        unitLabelMenu(
                            imageSystemName: "medal",
                            textBody: "藤丸コイン"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "一方通行 とある魔術の禁書目録", titleFont: .title2)
                }
                // 設定推測グラフ
                NavigationLink(destination: acceleratorView95Ci()) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(acceleratorSubViewLoadMemory()))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(acceleratorSubViewSaveMemory()))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: accelerator.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct acceleratorSubViewSaveMemory: View {
    @ObservedObject var accelerator = Accelerator()
    @ObservedObject var acceleratorMemory1 = AcceleratorMemory1()
    @ObservedObject var acceleratorMemory2 = AcceleratorMemory2()
    @ObservedObject var acceleratorMemory3 = AcceleratorMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "一方通行 とある魔術の禁書目録",
            selectedMemory: $accelerator.selectedMemory,
            memoMemory1: $acceleratorMemory1.memo,
            dateDoubleMemory1: $acceleratorMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $acceleratorMemory2.memo,
            dateDoubleMemory2: $acceleratorMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $acceleratorMemory3.memo,
            dateDoubleMemory3: $acceleratorMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        acceleratorMemory1.chanceCountLose = accelerator.chanceCountLose
        acceleratorMemory1.chanceCountWinAccelerator = accelerator.chanceCountWinAccelerator
        acceleratorMemory1.chanceCountWinLastorder = accelerator.chanceCountWinLastorder
        acceleratorMemory1.chanceCountSum = accelerator.chanceCountSum
        acceleratorMemory1.chanceCountWinSum = accelerator.chanceCountWinSum
        acceleratorMemory1.gameArrayData = accelerator.gameArrayData
        acceleratorMemory1.czArrayData = accelerator.czArrayData
        acceleratorMemory1.resultArrayData = accelerator.resultArrayData
        acceleratorMemory1.playGameSum = accelerator.playGameSum
        acceleratorMemory1.czCount = accelerator.czCount
        acceleratorMemory1.atCount = accelerator.atCount
        acceleratorMemory1.screenCountDefault = accelerator.screenCountDefault
        acceleratorMemory1.screenCountKeizoku = accelerator.screenCountKeizoku
        acceleratorMemory1.screenCountHighJaku = accelerator.screenCountHighJaku
        acceleratorMemory1.screenCountHighKyo = accelerator.screenCountHighKyo
        acceleratorMemory1.screenCountGusuSisa = accelerator.screenCountGusuSisa
        acceleratorMemory1.screenCountGusuFix = accelerator.screenCountGusuFix
        acceleratorMemory1.screenCountOver2 = accelerator.screenCountOver2
        acceleratorMemory1.screenCountOver4 = accelerator.screenCountOver4
        acceleratorMemory1.screenCountSum = accelerator.screenCountSum
    }
    func saveMemory2() {
        acceleratorMemory2.chanceCountLose = accelerator.chanceCountLose
        acceleratorMemory2.chanceCountWinAccelerator = accelerator.chanceCountWinAccelerator
        acceleratorMemory2.chanceCountWinLastorder = accelerator.chanceCountWinLastorder
        acceleratorMemory2.chanceCountSum = accelerator.chanceCountSum
        acceleratorMemory2.chanceCountWinSum = accelerator.chanceCountWinSum
        acceleratorMemory2.gameArrayData = accelerator.gameArrayData
        acceleratorMemory2.czArrayData = accelerator.czArrayData
        acceleratorMemory2.resultArrayData = accelerator.resultArrayData
        acceleratorMemory2.playGameSum = accelerator.playGameSum
        acceleratorMemory2.czCount = accelerator.czCount
        acceleratorMemory2.atCount = accelerator.atCount
        acceleratorMemory2.screenCountDefault = accelerator.screenCountDefault
        acceleratorMemory2.screenCountKeizoku = accelerator.screenCountKeizoku
        acceleratorMemory2.screenCountHighJaku = accelerator.screenCountHighJaku
        acceleratorMemory2.screenCountHighKyo = accelerator.screenCountHighKyo
        acceleratorMemory2.screenCountGusuSisa = accelerator.screenCountGusuSisa
        acceleratorMemory2.screenCountGusuFix = accelerator.screenCountGusuFix
        acceleratorMemory2.screenCountOver2 = accelerator.screenCountOver2
        acceleratorMemory2.screenCountOver4 = accelerator.screenCountOver4
        acceleratorMemory2.screenCountSum = accelerator.screenCountSum
    }
    func saveMemory3() {
        acceleratorMemory3.chanceCountLose = accelerator.chanceCountLose
        acceleratorMemory3.chanceCountWinAccelerator = accelerator.chanceCountWinAccelerator
        acceleratorMemory3.chanceCountWinLastorder = accelerator.chanceCountWinLastorder
        acceleratorMemory3.chanceCountSum = accelerator.chanceCountSum
        acceleratorMemory3.chanceCountWinSum = accelerator.chanceCountWinSum
        acceleratorMemory3.gameArrayData = accelerator.gameArrayData
        acceleratorMemory3.czArrayData = accelerator.czArrayData
        acceleratorMemory3.resultArrayData = accelerator.resultArrayData
        acceleratorMemory3.playGameSum = accelerator.playGameSum
        acceleratorMemory3.czCount = accelerator.czCount
        acceleratorMemory3.atCount = accelerator.atCount
        acceleratorMemory3.screenCountDefault = accelerator.screenCountDefault
        acceleratorMemory3.screenCountKeizoku = accelerator.screenCountKeizoku
        acceleratorMemory3.screenCountHighJaku = accelerator.screenCountHighJaku
        acceleratorMemory3.screenCountHighKyo = accelerator.screenCountHighKyo
        acceleratorMemory3.screenCountGusuSisa = accelerator.screenCountGusuSisa
        acceleratorMemory3.screenCountGusuFix = accelerator.screenCountGusuFix
        acceleratorMemory3.screenCountOver2 = accelerator.screenCountOver2
        acceleratorMemory3.screenCountOver4 = accelerator.screenCountOver4
        acceleratorMemory3.screenCountSum = accelerator.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct acceleratorSubViewLoadMemory: View {
    @ObservedObject var accelerator = Accelerator()
    @ObservedObject var acceleratorMemory1 = AcceleratorMemory1()
    @ObservedObject var acceleratorMemory2 = AcceleratorMemory2()
    @ObservedObject var acceleratorMemory3 = AcceleratorMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "一方通行 とある魔術の禁書目録",
            selectedMemory: $accelerator.selectedMemory,
            memoMemory1: acceleratorMemory1.memo,
            dateDoubleMemory1: acceleratorMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: acceleratorMemory2.memo,
            dateDoubleMemory2: acceleratorMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: acceleratorMemory3.memo,
            dateDoubleMemory3: acceleratorMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        accelerator.chanceCountLose = acceleratorMemory1.chanceCountLose
        accelerator.chanceCountWinAccelerator = acceleratorMemory1.chanceCountWinAccelerator
        accelerator.chanceCountWinLastorder = acceleratorMemory1.chanceCountWinLastorder
        accelerator.chanceCountSum = acceleratorMemory1.chanceCountSum
        accelerator.chanceCountWinSum = acceleratorMemory1.chanceCountWinSum
        accelerator.gameArrayData = acceleratorMemory1.gameArrayData
        accelerator.czArrayData = acceleratorMemory1.czArrayData
        accelerator.resultArrayData = acceleratorMemory1.resultArrayData
        accelerator.playGameSum = acceleratorMemory1.playGameSum
        accelerator.czCount = acceleratorMemory1.czCount
        accelerator.atCount = acceleratorMemory1.atCount
        accelerator.screenCountDefault = acceleratorMemory1.screenCountDefault
        accelerator.screenCountKeizoku = acceleratorMemory1.screenCountKeizoku
        accelerator.screenCountHighJaku = acceleratorMemory1.screenCountHighJaku
        accelerator.screenCountHighKyo = acceleratorMemory1.screenCountHighKyo
        accelerator.screenCountGusuSisa = acceleratorMemory1.screenCountGusuSisa
        accelerator.screenCountGusuFix = acceleratorMemory1.screenCountGusuFix
        accelerator.screenCountOver2 = acceleratorMemory1.screenCountOver2
        accelerator.screenCountOver4 = acceleratorMemory1.screenCountOver4
        accelerator.screenCountSum = acceleratorMemory1.screenCountSum
    }
    func loadMemory2() {
        accelerator.chanceCountLose = acceleratorMemory2.chanceCountLose
        accelerator.chanceCountWinAccelerator = acceleratorMemory2.chanceCountWinAccelerator
        accelerator.chanceCountWinLastorder = acceleratorMemory2.chanceCountWinLastorder
        accelerator.chanceCountSum = acceleratorMemory2.chanceCountSum
        accelerator.chanceCountWinSum = acceleratorMemory2.chanceCountWinSum
        accelerator.gameArrayData = acceleratorMemory2.gameArrayData
        accelerator.czArrayData = acceleratorMemory2.czArrayData
        accelerator.resultArrayData = acceleratorMemory2.resultArrayData
        accelerator.playGameSum = acceleratorMemory2.playGameSum
        accelerator.czCount = acceleratorMemory2.czCount
        accelerator.atCount = acceleratorMemory2.atCount
        accelerator.screenCountDefault = acceleratorMemory2.screenCountDefault
        accelerator.screenCountKeizoku = acceleratorMemory2.screenCountKeizoku
        accelerator.screenCountHighJaku = acceleratorMemory2.screenCountHighJaku
        accelerator.screenCountHighKyo = acceleratorMemory2.screenCountHighKyo
        accelerator.screenCountGusuSisa = acceleratorMemory2.screenCountGusuSisa
        accelerator.screenCountGusuFix = acceleratorMemory2.screenCountGusuFix
        accelerator.screenCountOver2 = acceleratorMemory2.screenCountOver2
        accelerator.screenCountOver4 = acceleratorMemory2.screenCountOver4
        accelerator.screenCountSum = acceleratorMemory2.screenCountSum
    }
    func loadMemory3() {
        accelerator.chanceCountLose = acceleratorMemory3.chanceCountLose
        accelerator.chanceCountWinAccelerator = acceleratorMemory3.chanceCountWinAccelerator
        accelerator.chanceCountWinLastorder = acceleratorMemory3.chanceCountWinLastorder
        accelerator.chanceCountSum = acceleratorMemory3.chanceCountSum
        accelerator.chanceCountWinSum = acceleratorMemory3.chanceCountWinSum
        accelerator.gameArrayData = acceleratorMemory3.gameArrayData
        accelerator.czArrayData = acceleratorMemory3.czArrayData
        accelerator.resultArrayData = acceleratorMemory3.resultArrayData
        accelerator.playGameSum = acceleratorMemory3.playGameSum
        accelerator.czCount = acceleratorMemory3.czCount
        accelerator.atCount = acceleratorMemory3.atCount
        accelerator.screenCountDefault = acceleratorMemory3.screenCountDefault
        accelerator.screenCountKeizoku = acceleratorMemory3.screenCountKeizoku
        accelerator.screenCountHighJaku = acceleratorMemory3.screenCountHighJaku
        accelerator.screenCountHighKyo = acceleratorMemory3.screenCountHighKyo
        accelerator.screenCountGusuSisa = acceleratorMemory3.screenCountGusuSisa
        accelerator.screenCountGusuFix = acceleratorMemory3.screenCountGusuFix
        accelerator.screenCountOver2 = acceleratorMemory3.screenCountOver2
        accelerator.screenCountOver4 = acceleratorMemory3.screenCountOver4
        accelerator.screenCountSum = acceleratorMemory3.screenCountSum
    }
}


#Preview {
    acceleratorViewTop()
}
