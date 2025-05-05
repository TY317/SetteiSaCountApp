//
//  hokutoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/01.
//

import SwiftUI
import TipKit


// ///////////////////
// 変数
// ///////////////////
class Hokuto: ObservableObject {
    // ///////////////////
    // 通常時子役
    // ///////////////////
    @AppStorage("hokutoNormalBellNanameCount") var normalBellNanameCount = 0 {
        didSet {
            normalBellCountSum = countSum(normalBellNanameCount, normalBellHorizontalCount)
        }
    }
    @AppStorage("hokutoNormalBellHorizontalCount") var normalBellHorizontalCount = 0 {
        didSet {
            normalBellCountSum = countSum(normalBellNanameCount, normalBellHorizontalCount)
        }
    }
    @AppStorage("hokutoNormalBellCountSum") var normalBellCountSum = 0
    @AppStorage("hokutoNormalStartGame") var normalStartGame = 0 {
        didSet {
            let games = normalCurrentGame - normalStartGame
            normalPlayGame = games > 0 ? games : 0
        }
    }
    @AppStorage("hokutoNormalCurrentGame") var normalCurrentGame = 0 {
        didSet {
            let games = normalCurrentGame - normalStartGame
            normalPlayGame = games > 0 ? games : 0
        }
    }
    @AppStorage("hokutoNormalPlayGame") var normalPlayGame = 0
    
    
    func resetNormalKoyaku() {
        normalBellNanameCount = 0
        normalBellHorizontalCount = 0
        normalStartGame = 0
        normalCurrentGame = 0
        minusCheck = false
    }
    
    
    // ////////////////////
    // バトルボーナス初当たり履歴
    // ////////////////////
    // 選択肢の設定
    @Published var selectListMode = ["天国", "通常以上", "通常", "通常以下", "地獄"]
    @Published var selectListTrigger = ["強スイカ", "弱スイカ", "中チェ", "角チェ", "チャンス目", "確定役", "天井", "即前兆", "謎"]
    // 選択結果の設定
    @Published var inputGame = 0
    @Published var selectedMode = "通常"
    @Published var selectedTrigger = "中チェ"
    // //// 配列の設定
    // ゲーム数配列
    let hokutoGameArrayKey = "hokutoGameArrayKey"
    @AppStorage("hokutoGameArrayKey") var gameArrayData: Data?
    // モード配列
    let hokutoModeArrayKey = "hokutoModeArrayKey"
    @AppStorage("hokutoModeArrayKey") var modeArrayData: Data?
    // 当選契機配列
    let hokutoTriggerArrayKey = "hokutoTriggerArrayKey"
    @AppStorage("hokutoTriggerArrayKey") var triggerArrayData: Data?
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: hokutoGameArrayKey)
        arrayStringRemoveLast(arrayData: modeArrayData, key: hokutoModeArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: hokutoTriggerArrayKey)
        bbHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        bbGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedMode = "通常"
        selectedTrigger = "中チェ"
    }
    
    // データ追加
    func addDataHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: hokutoGameArrayKey)
        arrayStringAddData(arrayData: modeArrayData, addData: selectedMode, key: hokutoModeArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedTrigger, key: hokutoTriggerArrayKey)
        bbHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        bbGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedMode = "通常"
        selectedTrigger = "中チェ"
    }
    
    // 初当たり回数の取得
    @AppStorage("hokutoBbHitCount") var bbHitCount = 0
    
    // 配列内のデータ合計ゲーム数の取得
    @AppStorage("hokutoBbGameSum") var bbGameSum = 0
    
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: hokutoGameArrayKey)
        arrayStringRemoveAll(arrayData: modeArrayData, key: hokutoModeArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: hokutoTriggerArrayKey)
        bbHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        bbGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedMode = "通常"
        selectedTrigger = "中チェ"
        minusCheck = false
    }
    
    // ////////////////////
    // バトルボーナス中のベル
    // ////////////////////
    @AppStorage("hokutoBbBellNanameCount") var bbBellNanameCount = 0 {
        didSet {
            bbBellCountSum = countSum(bbBellNanameCount, bbBellHorizontalCount)
        }
    }
    @AppStorage("hokutoBbBellHorizontalCount") var bbBellHorizontalCount = 0 {
        didSet {
            bbBellCountSum = countSum(bbBellNanameCount, bbBellHorizontalCount)
        }
    }
    @AppStorage("hokutoBbBellCountSum") var bbBellCountSum = 0
    @AppStorage("hokutoBbStartSet") var bbStartSet = 0 {
        didSet {
            let game = (bbCurrentSet - bbStartSet) * 30
            bbPlayGame = game > 0 ? game : 0
        }
    }
    @AppStorage("hokutoBbCurrentSet") var bbCurrentSet = 0 {
        didSet {
            let game = (bbCurrentSet - bbStartSet) * 30
            bbPlayGame = game > 0 ? game : 0
        }
    }
    @AppStorage("hokutoBbPlayGame") var bbPlayGame = 0
    
    func resetBbBell() {
        bbBellNanameCount = 0
        bbBellHorizontalCount = 0
        bbStartSet = 0
        bbCurrentSet = 0
        minusCheck = false
    }
    
    // ///////////////////
    // ボイス
    // ///////////////////
    @Published var selectListVoice = ["ケン、会いたかった", "おいおい、置いてかないでくれよ", "お前が思っているほど北斗神拳は無敵ではない", "退かぬ！媚びぬ！省みぬ！", "ケンシロウ、俺の名を言ってみろ！", "ふむ、この秘孔ではないらしい", "戦うのが北斗神拳伝承者としての宿命だ！", "待ち続けるのが私の宿命。そしてケンとの約束"]
    @AppStorage("hokutoSelectedVoice") var selectedVoice = "おいおい、置いてかないでくれよ"
