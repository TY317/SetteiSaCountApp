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
        czCountAccelerator = arrayStringDataCount(arrayData: czArrayData, countString: selectListCz[0])
        czCountLastorder = arrayStringDataCount(arrayData: czArrayData, countString: selectListCz[1])
        czCountBoth = arrayStringDataCount(arrayData: czArrayData, countString: selectListCz[2])
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
        czCountAccelerator = arrayStringDataCount(arrayData: czArrayData, countString: selectListCz[0])
        czCountLastorder = arrayStringDataCount(arrayData: czArrayData, countString: selectListCz[1])
        czCountBoth = arrayStringDataCount(arrayData: czArrayData, countString: selectListCz[2])
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
        czCountAccelerator = arrayStringDataCount(arrayData: czArrayData, countString: selectListCz[0])
        czCountLastorder = arrayStringDataCount(arrayData: czArrayData, countString: selectListCz[1])
        czCountBoth = arrayStringDataCount(arrayData: czArrayData, countString: selectListCz[2])
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
        resetShutter()
    }
    
    // ////////////////////////
    // ver2.0.0で追加
    // ////////////////////////
    @AppStorage("acceleratorCzCountAccelerator") var czCountAccelerator = 0
    @AppStorage("acceleratorCzCountLastorder") var czCountLastorder = 0
    @AppStorage("acceleratorCzCountBoth") var czCountBoth = 0
    
    // ////////////////////////
    // シャッター関連
    // ////////////////////////
    @AppStorage("acceleratorNormalChanceCountShutterClose") var normalChanceCount = 0
    @AppStorage("acceleratorNormalChanceCountShutterOpen") var normalChanceCountShutterOpen = 0
    @AppStorage("acceleratorShutterOpenStartGameMemo") var shutterOpenStartGameMemo = 0
    @AppStorage("acceleratorShutterOpenCount18G") var shutterOpenCount18G = 0 {
        didSet {
            shutterOpenCountSum = countSum(shutterOpenCount18G, shutterOpenCount23G, shutterOpenCount33G)
        }
    }
        @AppStorage("acceleratorShutterOpenCount23G") var shutterOpenCount23G = 0 {
            didSet {
                shutterOpenCountSum = countSum(shutterOpenCount18G, shutterOpenCount23G, shutterOpenCount33G)
            }
        }
            @AppStorage("acceleratorShutterOpenCount33G") var shutterOpenCount33G = 0 {
                didSet {
                    shutterOpenCountSum = countSum(shutterOpenCount18G, shutterOpenCount23G, shutterOpenCount33G)
                }
            }
    @AppStorage("acceleratorShutterOpenCountSum") var shutterOpenCountSum = 0
    
    func resetShutter() {
        normalChanceCount = 0
        normalChanceCountShutterOpen = 0
        shutterOpenStartGameMemo = 0
        shutterOpenCount18G = 0
        shutterOpenCount23G = 0
        shutterOpenCount33G = 0
        minusCheck = false
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
    // ////////////////////////
    // ver2.0.0で追加
    // ////////////////////////
    @AppStorage("acceleratorCzCountAcceleratorMemory1") var czCountAccelerator = 0
    @AppStorage("acceleratorCzCountLastorderMemory1") var czCountLastorder = 0
    @AppStorage("acceleratorCzCountBothMemory1") var czCountBoth = 0
    @AppStorage("acceleratorNormalChanceCountShutterCloseMemory1") var normalChanceCount = 0
    @AppStorage("acceleratorNormalChanceCountShutterOpenMemory1") var normalChanceCountShutterOpen = 0
    @AppStorage("acceleratorShutterOpenCount18GMemory1") var shutterOpenCount18G = 0
    @AppStorage("acceleratorShutterOpenCount23GMemory1") var shutterOpenCount23G = 0
    @AppStorage("acceleratorShutterOpenCount33GMemory1") var shutterOpenCount33G = 0
    @AppStorage("acceleratorShutterOpenCountSumMemory1") var shutterOpenCountSum = 0
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
    // ////////////////////////
    // ver2.0.0で追加
    // ////////////////////////
    @AppStorage("acceleratorCzCountAcceleratorMemory2") var czCountAccelerator = 0
    @AppStorage("acceleratorCzCountLastorderMemory2") var czCountLastorder = 0
    @AppStorage("acceleratorCzCountBothMemory2") var czCountBoth = 0
    @AppStorage("acceleratorNormalChanceCountShutterCloseMemory2") var normalChanceCount = 0
    @AppStorage("acceleratorNormalChanceCountShutterOpenMemory2") var normalChanceCountShutterOpen = 0
    @AppStorage("acceleratorShutterOpenCount18GMemory2") var shutterOpenCount18G = 0
    @AppStorage("acceleratorShutterOpenCount23GMemory2") var shutterOpenCount23G = 0
    @AppStorage("acceleratorShutterOpenCount33GMemory2") var shutterOpenCount33G = 0
    @AppStorage("acceleratorShutterOpenCountSumMemory2") var shutterOpenCountSum = 0
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
    // ////////////////////////
    // ver2.0.0で追加
    // ////////////////////////
    @AppStorage("acceleratorCzCountAcceleratorMemory3") var czCountAccelerator = 0
    @AppStorage("acceleratorCzCountLastorderMemory3") var czCountLastorder = 0
    @AppStorage("acceleratorCzCountBothMemory3") var czCountBoth = 0
    @AppStorage("acceleratorNormalChanceCountShutterCloseMemory3") var normalChanceCount = 0
    @AppStorage("acceleratorNormalChanceCountShutterOpenMemory3") var normalChanceCountShutterOpen = 0
    @AppStorage("acceleratorShutterOpenCount18GMemory3") var shutterOpenCount18G = 0
    @AppStorage("acceleratorShutterOpenCount23GMemory3") var shutterOpenCount23G = 0
    @AppStorage("acceleratorShutterOpenCount33GMemory3") var shutterOpenCount33G = 0
    @AppStorage("acceleratorShutterOpenCountSumMemory3") var shutterOpenCountSum = 0
}


struct acceleratorViewTop: View {
//    @ObservedObject var accelerator = Accelerator()
    @StateObject var accelerator = Accelerator()
    @State var isShowAlert: Bool = false
    @StateObject var acceleratorMemory1 = AcceleratorMemory1()
    @StateObject var acceleratorMemory2 = AcceleratorMemory2()
    @StateObject var acceleratorMemory3 = AcceleratorMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // シャッター関連
                    NavigationLink(destination: acceleratorViewShutter(accelerator: accelerator)) {
                        unitLabelMenu(
                            imageSystemName: "door.sliding.left.hand.closed",
                            textBody: "通常時 シャッター関連")
//                        .popoverTip(tipVer200AcceleratorMenuShutter())
                    }
                    // CZ
                    NavigationLink(destination: acceleratorViewCz(accelerator: accelerator)) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "CZ,AT 初当り履歴")
                    }
                    // ビッグ,AT終了画面
                    NavigationLink(destination: acceleratorViewScreen(accelerator: accelerator)) {
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
                NavigationLink(destination: acceleratorView95Ci(accelerator: accelerator, selection: 9)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4686")
//                    .popoverTip(tipVer220AddLink())
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(acceleratorSubViewLoadMemory(
                        accelerator: accelerator,
                        acceleratorMemory1: acceleratorMemory1,
                        acceleratorMemory2: acceleratorMemory2,
                        acceleratorMemory3: acceleratorMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(acceleratorSubViewSaveMemory(
                        accelerator: accelerator,
                        acceleratorMemory1: acceleratorMemory1,
                        acceleratorMemory2: acceleratorMemory2,
                        acceleratorMemory3: acceleratorMemory3
                    )))
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
    @ObservedObject var accelerator: Accelerator
    @ObservedObject var acceleratorMemory1: AcceleratorMemory1
    @ObservedObject var acceleratorMemory2: AcceleratorMemory2
    @ObservedObject var acceleratorMemory3: AcceleratorMemory3
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
        // ////////////////////////
        // ver2.0.0で追加
        // ////////////////////////
        acceleratorMemory1.czCountAccelerator = accelerator.czCountAccelerator
        acceleratorMemory1.czCountLastorder = accelerator.czCountLastorder
        acceleratorMemory1.czCountBoth = accelerator.czCountBoth
        acceleratorMemory1.normalChanceCount = accelerator.normalChanceCount
        acceleratorMemory1.normalChanceCountShutterOpen = accelerator.normalChanceCountShutterOpen
        acceleratorMemory1.shutterOpenCount18G = accelerator.shutterOpenCount18G
        acceleratorMemory1.shutterOpenCount23G = accelerator.shutterOpenCount23G
        acceleratorMemory1.shutterOpenCount33G = accelerator.shutterOpenCount33G
        acceleratorMemory1.shutterOpenCountSum = accelerator.shutterOpenCountSum
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
        // ////////////////////////
        // ver2.0.0で追加
        // ////////////////////////
        acceleratorMemory2.czCountAccelerator = accelerator.czCountAccelerator
        acceleratorMemory2.czCountLastorder = accelerator.czCountLastorder
        acceleratorMemory2.czCountBoth = accelerator.czCountBoth
        acceleratorMemory2.normalChanceCount = accelerator.normalChanceCount
        acceleratorMemory2.normalChanceCountShutterOpen = accelerator.normalChanceCountShutterOpen
        acceleratorMemory2.shutterOpenCount18G = accelerator.shutterOpenCount18G
        acceleratorMemory2.shutterOpenCount23G = accelerator.shutterOpenCount23G
        acceleratorMemory2.shutterOpenCount33G = accelerator.shutterOpenCount33G
        acceleratorMemory2.shutterOpenCountSum = accelerator.shutterOpenCountSum
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
        // ////////////////////////
        // ver2.0.0で追加
        // ////////////////////////
        acceleratorMemory3.czCountAccelerator = accelerator.czCountAccelerator
        acceleratorMemory3.czCountLastorder = accelerator.czCountLastorder
        acceleratorMemory3.czCountBoth = accelerator.czCountBoth
        acceleratorMemory3.normalChanceCount = accelerator.normalChanceCount
        acceleratorMemory3.normalChanceCountShutterOpen = accelerator.normalChanceCountShutterOpen
        acceleratorMemory3.shutterOpenCount18G = accelerator.shutterOpenCount18G
        acceleratorMemory3.shutterOpenCount23G = accelerator.shutterOpenCount23G
        acceleratorMemory3.shutterOpenCount33G = accelerator.shutterOpenCount33G
        acceleratorMemory3.shutterOpenCountSum = accelerator.shutterOpenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct acceleratorSubViewLoadMemory: View {
    @ObservedObject var accelerator: Accelerator
    @ObservedObject var acceleratorMemory1: AcceleratorMemory1
    @ObservedObject var acceleratorMemory2: AcceleratorMemory2
    @ObservedObject var acceleratorMemory3: AcceleratorMemory3
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
        let memoryGameArray = decodeIntArray(from: acceleratorMemory1.gameArrayData)
        saveArray(memoryGameArray, forKey: accelerator.gameArrayKey)
        let memoryCzArray = decodeStringArray(from: acceleratorMemory1.czArrayData)
        saveArray(memoryCzArray, forKey: accelerator.czArrayKey)
        let memoryResultArray = decodeStringArray(from: acceleratorMemory1.resultArrayData)
        saveArray(memoryResultArray, forKey: accelerator.resultArrayKey)
//        accelerator.gameArrayData = acceleratorMemory1.gameArrayData
//        accelerator.czArrayData = acceleratorMemory1.czArrayData
//        accelerator.resultArrayData = acceleratorMemory1.resultArrayData
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
        // ////////////////////////
        // ver2.0.0で追加
        // ////////////////////////
        accelerator.czCountAccelerator = acceleratorMemory1.czCountAccelerator
        accelerator.czCountLastorder = acceleratorMemory1.czCountLastorder
        accelerator.czCountBoth = acceleratorMemory1.czCountBoth
        accelerator.normalChanceCount = acceleratorMemory1.normalChanceCount
        accelerator.normalChanceCountShutterOpen = acceleratorMemory1.normalChanceCountShutterOpen
        accelerator.shutterOpenCount18G = acceleratorMemory1.shutterOpenCount18G
        accelerator.shutterOpenCount23G = acceleratorMemory1.shutterOpenCount23G
        accelerator.shutterOpenCount33G = acceleratorMemory1.shutterOpenCount33G
        accelerator.shutterOpenCountSum = acceleratorMemory1.shutterOpenCountSum
    }
    func loadMemory2() {
        accelerator.chanceCountLose = acceleratorMemory2.chanceCountLose
        accelerator.chanceCountWinAccelerator = acceleratorMemory2.chanceCountWinAccelerator
        accelerator.chanceCountWinLastorder = acceleratorMemory2.chanceCountWinLastorder
        accelerator.chanceCountSum = acceleratorMemory2.chanceCountSum
        accelerator.chanceCountWinSum = acceleratorMemory2.chanceCountWinSum
        let memoryGameArray = decodeIntArray(from: acceleratorMemory2.gameArrayData)
        saveArray(memoryGameArray, forKey: accelerator.gameArrayKey)
        let memoryCzArray = decodeStringArray(from: acceleratorMemory2.czArrayData)
        saveArray(memoryCzArray, forKey: accelerator.czArrayKey)
        let memoryResultArray = decodeStringArray(from: acceleratorMemory2.resultArrayData)
        saveArray(memoryResultArray, forKey: accelerator.resultArrayKey)
//        accelerator.gameArrayData = acceleratorMemory2.gameArrayData
//        accelerator.czArrayData = acceleratorMemory2.czArrayData
//        accelerator.resultArrayData = acceleratorMemory2.resultArrayData
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
        // ////////////////////////
        // ver2.0.0で追加
        // ////////////////////////
        accelerator.czCountAccelerator = acceleratorMemory2.czCountAccelerator
        accelerator.czCountLastorder = acceleratorMemory2.czCountLastorder
        accelerator.czCountBoth = acceleratorMemory2.czCountBoth
        accelerator.normalChanceCount = acceleratorMemory2.normalChanceCount
        accelerator.normalChanceCountShutterOpen = acceleratorMemory2.normalChanceCountShutterOpen
        accelerator.shutterOpenCount18G = acceleratorMemory2.shutterOpenCount18G
        accelerator.shutterOpenCount23G = acceleratorMemory2.shutterOpenCount23G
        accelerator.shutterOpenCount33G = acceleratorMemory2.shutterOpenCount33G
        accelerator.shutterOpenCountSum = acceleratorMemory2.shutterOpenCountSum
    }
    func loadMemory3() {
        accelerator.chanceCountLose = acceleratorMemory3.chanceCountLose
        accelerator.chanceCountWinAccelerator = acceleratorMemory3.chanceCountWinAccelerator
        accelerator.chanceCountWinLastorder = acceleratorMemory3.chanceCountWinLastorder
        accelerator.chanceCountSum = acceleratorMemory3.chanceCountSum
        accelerator.chanceCountWinSum = acceleratorMemory3.chanceCountWinSum
        let memoryGameArray = decodeIntArray(from: acceleratorMemory3.gameArrayData)
        saveArray(memoryGameArray, forKey: accelerator.gameArrayKey)
        let memoryCzArray = decodeStringArray(from: acceleratorMemory3.czArrayData)
        saveArray(memoryCzArray, forKey: accelerator.czArrayKey)
        let memoryResultArray = decodeStringArray(from: acceleratorMemory3.resultArrayData)
        saveArray(memoryResultArray, forKey: accelerator.resultArrayKey)
//        accelerator.gameArrayData = acceleratorMemory3.gameArrayData
//        accelerator.czArrayData = acceleratorMemory3.czArrayData
//        accelerator.resultArrayData = acceleratorMemory3.resultArrayData
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
        // ////////////////////////
        // ver2.0.0で追加
        // ////////////////////////
        accelerator.czCountAccelerator = acceleratorMemory3.czCountAccelerator
        accelerator.czCountLastorder = acceleratorMemory3.czCountLastorder
        accelerator.czCountBoth = acceleratorMemory3.czCountBoth
        accelerator.normalChanceCount = acceleratorMemory3.normalChanceCount
        accelerator.normalChanceCountShutterOpen = acceleratorMemory3.normalChanceCountShutterOpen
        accelerator.shutterOpenCount18G = acceleratorMemory3.shutterOpenCount18G
        accelerator.shutterOpenCount23G = acceleratorMemory3.shutterOpenCount23G
        accelerator.shutterOpenCount33G = acceleratorMemory3.shutterOpenCount33G
        accelerator.shutterOpenCountSum = acceleratorMemory3.shutterOpenCountSum
    }
}


#Preview {
    acceleratorViewTop()
}