//    @AppStorage("hokutoVoiceRinCount") var voiceRinCount = 0
//    @AppStorage("hokutoVoiceBattCount") var voiceBattCount = 0
    @AppStorage("hokutoVoiceDefaultCount") var voiceDefaultCount = 0 {
        didSet {
            voiceCountSum = countSum(voiceDefaultCount, voiceShinCount, voiceSauzaCount, voiceJagiCount, voiceAmibaCount, voiceKenCount, voiceYuriaCount)
        }
    }
        @AppStorage("hokutoVoiceShinCount") var voiceShinCount = 0 {
            didSet {
                voiceCountSum = countSum(voiceDefaultCount, voiceShinCount, voiceSauzaCount, voiceJagiCount, voiceAmibaCount, voiceKenCount, voiceYuriaCount)
            }
        }
            @AppStorage("hokutoVoiceSauzaCount") var voiceSauzaCount = 0 {
                didSet {
                    voiceCountSum = countSum(voiceDefaultCount, voiceShinCount, voiceSauzaCount, voiceJagiCount, voiceAmibaCount, voiceKenCount, voiceYuriaCount)
                }
            }
                @AppStorage("hokutoVoiceJagiCount") var voiceJagiCount = 0 {
                    didSet {
                        voiceCountSum = countSum(voiceDefaultCount, voiceShinCount, voiceSauzaCount, voiceJagiCount, voiceAmibaCount, voiceKenCount, voiceYuriaCount)
                    }
                }
                    @AppStorage("hokutoVoiceAmibaCount") var voiceAmibaCount = 0 {
                        didSet {
                            voiceCountSum = countSum(voiceDefaultCount, voiceShinCount, voiceSauzaCount, voiceJagiCount, voiceAmibaCount, voiceKenCount, voiceYuriaCount)
                        }
                    }
                        @AppStorage("hokutoVoiceKenCount") var voiceKenCount = 0 {
                            didSet {
                                voiceCountSum = countSum(voiceDefaultCount, voiceShinCount, voiceSauzaCount, voiceJagiCount, voiceAmibaCount, voiceKenCount, voiceYuriaCount)
                            }
                        }
                            @AppStorage("hokutoVoiceYuriaCount") var voiceYuriaCount = 0 {
                                didSet {
                                    voiceCountSum = countSum(voiceDefaultCount, voiceShinCount, voiceSauzaCount, voiceJagiCount, voiceAmibaCount, voiceKenCount, voiceYuriaCount)
                                }
                            }
    @AppStorage("hokutoVoiceCountSum") var voiceCountSum = 0
    
    func resetVoice() {
        voiceDefaultCount = 0
        voiceShinCount = 0
        voiceSauzaCount = 0
        voiceJagiCount = 0
        voiceAmibaCount = 0
        voiceKenCount = 0
        voiceYuriaCount = 0
        minusCheck = false
    }
    
    // ///////////////////
    // 共通
    // ///////////////////
    @AppStorage("hokutoMinusCheck") var minusCheck = false
    @AppStorage("hokutoSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormalKoyaku()
        resetHistory()
        resetBbBell()
        resetVoice()
    }
}


// //// メモリー1
class HokutoMemory1: ObservableObject {
    @AppStorage("hokutoNormalBellNanameCountMemory1") var normalBellNanameCount = 0
    @AppStorage("hokutoNormalBellHorizontalCountMemory1") var normalBellHorizontalCount = 0
    @AppStorage("hokutoNormalBellCountSumMemory1") var normalBellCountSum = 0
    @AppStorage("hokutoNormalStartGameMemory1") var normalStartGame = 0
    @AppStorage("hokutoNormalCurrentGameMemory1") var normalCurrentGame = 0
    @AppStorage("hokutoNormalPlayGameMemory1") var normalPlayGame = 0
    @AppStorage("hokutoGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("hokutoModeArrayKeyMemory1") var modeArrayData: Data?
    @AppStorage("hokutoTriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("hokutoBbHitCountMemory1") var bbHitCount = 0
    @AppStorage("hokutoBbGameSumMemory1") var bbGameSum = 0
    @AppStorage("hokutoBbBellNanameCountMemory1") var bbBellNanameCount = 0
    @AppStorage("hokutoBbBellHorizontalCountMemory1") var bbBellHorizontalCount = 0
    @AppStorage("hokutoBbBellCountSumMemory1") var bbBellCountSum = 0
    @AppStorage("hokutoBbStartSetMemory1") var bbStartSet = 0
    @AppStorage("hokutoBbCurrentSetMemory1") var bbCurrentSet = 0
    @AppStorage("hokutoBbPlayGameMemory1") var bbPlayGame = 0
    @AppStorage("hokutoVoiceDefaultCountMemory1") var voiceDefaultCount = 0
    @AppStorage("hokutoVoiceShinCountMemory1") var voiceShinCount = 0
    @AppStorage("hokutoVoiceSauzaCountMemory1") var voiceSauzaCount = 0
    @AppStorage("hokutoVoiceJagiCountMemory1") var voiceJagiCount = 0
    @AppStorage("hokutoVoiceAmibaCountMemory1") var voiceAmibaCount = 0
    @AppStorage("hokutoVoiceKenCountMemory1") var voiceKenCount = 0
    @AppStorage("hokutoVoiceYuriaCountMemory1") var voiceYuriaCount = 0
    @AppStorage("hokutoVoiceCountSumMemory1") var voiceCountSum = 0
    @AppStorage("hokutoMemoMemory1") var memo = ""
    @AppStorage("hokutoDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class HokutoMemory2: ObservableObject {
    @AppStorage("hokutoNormalBellNanameCountMemory2") var normalBellNanameCount = 0
    @AppStorage("hokutoNormalBellHorizontalCountMemory2") var normalBellHorizontalCount = 0
    @AppStorage("hokutoNormalBellCountSumMemory2") var normalBellCountSum = 0
    @AppStorage("hokutoNormalStartGameMemory2") var normalStartGame = 0
    @AppStorage("hokutoNormalCurrentGameMemory2") var normalCurrentGame = 0
    @AppStorage("hokutoNormalPlayGameMemory2") var normalPlayGame = 0
    @AppStorage("hokutoGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("hokutoModeArrayKeyMemory2") var modeArrayData: Data?
    @AppStorage("hokutoTriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("hokutoBbHitCountMemory2") var bbHitCount = 0
    @AppStorage("hokutoBbGameSumMemory2") var bbGameSum = 0
    @AppStorage("hokutoBbBellNanameCountMemory2") var bbBellNanameCount = 0
    @AppStorage("hokutoBbBellHorizontalCountMemory2") var bbBellHorizontalCount = 0
    @AppStorage("hokutoBbBellCountSumMemory2") var bbBellCountSum = 0
    @AppStorage("hokutoBbStartSetMemory2") var bbStartSet = 0
    @AppStorage("hokutoBbCurrentSetMemory2") var bbCurrentSet = 0
    @AppStorage("hokutoBbPlayGameMemory2") var bbPlayGame = 0
    @AppStorage("hokutoVoiceDefaultCountMemory2") var voiceDefaultCount = 0
    @AppStorage("hokutoVoiceShinCountMemory2") var voiceShinCount = 0
    @AppStorage("hokutoVoiceSauzaCountMemory2") var voiceSauzaCount = 0
    @AppStorage("hokutoVoiceJagiCountMemory2") var voiceJagiCount = 0
    @AppStorage("hokutoVoiceAmibaCountMemory2") var voiceAmibaCount = 0
    @AppStorage("hokutoVoiceKenCountMemory2") var voiceKenCount = 0
    @AppStorage("hokutoVoiceYuriaCountMemory2") var voiceYuriaCount = 0
    @AppStorage("hokutoVoiceCountSumMemory2") var voiceCountSum = 0
    @AppStorage("hokutoMemoMemory2") var memo = ""
    @AppStorage("hokutoDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class HokutoMemory3: ObservableObject {
    @AppStorage("hokutoNormalBellNanameCountMemory3") var normalBellNanameCount = 0
    @AppStorage("hokutoNormalBellHorizontalCountMemory3") var normalBellHorizontalCount = 0
    @AppStorage("hokutoNormalBellCountSumMemory3") var normalBellCountSum = 0
    @AppStorage("hokutoNormalStartGameMemory3") var normalStartGame = 0
    @AppStorage("hokutoNormalCurrentGameMemory3") var normalCurrentGame = 0
    @AppStorage("hokutoNormalPlayGameMemory3") var normalPlayGame = 0
    @AppStorage("hokutoGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("hokutoModeArrayKeyMemory3") var modeArrayData: Data?
    @AppStorage("hokutoTriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("hokutoBbHitCountMemory3") var bbHitCount = 0
    @AppStorage("hokutoBbGameSumMemory3") var bbGameSum = 0
    @AppStorage("hokutoBbBellNanameCountMemory3") var bbBellNanameCount = 0
    @AppStorage("hokutoBbBellHorizontalCountMemory3") var bbBellHorizontalCount = 0
    @AppStorage("hokutoBbBellCountSumMemory3") var bbBellCountSum = 0
    @AppStorage("hokutoBbStartSetMemory3") var bbStartSet = 0
    @AppStorage("hokutoBbCurrentSetMemory3") var bbCurrentSet = 0
    @AppStorage("hokutoBbPlayGameMemory3") var bbPlayGame = 0
    @AppStorage("hokutoVoiceDefaultCountMemory3") var voiceDefaultCount = 0
    @AppStorage("hokutoVoiceShinCountMemory3") var voiceShinCount = 0
    @AppStorage("hokutoVoiceSauzaCountMemory3") var voiceSauzaCount = 0
    @AppStorage("hokutoVoiceJagiCountMemory3") var voiceJagiCount = 0
    @AppStorage("hokutoVoiceAmibaCountMemory3") var voiceAmibaCount = 0
    @AppStorage("hokutoVoiceKenCountMemory3") var voiceKenCount = 0
    @AppStorage("hokutoVoiceYuriaCountMemory3") var voiceYuriaCount = 0
    @AppStorage("hokutoVoiceCountSumMemory3") var voiceCountSum = 0
    @AppStorage("hokutoMemoMemory3") var memo = ""
    @AppStorage("hokutoDateMemory3") var dateDouble = 0.0
}


struct hokutoViewTop: View {
//    @ObservedObject var hokuto = Hokuto()
    @StateObject var hokuto = Hokuto()
    @State var isShowAlert = false
    @StateObject var hokutoMemory1 = HokutoMemory1()
    @StateObject var hokutoMemory2 = HokutoMemory2()
    @StateObject var hokutoMemory3 = HokutoMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時子役
                    NavigationLink(destination: hokutoViewNormalKoyaku(hokuto: hokuto)) {
                        unitLabelMenu(imageSystemName: "bell", textBody: "通常時小役")
                    }
                    // バトルボーナス初当たり履歴
                    NavigationLink(destination: hokutoViewHistory(hokuto: hokuto)) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "バトルボーナス初当たり履歴")
                    }
                    // バトルボーナス中のベル
                    NavigationLink(destination: hokutoViewBbBell(hokuto: hokuto)) {
                        unitLabelMenu(imageSystemName: "bell.fill", textBody: "バトルボーナス中のベル")
                    }
                    // バトルボーナス後のボイス
                    NavigationLink(destination: hokutoViewVoice(hokuto: hokuto)) {
                        unitLabelMenu(imageSystemName: "message", textBody: "バトルボーナス後のボイス")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "スマスロ北斗の拳")
                }
                // 設定推測グラフ
                NavigationLink(destination: hokutoView95Ci(hokuto: hokuto)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4301")
//                    .popoverTip(tipVer220AddLink())
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    HStack {
                        // //// データ読み出し
                        unitButtonLoadMemory(loadView: AnyView(hokutoViewLoadMemory(
                            hokuto: hokuto,
                            hokutoMemory1: hokutoMemory1,
                            hokutoMemory2: hokutoMemory2,
                            hokutoMemory3: hokutoMemory3
                        )))
                        // //// データ保存
                        unitButtonSaveMemory(saveView: AnyView(hokutoViewSaveMemory(
                            hokuto: hokuto,
                            hokutoMemory1: hokutoMemory1,
                            hokutoMemory2: hokutoMemory2,
                            hokutoMemory3: hokutoMemory3
                        )))
                    }
                    .popoverTip(tipUnitButtonMemory())
                    unitButtonReset(isShowAlert: $isShowAlert, action: hokuto.resetAll, message: "この機種の全データをリセットします")
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// /////////////////////////////
// メモリーセーブ画面
// /////////////////////////////
struct hokutoViewSaveMemory: View {
    @ObservedObject var hokuto: Hokuto
    @ObservedObject var hokutoMemory1: HokutoMemory1
    @ObservedObject var hokutoMemory2: HokutoMemory2
    @ObservedObject var hokutoMemory3: HokutoMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "スマスロ北斗の拳",
            selectedMemory: $hokuto.selectedMemory,
            memoMemory1: $hokutoMemory1.memo,
            dateDoubleMemory1: $hokutoMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $hokutoMemory2.memo,
            dateDoubleMemory2: $hokutoMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $hokutoMemory3.memo,
            dateDoubleMemory3: $hokutoMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        hokutoMemory1.normalBellNanameCount = hokuto.normalBellNanameCount
        hokutoMemory1.normalBellHorizontalCount = hokuto.normalBellHorizontalCount
        hokutoMemory1.normalBellCountSum = hokuto.normalBellCountSum
        hokutoMemory1.normalStartGame = hokuto.normalStartGame
        hokutoMemory1.normalCurrentGame = hokuto.normalCurrentGame
        hokutoMemory1.normalPlayGame = hokuto.normalPlayGame
        hokutoMemory1.gameArrayData = hokuto.gameArrayData
        hokutoMemory1.modeArrayData = hokuto.modeArrayData
        hokutoMemory1.triggerArrayData = hokuto.triggerArrayData
        hokutoMemory1.bbHitCount = hokuto.bbHitCount
        hokutoMemory1.bbGameSum = hokuto.bbGameSum
        hokutoMemory1.bbBellNanameCount = hokuto.bbBellNanameCount
        hokutoMemory1.bbBellHorizontalCount = hokuto.bbBellHorizontalCount
        hokutoMemory1.bbBellCountSum = hokuto.bbBellCountSum
        hokutoMemory1.bbStartSet = hokuto.bbStartSet
        hokutoMemory1.bbCurrentSet = hokuto.bbCurrentSet
        hokutoMemory1.bbPlayGame = hokuto.bbPlayGame
        hokutoMemory1.voiceDefaultCount = hokuto.voiceDefaultCount
        hokutoMemory1.voiceShinCount = hokuto.voiceShinCount
        hokutoMemory1.voiceSauzaCount = hokuto.voiceSauzaCount
        hokutoMemory1.voiceJagiCount = hokuto.voiceJagiCount
        hokutoMemory1.voiceAmibaCount = hokuto.voiceAmibaCount
        hokutoMemory1.voiceKenCount = hokuto.voiceKenCount
        hokutoMemory1.voiceYuriaCount = hokuto.voiceYuriaCount
        hokutoMemory1.voiceCountSum = hokuto.voiceCountSum
    }
    func saveMemory2() {
        hokutoMemory2.normalBellNanameCount = hokuto.normalBellNanameCount
        hokutoMemory2.normalBellHorizontalCount = hokuto.normalBellHorizontalCount
        hokutoMemory2.normalBellCountSum = hokuto.normalBellCountSum
        hokutoMemory2.normalStartGame = hokuto.normalStartGame
        hokutoMemory2.normalCurrentGame = hokuto.normalCurrentGame
        hokutoMemory2.normalPlayGame = hokuto.normalPlayGame
        hokutoMemory2.gameArrayData = hokuto.gameArrayData
        hokutoMemory2.modeArrayData = hokuto.modeArrayData
        hokutoMemory2.triggerArrayData = hokuto.triggerArrayData
        hokutoMemory2.bbHitCount = hokuto.bbHitCount
        hokutoMemory2.bbGameSum = hokuto.bbGameSum
        hokutoMemory2.bbBellNanameCount = hokuto.bbBellNanameCount
        hokutoMemory2.bbBellHorizontalCount = hokuto.bbBellHorizontalCount
        hokutoMemory2.bbBellCountSum = hokuto.bbBellCountSum
        hokutoMemory2.bbStartSet = hokuto.bbStartSet
        hokutoMemory2.bbCurrentSet = hokuto.bbCurrentSet
        hokutoMemory2.bbPlayGame = hokuto.bbPlayGame
        hokutoMemory2.voiceDefaultCount = hokuto.voiceDefaultCount
        hokutoMemory2.voiceShinCount = hokuto.voiceShinCount
        hokutoMemory2.voiceSauzaCount = hokuto.voiceSauzaCount
        hokutoMemory2.voiceJagiCount = hokuto.voiceJagiCount
        hokutoMemory2.voiceAmibaCount = hokuto.voiceAmibaCount
        hokutoMemory2.voiceKenCount = hokuto.voiceKenCount
        hokutoMemory2.voiceYuriaCount = hokuto.voiceYuriaCount
        hokutoMemory2.voiceCountSum = hokuto.voiceCountSum
    }
    func saveMemory3() {
        hokutoMemory3.normalBellNanameCount = hokuto.normalBellNanameCount
        hokutoMemory3.normalBellHorizontalCount = hokuto.normalBellHorizontalCount
        hokutoMemory3.normalBellCountSum = hokuto.normalBellCountSum
        hokutoMemory3.normalStartGame = hokuto.normalStartGame
        hokutoMemory3.normalCurrentGame = hokuto.normalCurrentGame
        hokutoMemory3.normalPlayGame = hokuto.normalPlayGame
        hokutoMemory3.gameArrayData = hokuto.gameArrayData
        hokutoMemory3.modeArrayData = hokuto.modeArrayData
        hokutoMemory3.triggerArrayData = hokuto.triggerArrayData
        hokutoMemory3.bbHitCount = hokuto.bbHitCount
        hokutoMemory3.bbGameSum = hokuto.bbGameSum
        hokutoMemory3.bbBellNanameCount = hokuto.bbBellNanameCount
        hokutoMemory3.bbBellHorizontalCount = hokuto.bbBellHorizontalCount
        hokutoMemory3.bbBellCountSum = hokuto.bbBellCountSum
        hokutoMemory3.bbStartSet = hokuto.bbStartSet
        hokutoMemory3.bbCurrentSet = hokuto.bbCurrentSet
        hokutoMemory3.bbPlayGame = hokuto.bbPlayGame
        hokutoMemory3.voiceDefaultCount = hokuto.voiceDefaultCount
        hokutoMemory3.voiceShinCount = hokuto.voiceShinCount
        hokutoMemory3.voiceSauzaCount = hokuto.voiceSauzaCount
        hokutoMemory3.voiceJagiCount = hokuto.voiceJagiCount
        hokutoMemory3.voiceAmibaCount = hokuto.voiceAmibaCount
        hokutoMemory3.voiceKenCount = hokuto.voiceKenCount
        hokutoMemory3.voiceYuriaCount = hokuto.voiceYuriaCount
        hokutoMemory3.voiceCountSum = hokuto.voiceCountSum
    }
}


// /////////////////////////////
// メモリーロード画面
// /////////////////////////////
struct hokutoViewLoadMemory: View {
    @ObservedObject var hokuto: Hokuto
    @ObservedObject var hokutoMemory1: HokutoMemory1
    @ObservedObject var hokutoMemory2: HokutoMemory2
    @ObservedObject var hokutoMemory3: HokutoMemory3
    @State var isShowLoadAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "スマスロ北斗の拳",
            selectedMemory: $hokuto.selectedMemory,
            memoMemory1: hokutoMemory1.memo,
            dateDoubleMemory1: hokutoMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: hokutoMemory2.memo,
            dateDoubleMemory2: hokutoMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: hokutoMemory3.memo,
            dateDoubleMemory3: hokutoMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        hokuto.normalBellNanameCount = hokutoMemory1.normalBellNanameCount
        hokuto.normalBellHorizontalCount = hokutoMemory1.normalBellHorizontalCount
        hokuto.normalBellCountSum = hokutoMemory1.normalBellCountSum
        hokuto.normalStartGame = hokutoMemory1.normalStartGame
        hokuto.normalCurrentGame = hokutoMemory1.normalCurrentGame
        hokuto.normalPlayGame = hokutoMemory1.normalPlayGame
        let memoryGameArray = decodeIntArray(from: hokutoMemory1.gameArrayData)
        saveArray(memoryGameArray, forKey: hokuto.hokutoGameArrayKey)
        let memoryModeArray = decodeStringArray(from: hokutoMemory1.modeArrayData)
        saveArray(memoryModeArray, forKey: hokuto.hokutoModeArrayKey)
        let memoryTriggerArray = decodeStringArray(from: hokutoMemory1.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: hokuto.hokutoTriggerArrayKey)
//        hokuto.gameArrayData = hokutoMemory1.gameArrayData
//        hokuto.modeArrayData = hokutoMemory1.modeArrayData
//        hokuto.triggerArrayData = hokutoMemory1.triggerArrayData
        hokuto.bbHitCount = hokutoMemory1.bbHitCount
        hokuto.bbGameSum = hokutoMemory1.bbGameSum
        hokuto.bbBellNanameCount = hokutoMemory1.bbBellNanameCount
        hokuto.bbBellHorizontalCount = hokutoMemory1.bbBellHorizontalCount
        hokuto.bbBellCountSum = hokutoMemory1.bbBellCountSum
        hokuto.bbStartSet = hokutoMemory1.bbStartSet
        hokuto.bbCurrentSet = hokutoMemory1.bbCurrentSet
        hokuto.bbPlayGame = hokutoMemory1.bbPlayGame
        hokuto.voiceDefaultCount = hokutoMemory1.voiceDefaultCount
        hokuto.voiceShinCount = hokutoMemory1.voiceShinCount
        hokuto.voiceSauzaCount = hokutoMemory1.voiceSauzaCount
        hokuto.voiceJagiCount = hokutoMemory1.voiceJagiCount
        hokuto.voiceAmibaCount = hokutoMemory1.voiceAmibaCount
        hokuto.voiceKenCount = hokutoMemory1.voiceKenCount
        hokuto.voiceYuriaCount = hokutoMemory1.voiceYuriaCount
        hokuto.voiceCountSum = hokutoMemory1.voiceCountSum
    }
    func loadMemory2() {
        hokuto.normalBellNanameCount = hokutoMemory2.normalBellNanameCount
        hokuto.normalBellHorizontalCount = hokutoMemory2.normalBellHorizontalCount
        hokuto.normalBellCountSum = hokutoMemory2.normalBellCountSum
        hokuto.normalStartGame = hokutoMemory2.normalStartGame
        hokuto.normalCurrentGame = hokutoMemory2.normalCurrentGame
        hokuto.normalPlayGame = hokutoMemory2.normalPlayGame
        let memoryGameArray = decodeIntArray(from: hokutoMemory2.gameArrayData)
        saveArray(memoryGameArray, forKey: hokuto.hokutoGameArrayKey)
        let memoryModeArray = decodeStringArray(from: hokutoMemory2.modeArrayData)
        saveArray(memoryModeArray, forKey: hokuto.hokutoModeArrayKey)
        let memoryTriggerArray = decodeStringArray(from: hokutoMemory2.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: hokuto.hokutoTriggerArrayKey)
//        hokuto.gameArrayData = hokutoMemory2.gameArrayData
//        hokuto.modeArrayData = hokutoMemory2.modeArrayData
//        hokuto.triggerArrayData = hokutoMemory2.triggerArrayData
        hokuto.bbHitCount = hokutoMemory2.bbHitCount
        hokuto.bbGameSum = hokutoMemory2.bbGameSum
        hokuto.bbBellNanameCount = hokutoMemory2.bbBellNanameCount
        hokuto.bbBellHorizontalCount = hokutoMemory2.bbBellHorizontalCount
        hokuto.bbBellCountSum = hokutoMemory2.bbBellCountSum
        hokuto.bbStartSet = hokutoMemory2.bbStartSet
        hokuto.bbCurrentSet = hokutoMemory2.bbCurrentSet
        hokuto.bbPlayGame = hokutoMemory2.bbPlayGame
        hokuto.voiceDefaultCount = hokutoMemory2.voiceDefaultCount
        hokuto.voiceShinCount = hokutoMemory2.voiceShinCount
        hokuto.voiceSauzaCount = hokutoMemory2.voiceSauzaCount
        hokuto.voiceJagiCount = hokutoMemory2.voiceJagiCount
        hokuto.voiceAmibaCount = hokutoMemory2.voiceAmibaCount
        hokuto.voiceKenCount = hokutoMemory2.voiceKenCount
        hokuto.voiceYuriaCount = hokutoMemory2.voiceYuriaCount
        hokuto.voiceCountSum = hokutoMemory2.voiceCountSum
    }
    func loadMemory3() {
        hokuto.normalBellNanameCount = hokutoMemory3.normalBellNanameCount
        hokuto.normalBellHorizontalCount = hokutoMemory3.normalBellHorizontalCount
        hokuto.normalBellCountSum = hokutoMemory3.normalBellCountSum
        hokuto.normalStartGame = hokutoMemory3.normalStartGame
        hokuto.normalCurrentGame = hokutoMemory3.normalCurrentGame
        hokuto.normalPlayGame = hokutoMemory3.normalPlayGame
        let memoryGameArray = decodeIntArray(from: hokutoMemory3.gameArrayData)
        saveArray(memoryGameArray, forKey: hokuto.hokutoGameArrayKey)
        let memoryModeArray = decodeStringArray(from: hokutoMemory3.modeArrayData)
        saveArray(memoryModeArray, forKey: hokuto.hokutoModeArrayKey)
        let memoryTriggerArray = decodeStringArray(from: hokutoMemory3.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: hokuto.hokutoTriggerArrayKey)
//        hokuto.gameArrayData = hokutoMemory3.gameArrayData
//        hokuto.modeArrayData = hokutoMemory3.modeArrayData
//        hokuto.triggerArrayData = hokutoMemory3.triggerArrayData
        hokuto.bbHitCount = hokutoMemory3.bbHitCount
        hokuto.bbGameSum = hokutoMemory3.bbGameSum
        hokuto.bbBellNanameCount = hokutoMemory3.bbBellNanameCount
        hokuto.bbBellHorizontalCount = hokutoMemory3.bbBellHorizontalCount
        hokuto.bbBellCountSum = hokutoMemory3.bbBellCountSum
        hokuto.bbStartSet = hokutoMemory3.bbStartSet
        hokuto.bbCurrentSet = hokutoMemory3.bbCurrentSet
        hokuto.bbPlayGame = hokutoMemory3.bbPlayGame
        hokuto.voiceDefaultCount = hokutoMemory3.voiceDefaultCount
        hokuto.voiceShinCount = hokutoMemory3.voiceShinCount
        hokuto.voiceSauzaCount = hokutoMemory3.voiceSauzaCount
        hokuto.voiceJagiCount = hokutoMemory3.voiceJagiCount
        hokuto.voiceAmibaCount = hokutoMemory3.voiceAmibaCount
        hokuto.voiceKenCount = hokutoMemory3.voiceKenCount
        hokuto.voiceYuriaCount = hokutoMemory3.voiceYuriaCount
        hokuto.voiceCountSum = hokutoMemory3.voiceCountSum
    }
}


#Preview {
    hokutoViewTop()
}
